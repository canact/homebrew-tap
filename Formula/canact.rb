class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.10.1/canact-aarch64-apple-darwin.tar.xz"
      sha256 "74f6d4168313fd49824ceb64b3d5eb9fca53b1cb7ea3849fb787a1db087cd572"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.10.1/canact-x86_64-apple-darwin.tar.xz"
      sha256 "ef26aadd0cc1a5bced6ae7b0fcafc72a4c55275cdc106584fbdce36a074b67f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.10.1/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7de2636b4f45248122c9913eee941127d8ab2399a781c6066caa1ba3cd137629"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.10.1/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a447135c5957a3fad93926bb322ab4c1a787aa59bb51a7efb02ddb9e532534c2"
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
