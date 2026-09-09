class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.3.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "4a878a49f31b45fac50765a329a072a3c4d53a580289b426e691c3bf7a4409fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.3.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "d3a30c8fa6df9e0433fa888ccce9ed3fb35af8487cc8f9ace6869d7156fbdba9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.3.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5811253085e6473b73d53aff4917059cb955c9a5196a95e36fc8beb36c92ae9e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.3.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c99411ecb197cdc86b88149d90e59a9a072b1dc66120de0c2512b10881ed336"
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
