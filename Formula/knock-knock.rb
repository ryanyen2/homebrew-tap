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
  version "0.2.0"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "b4cab29b6d5b99dfcaa260597e620a93d3fdd919fc26b0d722217c205f1a626a"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "d476c7d8ec1d7e4d08a119f63e1ccaa9ceb3b6d39422057db5324f724e63982a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "1c81942e5539ecedf588e05d91a3fd4fdbea90487ec9a31d8d797cda45e2016f"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "5c3bcfa56059a8d0e6c94d68ddabc505b5e215d9f11d9039e8c6f00324d390d9"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
