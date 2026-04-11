class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  # URL pinned to immutable commit SHA (not mutable tag) for supply chain safety
  url "https://github.com/sbom-tool/sbom-tools/archive/057fa6bb983378c3c7e41f57292bb82c64621896.tar.gz"
  version "0.1.19"
  sha256 "70e9dfafe80a566489a24e51a6bea816a0f43f5a7fcb72567e3f0e6419052786"
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
