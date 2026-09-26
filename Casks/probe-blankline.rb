# frozen_string_literal: true

cask "probe-blankline" do
  version "0.0.1"
  desc "Probe: magic comment followed by a blank line"
  homepage "https://github.com/peasant-labs/homebrew-tap"
  url "https://example.invalid/probe.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  name "probe-blankline"
  livecheck do
    skip "Probe only."
  end
end
