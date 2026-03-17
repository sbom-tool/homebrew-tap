class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  url "https://github.com/sbom-tool/sbom-tools/archive/refs/tags/v0.1.16.tar.gz"
  sha256 "03a121cb0edf042280264a81a896c96515139eaba9fb6f172e35c65068d8a528"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sbom-tools --version")

    # Verify it can parse a minimal CycloneDX SBOM
    (testpath/"test.cdx.json").write <<~JSON
      {
        "bomFormat": "CycloneDX",
        "specVersion": "1.4",
        "version": 1,
        "components": []
      }
    JSON
    output = shell_output("#{bin}/sbom-tools view #{testpath}/test.cdx.json --output summary")
    assert_match "CycloneDX", output
  end
end
