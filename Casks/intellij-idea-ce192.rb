cask "intellij-idea-ce192" do
    version "2019.2.4,192.7142.36"
  
    url "https://download.jetbrains.com/idea/ideaIC-#{version.csv.first}.dmg"
    sha256 "598e4600b1691dfa13ad39b5cb8f3013d98a008c05edae69fa0203fc00dfa68a"
  
    name "IntelliJ IDEA Community Edition"
    desc "IDE for Java development - community edition"
    homepage "https://www.jetbrains.com/idea/"
  
    auto_updates true
    conflicts_with cask: [
      "intellij-idea-ce",
      "intellij-idea-ce19",
      "intellij-idea-ce192-jbr8"
    ]
  
    app "IntelliJ IDEA CE (v19.2).app"
  
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