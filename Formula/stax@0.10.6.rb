class StaxAT0106 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.10.6'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-x64.zip"
    sha256 'dde5229001800256ea940afc4e4110e6ba4b8887356daa3c7faed2a9b4d766db' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 'ed21b55ef31707b744af30c7dad7725f73b19b675bc44d94cd514cd28cc5ce92' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '90c03d031c30ea049789a0c9c03b659b6edec6185d8e0e9c42a204ac8d253e12' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.8.1' => :build
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
