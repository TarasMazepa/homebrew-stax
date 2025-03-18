class StaxAT0949 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.49'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.49/macos-x64.zip"
    sha256 '6e8ab29b666fe12aea0f345d0a3869201eeffda337ccee48a035b96c65a3d384' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.49/macos-arm.zip"
    sha256 '45eb4cee10546e3bd25f862fbfad1a2ff1f42b20e8e23b78542391ed1732a49d' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.49/linux-x64.zip"
    sha256 '325e22f1040008923c681c9d539bde7c329fe15e6cde1ba8235401318e2dc120' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.7.2' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.49'
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
