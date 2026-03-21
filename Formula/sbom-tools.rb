class SbomTools < Formula
  desc "Semantic SBOM diff and analysis tool"
  homepage "https://github.com/sbom-tool/sbom-tools"
  # URL pinned to immutable commit SHA (not mutable tag) for supply chain safety
  url "https://github.com/sbom-tool/sbom-tools/archive/207c562743e31c90eb00c395c0d4f84d4a27027e.tar.gz"
  sha256 "197da9c76ab63426415872af108c04e9584f5b0ed585f8bf3d9342702a59e7a6"
  version "0.1.17"
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
