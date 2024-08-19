class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.17/macos-x64.zip"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.17/macos-arm.zip"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.17/linux-x64.zip"
  else
    depends_on 'dart-lang/dart/dart@3.5.1' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.17'
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
