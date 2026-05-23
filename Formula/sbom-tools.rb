class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  # URL pinned to immutable commit SHA (not mutable tag) for supply chain safety
  url "https://github.com/sbom-tool/sbom-tools/archive/063fcc1fd5da2961ccec7e300c1e682416a06b3d.tar.gz"
  version "0.1.21"
  sha256 "826fac21aad325ff218de2fe83a8d386b12132b57c4244b06801b2ece9de13ad"
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
