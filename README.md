# Homebrew Tap for sbom-tools

Homebrew formulae for [sbom-tools](https://github.com/sbom-tool/sbom-tools) — a semantic SBOM diff and analysis tool.

## Installation

```sh
brew install sbom-tool/tap/sbom-tools
```

Homebrew builds from source and verifies the source tarball SHA256 automatically. No manual verification is needed.

## Upgrading

```sh
brew update
brew upgrade sbom-tools
```

## Verifying pre-built binary downloads

If you download pre-built binaries from [GitHub Releases](https://github.com/sbom-tool/sbom-tools/releases) instead of using Homebrew, each archive is signed with [Sigstore](https://www.sigstore.dev/) and has a [GitHub build attestation](https://docs.github.com/en/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds):

```sh
# Verify Sigstore signature (replace version tag)
cosign verify-blob \
  --bundle sbom-tools-aarch64-apple-darwin.tar.gz.bundle \
  --certificate-identity 'https://github.com/sbom-tool/sbom-tools/.github/workflows/publish-crates.yml@refs/tags/v0.1.14' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  sbom-tools-aarch64-apple-darwin.tar.gz

# Verify GitHub attestation
gh attestation verify sbom-tools-aarch64-apple-darwin.tar.gz \
  --repo sbom-tool/sbom-tools
```

## License

MIT
