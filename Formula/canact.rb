class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.5.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "75de9fd97da7210cb83ef0948ced56d5d71a54d51eda1a46012bcc1678132b87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.5.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "b74b3ed783af0e03efe61e0437bed1b28c4c3f88c2e4c115b732a84f2b48b919"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.5.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "712ba200c59b6d980ed93c9688382077449148b0df2306297f6a2ae74927f620"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.5.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "003f2dcb651e8e576c6cbec58f4f524bcd71bd2b1cc64fc372f3dc04ec39de5b"
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
