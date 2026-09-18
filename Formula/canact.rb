class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.7.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "b186fcb9490dce3a56c99b0107242a6abe8539258a8229a750f772df2277bab1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.7.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "868fb86e44d8662b88ef39fcd446e91ff305ba7fe398913ea0ef59569f79f31c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.7.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b9ff4263346e670f0ee42d7436d88257e9cec9fcfbc2650ab4174a806f901582"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.7.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "859db94a5e02edd97a50753c57fc64bd1dd11061f914bdceb275cdb611bb9c3a"
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
