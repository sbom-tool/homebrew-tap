class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  url "https://github.com/sbom-tool/sbom-tools/archive/refs/tags/v0.1.15.tar.gz"
  sha256 "6ed170d167444adcfb6e55a88df46f3b33bc9c04748c40331509c3dab11452fc"
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
