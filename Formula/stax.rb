class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.32'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.32/macos-x64.zip"
    sha256 '19262ebeccc8ec520ee3b1483eca1955e120cee9c2921c45a4591116ef459a59' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.32/macos-arm.zip"
    sha256 '9dc3f8e20199d55c6728afd3c7bd543f485a3e3c56f839665e0fe954ad9e4f71' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.32/linux-x64.zip"
    sha256 '25ffd12f68f0a4afa2bf7db2d3da3003e33cd3d4d23efa83792606440213a430' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.3' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.32'
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
