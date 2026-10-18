#!/usr/bin/env nu

# Sync chart README files into the documentation directory.
def main [] {
    let script_dir = $env.FILE_PWD
    let root_dir = ($script_dir | path join ".." | path expand)
    let docs_charts_dir = ($root_dir | path join "docs" "charts")
    let charts_dir = ($root_dir | path join "charts")

    mkdir $docs_charts_dir

    print $"==> Syncing chart documentation to ($docs_charts_dir)..."

    if ($charts_dir | path exists) {
        for chart in (ls $charts_dir | where type == dir) {
            let chart_name = ($chart.name | path basename)
            let readme_path = ($chart.name | path join "README.md")
            if ($readme_path | path exists) {
                print $"  -> Copying ($chart_name)/README.md to docs/charts/($chart_name).md"
                cp -f $readme_path ($docs_charts_dir | path join $"($chart_name).md")
            } else {
                print $"  [WARN] ($chart_name)/README.md not found, skipping."
            }
        }
    }

    print "==> Chart docs sync complete."
}
