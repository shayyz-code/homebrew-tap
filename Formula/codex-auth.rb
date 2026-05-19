
> @shayyz-code/codex-auth@0.1.4 generate:homebrew-formula
> node npm/homebrew-formula.js v0.1.4 dist

class CodexAuth < Formula
  desc "Manage named Codex auth snapshots"
  homepage "https://github.com/shayyz-code/codex-auth"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.1.4/codex-auth-darwin-arm64"
      sha256 "954a024baaf9e8a7e97f8fff5a440c414af9fa0387c54ad8c3e18804d210bcb4"
    else
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.1.4/codex-auth-darwin-amd64"
      sha256 "e15fd0a105377ab4a1a80f8625ef2537937cf6e5d9e6a607e3403b318a838e18"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.1.4/codex-auth-linux-arm64"
      sha256 "63f2657b807659f34874d5006d4a1fe5c27641a64a6b6ee71c8b559e162cec0f"
    else
      url "https://github.com/shayyz-code/codex-auth/releases/download/v0.1.4/codex-auth-linux-amd64"
      sha256 "07072b3f7eb5103f4dbb01aa9c0fbfbaee86efca1b0332aa070e8062af9c4b2d"
    end
  end

  def install
    bin.install Dir["codex-auth-*"].first => "codex-auth"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codex-auth --version")
  end
end
