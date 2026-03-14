class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  url "https://github.com/sbom-tool/sbom-tools/archive/refs/tags/v0.1.14.tar.gz"
  sha256 "0a160a15b5c3f386446a851fa99932428e4ff9f50d26f6a36dab4b0ba12f9fbc"
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
