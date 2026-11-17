# frozen_string_literal: true

# This file is rendered by .github/workflows/publish-cask.yml from the latest
# final Peasant release. DO NOT EDIT: change templates/peasant.rb.tmpl instead.
cask "peasant" do
  version "0.18.2"

  on_macos do
    on_arm do
      sha256 "6bd43c7b5bccdc702a63ff4bba6b4d487818187bb40c6a9ee055235c0d044b53"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "1e30b53eca9cd6c11198c11db3f48ad1c4a5fa70a7482c71c2983c5884820da7"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "870080e7e18844f1426e924ef260396612530d729e91287827e9354728d22fdd"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "bc63d4b8e0eab947bdbe24d5a7bb8c12168ef5d226bb23338990846fca8403a4"
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
