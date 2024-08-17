class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  url "https://github.com/TarasMazepa/stax.git", tag: '0.9.9'

  depends_on 'dart-lang/dart/dart@3.5.1' => :build

  def install
    cd "cli" do
      system "dart", "pub", "get"
      system "dart", "compile", "exe", "bin/cli.dart", "-o", "stax", "-Dversion=#{version}"
      bin.install "stax"
    end
  end

  test do
    system "#{bin}/stax", "help"
  end
end
