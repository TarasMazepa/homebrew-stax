class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.47'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.47/macos-x64.zip"
    sha256 '27d8fbed7d2928b1df0791d953603e95d4ff4da4d6eb36b3b7620711b5d8dc77' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.47/macos-arm.zip"
    sha256 'e911cb5f27f3f54a55a75d865ff5655adfc50953dbcab7b04db9455a11d6397f' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.47/linux-x64.zip"
    sha256 '2395b3aa0218527bfd2d716d58302a2c90831d81f9c88d60bb8d46a6122f185e' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.7.0' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.47'
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
