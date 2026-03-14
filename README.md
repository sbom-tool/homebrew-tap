# Homebrew Tap for sbom-tools

Homebrew formulae for [sbom-tools](https://github.com/sbom-tool/sbom-tools) — a semantic SBOM diff and analysis tool.

## Installation

```sh
brew install sbom-tool/tap/sbom-tools
```

## Upgrading

```sh
brew update
brew upgrade sbom-tools
```

## Verification

Each release archive is signed with [Sigstore](https://www.sigstore.dev/) keyless signing and has [GitHub build attestations](https://docs.github.com/en/actions/security-for-github-actions/using-artifact-attestations/using-artifact-attestations-to-establish-provenance-for-builds).

### Verify a pre-built binary download

```sh
# Verify Sigstore signature
cosign verify-blob \
  --bundle sbom-tools-aarch64-apple-darwin.tar.gz.bundle \
  --certificate-identity-regexp 'https://github\.com/sbom-tool/sbom-tools/' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  sbom-tools-aarch64-apple-darwin.tar.gz

# Verify GitHub attestation
gh attestation verify sbom-tools-aarch64-apple-darwin.tar.gz \
  --repo sbom-tool/sbom-tools
```

## License

MIT
