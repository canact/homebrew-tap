class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.10.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.10.2/canact-aarch64-apple-darwin.tar.xz"
      sha256 "e4acc11af9910ca8e955ac865fd0b65ac70c11df990f8ae018b1072f2e253de1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.10.2/canact-x86_64-apple-darwin.tar.xz"
      sha256 "92a990eefa7375c5fe9ef45b822ef82f95aa15cfb83f3bf022215534fc301244"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.10.2/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f964f0833fa6075cedd5a0623c01ef9fc8f0099d7b1e164000329f0de01587fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.10.2/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "69543fa5613e6af69cc53866217530ca9167028f7abac17a6f343f24a3e28656"
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
