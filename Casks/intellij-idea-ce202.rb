cask "intellij-idea-ce202" do
    version "2020.2.4,202.8194.7"
  
    url "https://download.jetbrains.com/idea/ideaIC-#{version.csv.first}.dmg"
    sha256 "3918EE5631B683CFC3E42660A9B7B3384A328C128232735B3552B354673359E7"

    name "IntelliJ IDEA Community Edition"
    desc "IDE for Java development - community edition"
    homepage "https://www.jetbrains.com/idea/"
  
    auto_updates true
    conflicts_with cask: "intellij-idea-ce"
  
    app "IntelliJ IDEA CE (v20.2).app"
  
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