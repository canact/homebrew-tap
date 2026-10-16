class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "0ba2d514d12e8f2acd9c72ccda341fc11d4404244b519ea474eaaf36822d2187"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "b487017f7efb8835e560e02acdfbb171e79337576078b60b90fe923f4e771785"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8397cdfbd0542392aada3755b03a277d157e920c4512ca178f4e6eccd2ad5879"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c5aa13c2b4c882a0fc4bf0bd782f6f4fce2df1c65a266c4ff45788e2bc40bb24"
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
