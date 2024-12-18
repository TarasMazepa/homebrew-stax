class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.30'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.30/macos-x64.zip"
    sha256 'c1b54a5a5523c5583bf562d74c2aec10185978457e5d76f02ee47a0088daccf4' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.30/macos-arm.zip"
    sha256 'fc2f0335c7b64f7d0aa51173b3b19fa309012d4d72f3238dfbd7e0f73d0f2b6f' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.30/linux-x64.zip"
    sha256 'bd10e61f88b6384935dee04c20437865e1dd89679ca352d68e28f915106284d6' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.3' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.30'
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
