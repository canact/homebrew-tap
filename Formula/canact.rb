class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.4.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "9182bd2c79eebabd398f70e230d8976f3a2fd27d858811c3fba9db53521eda50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.4.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "b0e082ba24641687dfce3e8682836e2d6e015492f0316faabf36d49b50bb4798"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.4.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6bba09c367f132ac4c930a11fa79fa1c45b1c7f3ccc336fc65926115e777c57f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.4.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "98111e44bfa55e9cb9193866cc275be41d1023ba8915adb5b20404bd1f1f26e3"
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
