
> @shayyz-code/codex-auth@0.2.1 generate:homebrew-formula
> node npm/homebrew-formula.js v0.2.1 dist

class CodexAuth < Formula
  desc "Manage named Codex auth snapshots"
  homepage "https://github.com/shayyz-code/codex-auth"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.2.1/codex-auth-darwin-arm64"
      sha256 "798bce725017301a539d96e09c6594f0ddac3fb63a09733f4a75756eb675e92f"
    else
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.2.1/codex-auth-darwin-amd64"
      sha256 "2ac9a3340f50d5948feec68cdc7053518a6e04ccc9d2035531544b9a93c5e05b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.2.1/codex-auth-linux-arm64"
      sha256 "d04b218db6d6321e0a03b9b28d67e2f90b7acc149037433b80b876e0c4144ecf"
    else
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.2.1/codex-auth-linux-amd64"
      sha256 "5464b206d1bd8fc7a57db4bd403f0d39d73f5c4c7c9518113b4f6780edb3e8ef"
    end
  end

  def install
    bin.install Dir["codex-auth-*"].first => "codex-auth"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codex-auth --version")
  end
end
