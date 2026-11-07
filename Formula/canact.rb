class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.12.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.4/canact-aarch64-apple-darwin.tar.xz"
      sha256 "07838d5d0d84e35ce1cb78a769627894c263173c7a20d24b431b23ce8b1d475c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.4/canact-x86_64-apple-darwin.tar.xz"
      sha256 "fcbcf8b6790446cdcfa1eef3d7f590f1f6536b4141d8b60842f6ee3290c6c56d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.12.4/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2b56b4ca868024884fcd835be16c452a59da697efbc8d736b7baa3657dbe7fb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.12.4/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93e231ec29e13797bf211cfa589f3793c9b3626e445be1ebd747821434657576"
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
