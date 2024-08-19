class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.17'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.17/macos-x64.zip"
    sha256 'ee0f33616819e8a43a401a4fa8bf1cb1b44bb3cd2c1a8c9be8eba176bcc9e572' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.17/macos-arm.zip"
    sha256 '8ce95b77cd0d410aa7f2114c549d9a8398fa00f4fddfc1d052e2c798d28a0150' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.17/linux-x64.zip"
    sha256 '8aa32e55c16779991a4345a48fa0c8f39d1282384472319e9d56cdcbad7d5634' # linux-x64
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
