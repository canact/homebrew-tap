# Homebrew tap for canact

Formulae for [canact](https://github.com/canact/canact). cargo-dist
pushes `Formula/canact.rb` on each public `vX.Y.Z` GitHub Release.

```bash
brew trust canact/tap
brew install canact/tap/canact
```

The formula downloads the matching prebuilt archive from GitHub
Releases. `cargo install canact --locked --features cli` is the
crates.io path and does not use this tap.

