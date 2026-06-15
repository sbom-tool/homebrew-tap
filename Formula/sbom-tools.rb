class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  # URL pinned to immutable commit SHA (not mutable tag) for supply chain safety
  url "https://github.com/sbom-tool/sbom-tools/archive/dea7853b2845100df02baa6f078dfe2b057e85d7.tar.gz"
  version "0.1.22"
  sha256 "8d3bb5a2d317bf942959b235a95ebccaa98367b3156b555d24d3b7cf4ae3f29d"
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
