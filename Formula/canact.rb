class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.12.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.6/canact-aarch64-apple-darwin.tar.xz"
      sha256 "8bb082cd95d4b3477575aa8e9db7ad30a6bf7c4f2554dfe79d62b78fc299fd2a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.6/canact-x86_64-apple-darwin.tar.xz"
      sha256 "27849809bab096e40379f4e74d0881e7da15755111ea139efe5052923b5d60df"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.6/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a06871b69cbc5c41e5104ef09225a676759b76f608ff96f5290152606bdef1f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.6/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "252b4f71f0261e3619f2f26ca28b4ed86798afc81ff2f1f18553e6142f629289"
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
