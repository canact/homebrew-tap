class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.12.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.1/canact-aarch64-apple-darwin.tar.xz"
      sha256 "c90a68fe86cf560f7374a0c31c0f9097196da24b4cabc8933d796c4c00943242"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.1/canact-x86_64-apple-darwin.tar.xz"
      sha256 "2de3ef2663c56cfea811ef4b63939989a4d6b829d8174136f346cd36288164fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.1/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca1acff49b7e6773098739ba7bd38fc47a346d8f54b2ebe9a09d0a483658c0d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.1/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3dac1ef68e413344c70c3bd175994796ca33456cfedfb958f1ca2bd6e8302d87"
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
