class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.22'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.22/macos-x64.zip"
    sha256 '6565531b2b4634c3bbb942cf19551ce3d1f8376b56f6034f151b933d5c71121f' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.22/macos-arm.zip"
    sha256 'a0fbf9dd86821265c8c6ba72fe711c97b42bfe3eb12bc83c05086548eee1eac6' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.22/linux-x64.zip"
    sha256 '0b024df3fffde5f9d3c5ea8efba7315e353968fcfdf6500bcba636c1f5db0a4c' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.2' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.22'
  end

  def install
    if Dir.exist?("cli")
      cd "cli" do
        system "dart", "pub", "get"
        system "dart", "compile", "exe", "bin/cli.dart", "-o", "stax", "-Dversion=#{version}"
        bin.install "stax"
      end
    else
      bin.install "stax"
    end
  end

  test do
    system "#{bin}/stax", "help"
  end
end
