# Homebrew formula for knock-knock.
#
# This is the source of truth that belongs in a tap repo named
# `homebrew-tap` (so users run `brew install <owner>/tap/knock-knock` — one
# `knock-knock`, not two).
# The release workflow (.github/workflows/release.yml) bumps `version` and the
# four `sha256` values from dist/SHA256SUMS.txt on each tagged release.
#
# It ships the prebuilt, Bun-embedded binary — there is no `bun` dependency for
# end users.
class KnockKnock < Formula
  desc "Collaborating coding agents over Discord, gated by your own allow/ask/deny rules"
  homepage "https://github.com/ryanyen2/knock-knock"
  version "0.2.5"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "611c4c10ce073869656caf2b2cdd2b2cd6da7e5bff29bc3fea618f09cb7d19b5"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "17759eb5532250405221428808a2c0ed713dcea8756c81134825704a31a15b8b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "a7e8203543dd61c5f2bb8a6811e39670511af769378b80db5f1a2614fa515072"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "cfd36b7471f9a5b27e6bd8c46f6f5d1b348c8732fc64beabd2ffb954daf613fe"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
