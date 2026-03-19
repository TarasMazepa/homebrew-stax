class StaxAT0112 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.11.2'

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 '8b5d9a4f9e9852b75d36a16f9ce54fa9b6d4beba20855bd4682cf6d747147c9b' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '53f6c49b290aee48513a53d58b9081d2ab4f57f3719909a97be1c10462f1d8c0' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.11.3' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: "#{version}"
  end

  def install
    if Dir.exist?("cli")
      cd "cli" do
        system "dart", "pub", "get"
        system "dart", "compile", "exe", "bin/cli.dart", "-o", "stax", "-Dversion=#{version}"
        system "dart", "compile", "exe", "bin/stax_daemon.dart", "-o", "stax-daemon", "-Dversion=#{version}"
        bin.install "stax"
        bin.install "stax-daemon"
      end
    else
      bin.install "stax"
      bin.install "stax-daemon"
    end
  end

  test do
    system "#{bin}/stax", "help"
  end
end
