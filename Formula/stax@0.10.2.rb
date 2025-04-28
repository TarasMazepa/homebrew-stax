class StaxAT0102 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.10.2'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-x64.zip"
    sha256 '6b84f95d5bc32338c409501f7037e48d0f2902a645f192eae3135f544e302a1c' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 '497656cba6c77304a2d758d2cf2a525bee602b18259d7f65edf8ee7344b970b4' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '58f6768befe2d985778f8c7fbae7b78c80652bc8b7a4120bcd1049bf83676f00' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.7.2' => :build
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
