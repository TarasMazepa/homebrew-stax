class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.21'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.21/macos-x64.zip"
    sha256 'b69d9ad909b6bc120aadd45f70c410dd2e1177bdd607513186d54aebdb1ef369' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.21/macos-arm.zip"
    sha256 'afbd1be36aad4a401d3245c5303660b1c85a73fe84232fc15d99fffedff3c3fa' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.21/linux-x64.zip"
    sha256 'e273a0446fc8b5002780b0255be879191b3b7138eea612e2d7a2c10685cff09b' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.2' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.21'
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
