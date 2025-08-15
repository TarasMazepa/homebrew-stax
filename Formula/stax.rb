class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.10.20'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-x64.zip"
    sha256 '4a7b34b71bf716fb604c56e5edbd49b323335bd1f8f50b2c75a2efe74d03b0cb' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/macos-arm.zip"
    sha256 '06f6cd7a00fc270facc70441724f381a3768713cf497c700058e7ed8063159af' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/#{version}/linux-x64.zip"
    sha256 '6bdb4ed1ec9cad56067aac7b9f090ce3e2909875f9a3173835135c9bf1180c47' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.9.0' => :build
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
