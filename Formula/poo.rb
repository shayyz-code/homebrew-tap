class Poo < Formula
  desc "Tiny interpreted language written in Rust"
  homepage "https://github.com/shayyz-code/poolang"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.8/poo-aarch64-apple-darwin.tar.xz"
      sha256 "d90c93e976013126f0816122f99326d3e9aad06c296305959759c1f83f614a1a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.8/poo-x86_64-apple-darwin.tar.xz"
      sha256 "2cae4443d8ca31207dec2f868503a6c9a02b9ba55994c4aebc7a577688ac6908"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.8/poo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b94e82bf30d29dfa2f21e0f5ae8df2857b0feb6a9d245c896d9163eef1ce0c51"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shayyz-code/poolang/releases/download/v0.1.8/poo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "42ca140f506743d3abef8b99fdd6b516a82e48b917e4172636db5d0ec3ae7963"
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
