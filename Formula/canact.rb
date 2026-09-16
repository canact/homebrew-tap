class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.6.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "dfa0054ce662db65df923087c6efed4e48e0ef581c732ce54eecdbf709353934"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.6.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "099eb21ca433da0b757c544810415b9e064b198679736afb1652f583f3a5a4fe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.6.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91e19f3ef11b9948ba5d4974255118d190f8d2a7efe023e6c2f99e3f7f312326"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.6.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b38f987d74b030f622c9044d713f611c4d709830129b32cbd3b6ae6d3970b0a8"
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
