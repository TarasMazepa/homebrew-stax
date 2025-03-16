class StaxAT0948 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.48'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.48/macos-x64.zip"
    sha256 'd6d27dc6585bf4a51eea1e664a29ac63c6b6f01400b270bb90df9cfbf67fa5d0' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.48/macos-arm.zip"
    sha256 'ea19bfe25760fbf737a1fc76751f9e172871c019424dcb894f3161f2a5d766ec' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.48/linux-x64.zip"
    sha256 '039fe7347feba8dd5e41a8abcce89badc22a583b33d62425d28ffd3f906ab516' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.7.2' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.48'
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
