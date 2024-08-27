class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.20'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.20/macos-x64.zip"
    sha256 '85024b3420d5acddba0aea2b564506424fc629fc9423856efa2d7127336d3c6e' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.20/macos-arm.zip"
    sha256 '90c08d5f4d4bd6c6e8630e5ab8ce4bcf19317a332b60bdc1f3c02baa5652d718' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.20/linux-x64.zip"
    sha256 'e9e60d8ca8b1029ccc1b94bf5051dcee805b84ecd5dfd76d93d76013a910c01c' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.1' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.20'
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
