class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.24'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.24/macos-x64.zip"
    sha256 'abb8fe2448107b510a488109ffb4312d6c467bc365d32d941fca323b2a3e11f7' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.24/macos-arm.zip"
    sha256 '58330a9eee4f5221df3175e121f512fb39de37cf04ddec429d3aa7eea97162fe' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.24/linux-x64.zip"
    sha256 '826fc91e1c182ae98a5c236640f8716960f2b252d7907045ce17ced67977feb5' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.2' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.24'
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
