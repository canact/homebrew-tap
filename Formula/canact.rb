class Canact < Formula
  desc "Probe an LLM and return host policy: max tools, edit format, XML fallback, JSON repair"
  homepage "https://github.com/canact/canact"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.9.0/canact-aarch64-apple-darwin.tar.xz"
      sha256 "6353cac8076309042349603153b29c19e05415fdbe4da37dae800a5e0921fbd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.9.0/canact-x86_64-apple-darwin.tar.xz"
      sha256 "ef0efb34995571cf7d557636b36d5769fc0ba0319f4d901bb2d86e8ca7fbb417"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/canact/canact/releases/download/v0.9.0/canact-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "794c3c6e747502109ef3de6bb2af36d561f26c43200e54386f050d0f0864b9f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/canact/canact/releases/download/v0.9.0/canact-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0c80a98e968c2ed85394b7a95aa891e50e5abe82c869a9e102bf4f0577c8fdbd"
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
