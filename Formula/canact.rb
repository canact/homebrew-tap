class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.2.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "42793cde739cdf2831b8e2023008babdf50d7581e2f5fed50f1c3a60ad175348"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.2.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "ea307b70f0335af018048267664876fef1f72a707f655164d79c80ac3581c3fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.2.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3e2dd9774c76c1592a6f5ac83e4cf98be1a3121cbd28bb5de5f4a6e0d79fbc8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.2.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "17382ed28427b8dcd7bf6a1883305239529ba4262d2138ba6f47b7662d9662a5"
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
