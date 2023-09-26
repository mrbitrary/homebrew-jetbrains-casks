cask "intellij-idea-ce193-jbr8" do
    version "2019.3.5,193.7288.26"
  
    url "https://download.jetbrains.com/idea/ideaIC-#{version.csv.first}-jbr8.dmg"
    sha256 "d6ab89eaddcc8f1cf6c230fc9fe995cd18e62e41858fd11be803e96e7cd50c16"
  
    name "IntelliJ IDEA Community Edition"
    desc "IDE for Java development - community edition"
    homepage "https://www.jetbrains.com/idea/"
  
    auto_updates true
    conflicts_with cask: [
      "intellij-idea-ce",
      "intellij-idea-ce19",
      "intellij-idea-ce193"
    ]
  
    app "IntelliJ IDEA CE (v19.3).app"
  
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