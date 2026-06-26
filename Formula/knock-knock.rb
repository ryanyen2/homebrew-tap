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
  version "0.1.2"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "6c04419d3095a2c7099fd71b430870c99dea871416f62609460b837852972512"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "ed2efa5428c4cc17d266eede9ff97e6d65004fcaa58faaab0fd626194f2e9e1e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "7af5aca5f7ad932abc5d086197d0f63a8b72d176f8a515468b0ade968d2efdbf"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "224daf82f60dceb3fe9fe55b734f86a57bceb6543955fa8ec501aa94a38b1883"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
