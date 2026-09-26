# frozen_string_literal: true
cask "probe-with-comment" do
  version "0.0.1"
  desc "Probe: cask that carries the magic comment"
  homepage "https://github.com/peasant-labs/homebrew-tap"
  url "https://example.invalid/probe.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  name "probe-with-comment"
  livecheck do
    skip "Probe only."
  end
end
