class StaxAT0111 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.11.1'

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 '97060827005ff3fda345daf5b0db5353ca4775df6de9cd9e19e6a8cf48f83ab7' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '33c5c0d9c81472e85a1e9f767b6ad056faff10a8aa3ad087d9cd1ec7824611bb' # linux-x64
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
