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
  version "0.3.0"
  license "MIT"

  BASE = "https://github.com/ryanyen2/knock-knock/releases/download/v#{version}".freeze

  on_macos do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-darwin-arm64"
      sha256 "076750fa43905aa8293118a79eb7ced625e12d1d7f0c8a6695eafc50610de286"
    else
      url "#{BASE}/knock-knock-darwin-x64"
      sha256 "f8a7e1aef2ba30256c1cf95e3f81646baec484a1f74b6869333442bf8ef48cfb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{BASE}/knock-knock-linux-arm64"
      sha256 "28cce35ff7909089c66e037781a0298714071be66f6c214ccecbf9059d88347a"
    else
      url "#{BASE}/knock-knock-linux-x64"
      sha256 "a74cbd9ea6b770a58fe2f0dab8a839518174f40c08705f7958a33391abfcd4b7"
    end
  end

  def install
    bin.install Dir["knock-knock-*"].first => "knock-knock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/knock-knock --version")
  end
end
