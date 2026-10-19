# neeron/charts

Thrown together, maintained (probably) Helm Charts.

## Installation

### OCI Artifacts (Recommended)

```bash
helm install my-app oci://ghcr.io/neeron/charts/<chart-name> --version <version>
```

### HTTP Repository

```bash
helm repo add neeron https://charts.neeron.me
helm repo update
helm install my-app neeron/<chart-name> --version <version>
```

## Development

### Initial Setup

You need [mise](https://mise.jdx.dev/) installed.

```bash
mise install # Install tools
hk install # Install git hooks
```

### Commands

```bash
mise run fmt-check # Check code formatting
mise run fmt # Format files
mise run lint # Lint
mise run docs # Build documentation
mise run serve-docs # Preview documentation locally
```

## Releases & Versioning

Releases are automated via [Release Please](https://github.com/googleapis/release-please). Each chart is versioned independently.

## License

Charts in this repository are licensed under CC0 1.0 Universal (unless otherwise specified - forks of charts may be licensed differently). See [Creative Commons](https://creativecommons.org/publicdomain/zero/1.0/) for details.

Supplementary code in this repository is licensed under AGPLv3. See the [LICENSE](LICENSE) file for details.
