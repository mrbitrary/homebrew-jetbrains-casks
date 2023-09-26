cask "intellij-idea-ce203-aarch64" do
    version "2020.3.4,203.8084.24"
  
    url "https://download.jetbrains.com/idea/ideaIC-#{version.csv.first}-aarch64.dmg"
    sha256 "EDA5F6052DCEDF928DD3337847071E41AD0C2C71BA0B29FA2D9A937F990C4E20"
    
    name "IntelliJ IDEA Community Edition"
    desc "IDE for Java development - community edition"
    homepage "https://www.jetbrains.com/idea/"
  
    auto_updates true
    conflicts_with cask: [
      "intellij-idea-ce",
      "intellij-idea-ce19",
      "intellij-idea-ce203"
    ]

    app "IntelliJ IDEA CE (v20.3).app"
  
    uninstall_postflight do
      ENV["PATH"].split(File::PATH_SEPARATOR).map { |path| File.join(path, "idea") }.each do |path|
        if File.readable?(path) &&
           File.readlines(path).grep(/# see com.intellij.idea.SocketLock for the server side of this interface/).any?
          File.delete(path)
        end
      end
    end
  
    zap trash: [
      "~/Library/Application Support/IdeaIC#{version.major_minor}",
      "~/Library/Caches/IdeaIC#{version.major_minor}",
      "~/Library/Logs/IdeaIC#{version.major_minor}",
      "~/Library/Preferences/IdeaIC#{version.major_minor}",
      "~/Library/Preferences/com.jetbrains.intellij.ce.plist",
      "~/Library/Saved Application State/com.jetbrains.intellij.ce.savedState",
    ]
  
    caveats do
      discontinued
    end
  end