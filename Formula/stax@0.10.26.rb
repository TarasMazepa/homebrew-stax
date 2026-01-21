class StaxAT01026 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.10.26'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-x64.zip"
    sha256 '0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 '67b024f71ca623e8bf236bcd72bfe6579f9521caaaef395c68b9c0fb1df3e2eb' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '11be8aa22ca094fa414ee4f5a9421bbcc220beeaf744dbb7b482582ee13d90d2' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.10.7' => :build
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
