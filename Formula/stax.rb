class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.27'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.27/macos-x64.zip"
    sha256 'f6986d93d7284feb0f9440ad08605ef58f5feed895530c0ce47f33a28e1c9de4' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.27/macos-arm.zip"
    sha256 '8d1085755d8e33a1dbed953407d732fc612d3a5a060cab3703e0fc0d1976d08c' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.27/linux-x64.zip"
    sha256 'aa8a7d38fb9907761bf2931f80d6dd1cca8e48e5bff0e9c0a67486df411e5e03' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.2' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.27'
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
