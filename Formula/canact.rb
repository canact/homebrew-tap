class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.12.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.7/canact-aarch64-apple-darwin.tar.xz"
      sha256 "1f7ad56679209fa34738d2e699d35cdf448e6f1f01bdbf959ffa2e1094d8cc5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.7/canact-x86_64-apple-darwin.tar.xz"
      sha256 "8377db158482283736fc82f804828ffbaf31634fcd74798ea225b2ff76ad6cc6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.7/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "934195bbd0c911553b2250f6284c62b9aeeedd2468a161a73dffa755e5017c3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.7/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "22474ebb86247500c56d884cc2c78eb46e9d22fe811987de16e99c6403a5bfa5"
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
