# pkgchk-action

A Github action to run .net package dependency checks, and display results in a Github pull request.

This action uses a Docker image from [pkgchk-cli](https://github.com/tonycknight/pkgchk-cli) to run scans and build Github reports.

:warning: This action only works with .Net SDK 7.0.200 or higher. Check your `global.json` and other settings!

## How to use

Your repository `Workflow permissions` settings should give `Read and write permissions` to the `GITHUB_TOKEN`.

Once done, simply include the action in your workflow, for example:

```yaml
- uses: actions/checkout@v3

- name: Run SCA
  uses: tonycknight/pkgchk-action@v1.0.5
  with:
    project-path: src/testproj.csproj    
```

## What the options mean

The main options you'll need to provide are below. Most options have defaults applied, giving scans for high to critical vulnerabilities.

| The option  | What's it for?  | What's the default? |
| - | - | - |
| `project-path` | The relative path to the solution or project | None - this is a mandatory value. |
| `dependencies` | Include dependencies in the scan | `false` |
| `deprecated` | Include deprecated packages in the scan | `false` |
| `vulnerable` | Include vulnerable packages in the scan | `true` |
| `transitives` | Include transitive packages in the scan | `true` |
| `fail-on-critical` | Fail scans if critical severity vulnerabilities or deprecation reasons are found | `true` |
| `fail-on-high` | Fail scans if high severity vulnerabilities are found | `true` |
| `fail-on-moderate` | Fail scans if moderate severity vulnerabilities are found | `false` |
| `fail-on-legacy` | Fail scans if packages are found to be deprecated for legacy reasons | `false` |


Some options are available to control the action's credentials, tracing, etc. You shouldn't need to use this in most cases.

| The option  | What's it for?  | What's the default? |
| - | - | - |
| `githubtoken` | A github token to push reports to PRs | `github.token` |
| `repo` | The repository name in `owner/repo` form | `github.repository` |
| `github-title` | The title to give to the PR report | `Package vulnerabilities` |
| `prid` | The pull request ID | `github.event.number` | 
| `trace` | Output trace logging to the console | `false` |


## Some examples

### What's the minimum I need?

You'll need to first `checkout` the repository. The default options will scan for High and Critical vulnerabilities; deprecated paackages and full dependency trees are ignored.

```yaml
- uses: actions/checkout@v3

- name: Run SCA
  uses: tonycknight/pkgchk-action@v1.0.5
  with:
    project-path: src/testproj.csproj    
```

### I want to scan for every possible problem

Simple: ensure `vulnerable`, `deprecated` & `transitives` are `true`, that `dependencies` is false, and all the `fail-on-` options are also `true`:

```yaml
- uses: actions/checkout@v3

- name: Run SCA
  uses: tonycknight/pkgchk-action@v1.0.5
  with:
    project-path: src/testproj.csproj    
    vulnerable: true
    deprecated: true
    transitives: true
    dependencies: false
    fail-on-critical: true
    fail-on-high: true
    fail-on-moderate: true
    fail-on-legacy: true
```

### I just want a report on the dependency tree

Just set `vulnerable` and `deprecated` to `false`, set `dependencies` to `true`, and give a distinct title:

```yaml
- uses: actions/checkout@v3

- name: Run SCA
  uses: tonycknight/pkgchk-action@v1.0.5
  with:
    project-path: src/testproj.csproj    
    dependencies: true
    vulnerable: false
    deprecated: false
    transitives: true
    title: Dependency scan
   
```

This will give you a separate PR report just for dependencies, as well as any vulnerability scans you might also want.

## Licence

`pkgchk-action` is licenced under MIT.
For `pkgchk-cli` refer to [its own licencing](https://github.com/tonycknight/pkgchk-cli).

