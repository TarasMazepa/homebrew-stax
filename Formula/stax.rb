class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.39'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.39/macos-x64.zip"
    sha256 '4e8a08fbc3adce2cd3b899d51b01e802f0c7fca1631e5b3a80391b9ef76db9c3' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.39/macos-arm.zip"
    sha256 '99133a81c42a6f6b1c6627b6d1be9ffc9004603b034755317834b5c3bfc081e7' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.39/linux-x64.zip"
    sha256 'b242e4bd08b00e035bab2245ec8b7b96d9179ceb8532a00b2ada41b6919d1fed' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.3' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.39'
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
