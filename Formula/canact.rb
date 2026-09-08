class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.1.2/canact-aarch64-apple-darwin.tar.xz"
      sha256 "4c9e22ffc01a43e76ae0770517baaa2703fbb89095299583958064fe1df61962"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.1.2/canact-x86_64-apple-darwin.tar.xz"
      sha256 "a76727bd073523ee449901f39250c3d5b4ccb78f070b8014398c6ca3b1ed0eb7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.1.2/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c18f7fe9998827ce85b989998248fe0ffb5e95f570f3f161138d4fa12fe87e5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.1.2/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f3d747653dfd0bdd462a793801fdf6ed9a59b98314d7a003299a8410e6e04891"
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
