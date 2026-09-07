class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.1.1/canact-aarch64-apple-darwin.tar.xz"
      sha256 "4433ccaed522a8f901d7a047045ae9efa79058d61b53ab751e111f431bd5d760"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.1.1/canact-x86_64-apple-darwin.tar.xz"
      sha256 "643fe837a8fde82a92215ab06de64806b45c788957a8e3eaa2fc8d1394974e5e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.1.1/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "31b14cc2e6b45898363b481e2c0576d8d70acda7870a9ed8c276adf529a73789"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.1.1/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3f2e69af3ac6f8abf5d7780e82314fdba31be1b09e70182bb28ce4dcdb86952d"
    end
  end
  license "Apache-2.0"

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
