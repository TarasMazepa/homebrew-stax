class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.18'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.18/macos-x64.zip"
    sha256 '818a601e2ff44547f9298d7593149b37ff51c4611f8d1ed9b7ff1efb9a3d005f' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.18/macos-arm.zip"
    sha256 '899301f0247481748954bcc345caea09763abf0e70c26a3972141c7023da806c' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.18/linux-x64.zip"
    sha256 '9893a2c1cf7a59db9dedc0ae4e80966259950307f44782481a61b09a82be1ac7' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.1' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.18'
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
