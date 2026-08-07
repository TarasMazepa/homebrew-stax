class StaxAT01110 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.11.10'

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 '00bfdf8049ae6fc1a5e966e74d9f555b6fb2fecaf2e7551071afaa319905ddeb' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '19d8fd8065b5f6cb4bd86f7b4931da847c0b9b36e056d1cf070911f8136131bc' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.12.0' => :build
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
