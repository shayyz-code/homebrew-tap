
> codex-su@0.1.3 generate:homebrew-formula
> node npm/homebrew-formula.js v0.1.3 dist

class CodexSu < Formula
  desc "Manage named Codex auth snapshots"
  homepage "https://github.com/shayyz-code/codex-su"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/codex-su/releases/download/v0.1.3/codex-su-darwin-arm64"
      sha256 "2de030007d2f92d7344f8a26c4583ed85bf3142bed7cf4e526ece0ccdb38f8cb"
    else
      url "https://github.com/shayyz-code/codex-su/releases/download/v0.1.3/codex-su-darwin-amd64"
      sha256 "f698f4c115c40cecc8d1088bf59e95a0c667c32492e59fb60fc0dae30edc6577"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shayyz-code/codex-su/releases/download/v0.1.3/codex-su-linux-arm64"
      sha256 "4a48a0d5ee6a4ae45c9712c58c7ab6d853cefd148a93e6847b2b8b6519f42b9c"
    else
      url "https://github.com/shayyz-code/codex-su/releases/download/v0.1.3/codex-su-linux-amd64"
      sha256 "5a6e1ec42f265d47fbcd47d6e05b313bc504d7051c6dcae245cbf3588e0ec58f"
    end
  end

  def install
    bin.install Dir["codex-su-*"].first => "codex-su"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codex-su --version")
  end
end
