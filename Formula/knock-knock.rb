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
  version "0.1.1"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "5dbc698ba36a25d3c46e903a6e1163cd8b6e15e953a006790b2dd571e0fd63e0"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "84b1423d3af771be07d9c85a9112befe15b09ad475f950fcbbf96e42e04f2d13"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "6366431bb83c1a86ab9fb51e3f63e6633f039fad6aee18784080b83e33317617"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "b99b102fa4b4733c25c46b1c5a729d8aaea2182caed7f900c5e50ffa233155ce"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
