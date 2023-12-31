cask "intellij-idea-ce193" do
    version "2019.3.5,193.7288.26"
  
    url "https://download.jetbrains.com/idea/ideaIC-#{version.csv.first}.dmg"
    sha256 "9069f23e8dda9307083526c6c438b40cb1858598789c5480040d9345b605d80b"
  
    name "IntelliJ IDEA Community Edition"
    desc "IDE for Java development - community edition"
    homepage "https://www.jetbrains.com/idea/"
  
    auto_updates true
    conflicts_with cask: [
      "intellij-idea-ce",
      "intellij-idea-ce19",
      "intellij-idea-ce193-jbr8"
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