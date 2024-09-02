class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.25'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.25/macos-x64.zip"
    sha256 '53dac766b06ec5cce903225d7d8417d0a8b720f4b8033099a575d24b4b67c559' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.25/macos-arm.zip"
    sha256 '0913170cb060aeed38cb67cf4fc9ee2e6835b38345f1217c1a04b44124490e2a' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.25/linux-x64.zip"
    sha256 'b6694a3a4fa618163ff7a7b45bb68173b21378b14ebf4b7aa65c23af2f7cd200' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.2' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.25'
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
