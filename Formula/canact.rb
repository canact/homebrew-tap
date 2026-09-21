class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.8.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "0c1e8442b11fb935cd9591dfac15c2aaca476da9f06911b4114f7536e8594990"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.8.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "8ec6a1e822db9bc27b6cbe4ffa76a46400e99bcd39a99b84db061e6690e2479c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.8.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bfa66bb58920c955f97830d776225e8d3eb3ae7a986fa699bd881eebc0fe7600"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.8.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf56142a63814aade92f8655c74ce69f4b741897756ba829901dfa4367fc001e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "canact"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "canact"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "canact"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "canact"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
