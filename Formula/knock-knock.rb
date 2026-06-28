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
  version "0.2.3"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "ae9b3aa4c2f418d7c5148055508af6a6ed8f43c33f8e7d1ff2d38a0bf0ee5a9a"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "d26b6774d04816baed465975ef07743d2c059f11b7c71b1b94bcb3fb34ab7237"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "ceae66ce00e83f7dec2274e136c12bba7d85971bd64ba1e7336f95444963f7e9"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "8371c510be5d2f342bb3ca556ed3881dfaac849784fac2d132e62f4a16b682d7"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
