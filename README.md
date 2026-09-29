# dev-env-flakes

Starter profiles for [dev-env](https://github.com/lllama/dev-env): one flake per
profile, each exposing a single `packages.<system>.default` (a `buildEnv` of the
package set) — exactly what `dev-env create --env <profile>` consumes (ADR-0003).

## Starters

| dir        | contents |
|------------|----------|
| `base/`    | git, curl, jq, ripgrep, fd, vim, jujutsu (jj) |
| `go/`      | go, gopls, gofumpt, delve + base floor |
| `python/`  | python3, uv + base floor |
| `opencode/`| opencode, gh + base floor |

Packages only — no dotfiles, no shell rc, no secrets (ADR-0003 scope).

## Using one

```toml
# ~/.config/dev-env/config.toml
[profiles]
go = "github:lllama/dev-env-flakes?dir=go"
```

```bash
dev-env create mybox --env go
```

The flake is fetched **inside** the container at create; the committed
`flake.lock` pins nixpkgs (`nixos-26.05`), so creates are reproducible until
the lock is bumped.

## Evolving

Bump a lock (needs nix anywhere): `cd <dir> && nix flake update && git commit`.
Existing containers are untouched — dev-env v1 re-applies only at create
(evolution = destroy + create).

## Copying a starter

Starters are meant to be forked: copy the directory, edit `paths`, point your
own config at it.

## Go version note

The `go` starter uses `go_1_27` (not the `go` attr): nixpkgs keeps the default
`go` attribute one release behind during a branch's lifetime (26.05 ships
`go` 1.26.7 but `go_1_27` 1.27.1). The attr stays within the same locked
input — bump it when a new Go line becomes the branch default.

## Python version note

Same promotion lag as Go: the `python` starter uses `python314` (not `python3`):
26.05's default `python3` is still 3.13; `python314` is 3.14.x. Bump when the
branch default moves.
