# frozen_string_literal: true

# This file is rendered by .github/workflows/publish-cask.yml from the latest
# final Peasant release. DO NOT EDIT: change templates/peasant.rb.tmpl instead.
cask "peasant" do
  version "0.19.0"

  on_macos do
    on_arm do
      sha256 "e7eab78fbad07919bee4a1cf6184816758424c8b2c98254d2e9e788522b2d27a"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "1b7b81afe333522dd3e3c0963c4a44596bd77aca7c4bd219a6d36989fc817a99"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "601d43aca42b7cb053bc88ff680535184c1b31a454c453bdc216fb04770c7b4e"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "58fb2746f907facf2e00d097add1257ba5ac1ea012519f2820a5f206ee3433fa"
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
