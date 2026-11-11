class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  # URL pinned to immutable commit SHA (not mutable tag) for supply chain safety
  url "https://github.com/sbom-tool/sbom-tools/archive/7fe05e139f7626f4871595661a712dc92166592a.tar.gz"
  version "0.4.0"
  sha256 "41d510f2bb12dfc722943114da277683c716fbd0b2d8772a740d46320980530c"
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
