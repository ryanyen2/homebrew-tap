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
  version "0.2.1"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "86b8d12408c4fdf6907e4325a58c46c46b4f862d48eddb0266fd415bfb6e7857"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "a445164b3e5535a90611cc85f1cd451331a8206dacbc691a375b670f710b25e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "17649cac9d4b8d3a5d45a73df165863aa563f894121ac5e5c3b9e4edfe3920d7"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "71ee16225dd6dae30e4d076f25b927b4eebffb0322f58740e6840e73fc49b133"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
