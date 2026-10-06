class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.10.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "4599fdf2f557286c9964f21e2aac823eb06ed81b8517f8290b30088090f0ca4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.10.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "35dfa4897a26b4fd8de4c76a4c3dba0eb711df721a809b95562e5a1e1d113726"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.10.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "12185d69def88424d1b8ea2ba51d81a1faefdd3ff645bdf8e07aba1b555fa847"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.10.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f12d2189c2ce53047005fc304734e102df7e392ee8c793d75165692f051aaaac"
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
