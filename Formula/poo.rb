class Poo < Formula
  desc "Tiny interpreted language written in Rust"
  homepage "https://github.com/shayyz-code/poolang"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.5/poo-aarch64-apple-darwin.tar.xz"
      sha256 "5871ce1f87613fb577d3dbd4ee4e72efd98546a55a6033e9f129be8f0fe20f29"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.5/poo-x86_64-apple-darwin.tar.xz"
      sha256 "d81149d6a1400aa5d71446a16581ce7fd071c81a13f4a8b15182d542769964b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.5/poo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3bb4e613469a0424e3d6646d8cd3921cc87fa3e76d83dfa832c787a0e61ae7c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.5/poo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8deff8d56dfa286dff91c39f64be0999cbde6401512cc79634534bd604f16ae8"
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
