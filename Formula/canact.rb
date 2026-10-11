class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.11.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "bca2fa847c9d152f66d2348dd9415b8ee14f6d2c7abf678cb8160d26b8f6cabc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.11.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "1dae5dee2c2e2d8a02078b78bb94f29185c5965affdf9f9d84433638c1e46bd6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.11.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "afe12d0c73e87fd205f588e5960f360c5cb8624fd6a52d27f59e534304e81f45"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.11.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "121476f932f66d0284a45f1e46e81d675e06143af559e3f6efff49a79f1b6c2f"
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
