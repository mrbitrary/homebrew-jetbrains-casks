cask "intellij-idea-ce191-jbr11" do
    version "2019.1.4,191.8026.42"
  
    url "https://download.jetbrains.com/idea/ideaIC-#{version.csv.first}-jbr11.dmg"
    sha256 "f3f115b3c98e2d734663992d847406645c31c3863eacfa1c7ce121e38e92e493"
  
    name "IntelliJ IDEA Community Edition"
    desc "IDE for Java development - community edition"
    homepage "https://www.jetbrains.com/idea/"
  
    auto_updates true
    conflicts_with cask: [
      "intellij-idea-ce",
      "intellij-idea-ce19",
      "intellij-idea-ce191"
    ]
  
    app "IntelliJ IDEA CE (v19.1).app"
  
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