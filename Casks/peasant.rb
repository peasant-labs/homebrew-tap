# frozen_string_literal: true

# This file is rendered by .github/workflows/publish-cask.yml from the latest
# final Peasant release. DO NOT EDIT: change templates/peasant.rb.tmpl instead.
cask "peasant" do
  version "0.22.0"

  on_macos do
    on_arm do
      sha256 "1c0e0ce25261298e7391667c20830e0a37b991aab4e8825d20fd616360711924"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "7b7cd3cee939236c521346b7b5e6a9a15e242593dfb618a5a7a0ffd44c16756c"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "b4ae4ed82fb4a918dfbd8626b45ea4dd32e9211df67cc358cea2ab7aa3ac082e"
      url "https://github.com/peasant-labs/peasant/releases/download/v#{version}/peasant_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "5d22030b67bb5bfece9b381e6ae8012d5920654ba534eecf0b911a31c36c0f68"
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
