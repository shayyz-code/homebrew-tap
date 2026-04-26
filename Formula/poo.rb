class Poo < Formula
  desc "Tiny interpreted language written in Rust"
  homepage "https://github.com/shayyz-code/poolang"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.10/poo-aarch64-apple-darwin.tar.xz"
      sha256 "b6311854f61221fcac4f6ee97a5b337b641ec4b0a2a1a8c5bf1ee25983486e66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.10/poo-x86_64-apple-darwin.tar.xz"
      sha256 "ff5379e5706957abc182b325c38729c5cb39a544f4464ecfb6cea6c071f63239"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.10/poo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3ab7bf071a69b4a2c3ca45b7d1c474aa888b8b959e55ea391e84751f5461e868"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.10/poo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "502e9948449490a50b3ac0a0a0b89a3ef15dd56c51f10e8f3729583339bf008e"
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
