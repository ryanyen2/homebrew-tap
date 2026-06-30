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
  version "0.2.6"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "95b283635ccc73b401f5cd19dd1d73ea9012d200dcac56544f45a685a1f691ee"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "fdee9d84799710b284e5407439c232c0ce869caf11ec694010288dc6821cb5ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "544671735b1951f1309f4c48a997341e9adce5c642b17787339e5e469e749923"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "7cf195564e56398cee7dcf159be6320b24000d7df0ae46ce2146d7a8becb1af2"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
