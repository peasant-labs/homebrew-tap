# Peasant Homebrew Tap

This repository is the Homebrew tap for [Peasant](https://github.com/peasant-labs/peasant).

Peasant publishes its macOS package as a **cask**. The tap renders it from `templates/peasant.rb.tmpl` in `.github/workflows/publish-cask.yml`, which polls the latest **final** Peasant release every fifteen minutes and audits the result before committing. Release candidates (`-rcN`) never update this tap.

Peasant holds no credential for this repository. The publisher reads the release's public `checksums.txt` and pushes with this repository's own workflow token.

## Install

```bash
brew tap peasant-labs/tap
brew install --cask peasant
peasant version
```

Homebrew selects the right binary for your CPU (Apple Silicon or Intel) automatically. The cask runs a post-install hook that clears the macOS download-quarantine attribute, so the binary runs immediately — no Gatekeeper prompt.

Update and remove:

```bash
brew update && brew upgrade --cask peasant
brew uninstall --cask peasant
```

## Brewfile

To manage the tap and cask declaratively with `brew bundle`, add this to your `Brewfile`:

```ruby
tap "peasant-labs/tap"
cask "peasant"
```

Running `brew bundle` then makes Homebrew converge the machine to that state: the tap is present and the cask is installed.

## Repository layout

```text
Casks/peasant.rb                  the published cask
templates/peasant.rb.tmpl         the reviewed template the publisher renders
scripts/render-cask.sh            template + release checksums -> cask
.github/workflows/publish-cask.yml  the scheduled publisher
```

`Casks/peasant.rb` is rendered and updated by the tap publisher. Do not edit it by hand: change `templates/peasant.rb.tmpl` (or the render script) and the next run publishes the new shape. The publisher fails closed when the release checksums are missing an expected archive, when a digest is malformed, or when a template placeholder is unresolved.

A CI workflow (`.github/workflows/lint-cask.yml`) guards the cask for human changes: `brew style` on Linux and `brew audit --cask` on macOS (the audit is known-broken on Linux). The scheduled publisher runs the same audit before it pushes; a push made with the workflow token does not trigger workflows, so the pre-push audit is the gate for bot updates. Both checks no-op while `Casks/` is empty.
