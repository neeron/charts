#!/usr/bin/env nu

# Check or update helm-docs.
# On Release Please PRs, if differences exist and a bot token is provided, auto-commit the result.
def main [] {
    let script_dir = $env.FILE_PWD
    let root_dir = ($script_dir | path join ".." | path expand)
    cd $root_dir

    print "==> Running helm-docs..."
    if (which helm-docs | is-empty) {
        print -e "Error: 'helm-docs' not found in PATH. Please ensure it is installed and available in your environment (e.g. via mise)."
        exit 1
    }

    let helm_docs_res = (do { run-external "helm-docs" } | complete)
    if $helm_docs_res.exit_code != 0 {
        print -e $helm_docs_res.stderr
        exit $helm_docs_res.exit_code
    }

    # Check for git changes in charts directory
    let status = (do { git status --porcelain charts } | complete)
    if ($status.stdout | str trim | is-empty) {
        print "==> helm-docs is up to date."
        return
    }

    let head_ref = ($env.GITHUB_HEAD_REF? | default "")
    let repo = ($env.GITHUB_REPOSITORY? | default "")
    let token = ($env.GITHUB_TOKEN? | default ($env.GH_TOKEN? | default ""))

    if ($head_ref | str starts-with "release-please") and ($token | is-not-empty) and ($repo | is-not-empty) {
        print $"==> Detected Release Please PR \(($head_ref)\) with outdated helm-docs. Auto-committing changes..."
        git config user.name "github-actions[bot]"
        git config user.email "github-actions[bot]@users.noreply.github.com"
        git add charts/**/README.md
        git commit -m "chore: regenerate helm-docs for release"

        # Explicitly configure auth header with the app token so git push has write permissions
        let auth = ($"x-access-token:($token)" | encode base64)
        git config --local "http.https://github.com/.extraheader" $"AUTHORIZATION: basic ($auth)"

        git push origin $"HEAD:($head_ref)"
        print $"==> Successfully committed and pushed updated helm-docs to ($head_ref)."
        return
    }

    print -e "helm-docs generated changes! Please run 'helm-docs' and commit the result."
    do { git status -s charts }
    do { git diff charts }
    exit 1
}
