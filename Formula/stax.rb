class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.38'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.38/macos-x64.zip"
    sha256 'cb0fbc02f5b6ff7534dfbfe691293959a6fd170a2112fc907683be3d6989de50' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.38/macos-arm.zip"
    sha256 '65462d93efb2080fa030a42ab31c84480a922fcb96402a56461a768336893eeb' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.38/linux-x64.zip"
    sha256 '132a7f0a5c9a20b57c9973cafe5229dba4b88069477a40729cb9cecc25d16ae1' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.3' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.38'
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
