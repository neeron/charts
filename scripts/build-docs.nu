#!/usr/bin/env nu

# Build documentation site with Zensical.
def main [] {
    let script_dir = $env.FILE_PWD
    let root_dir = ($script_dir | path join ".." | path expand)

    # Step 1: Sync chart READMEs
    nu ($script_dir | path join "sync-chart-docs.nu")

    # Step 2: Build documentation with Zensical
    print "==> Building documentation site with Zensical..."
    cd $root_dir

    uv run zensical build --strict

    print "==> Documentation built successfully in site/"
}
