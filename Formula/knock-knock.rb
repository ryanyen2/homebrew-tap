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
  version "0.2.4"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "b2f57c381f407e7441a31ccf644e73f4e12a35c3a1c785060079db1371ab8324"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "2ec16300d512b7e1b09b35b27b067d5783b70c6e191f42c15e232abeb16e52cd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "caece452e840113c947c024acc3f45610dd0211cfb489fad31fd3229ecbb99e1"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "d0763dfcaae7bdf794d244ea94ac77b84d59b3601354aa07829c1cb70d65f57e"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
