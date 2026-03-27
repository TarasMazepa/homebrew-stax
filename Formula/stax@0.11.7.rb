class StaxAT0117 < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.11.7'

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 'e3a4a10a422f464a605f44f7b6063c2b022a1c01c03d1fc61c43dd2342ed9a19' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '23babf490fa69ff3138e833028a3345f0308572e987efe5563fd7cc474e3a389' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.11.4' => :build
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
