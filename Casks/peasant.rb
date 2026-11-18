# frozen_string_literal: true

# This file is rendered by .github/workflows/publish-cask.yml from the latest
# final Peasant release. DO NOT EDIT: change templates/peasant.rb.tmpl instead.
cask "peasant" do
  version "0.21.0"

  on_macos do
    on_arm do
      sha256 "f3fe7121c50da25379251cf8d74fb50f14faad697be9c76f72dc1c96ad40c481"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "33bacb37b7744f0dc28e128b7e39ac48de84f7d145d1e11c61207ce43837b1ef"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "7882d68fa4b97815812da2faa68d11bf15ca6ac83e0d9ac8927eac7f48f0847f"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "6eb4df31459373395e334711eb8fbf0a9a1e8c7c650014908f5330018f9f3f69"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_linux_amd64.tar.gz"
    end
  end

  name "peasant"
  desc "Agent-session ingest, analytics, and publishing CLI"
  homepage "https://github.com/peasant-labs/peasant"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "peasant"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "peasant"], chdir: "."
    end
  end

  zap :not_required
end
