class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.37'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.37/macos-x64.zip"
    sha256 'd374fafd5a338653b1f497b57fbe493b925c58485c4d2b672004cb5a2e470c64' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.37/macos-arm.zip"
    sha256 'ba6f42ccf0712d967a23575cc9381037ab67373b9b9895d62495ed2c5cd3a01a' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.37/linux-x64.zip"
    sha256 '4fb08e44b9a943c22f589747f867285cbb4af09687e215f73495c3ca16880b40' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.3' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.37'
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
