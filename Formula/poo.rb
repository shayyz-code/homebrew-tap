class Poo < Formula
  desc "Tiny interpreted language written in Rust"
  homepage "https://github.com/shayyz-code/poolang"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.7/poo-aarch64-apple-darwin.tar.xz"
      sha256 "89049a22ec7345451c818532265381bb98b1bf91a6d1fee1ac5d54048ee25081"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.7/poo-x86_64-apple-darwin.tar.xz"
      sha256 "6f024fedab1695816651352101f4bd75886f1832bee77316bce9a7419d1d2c6e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.7/poo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f32f679deca8a001cf7776dc0dc62012e73407cd00726fa07277bdc40b0d2127"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.7/poo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3960f973216c169eae2b1f5fac872ae76448f347da8c6e7d1944614e628eda5d"
    end
  end
  license "MIT"

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
    bin.install "poo" if OS.mac? && Hardware::CPU.arm?
    bin.install "poo" if OS.mac? && Hardware::CPU.intel?
    bin.install "poo" if OS.linux? && Hardware::CPU.arm?
    bin.install "poo" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
