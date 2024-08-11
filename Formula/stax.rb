class Stax < Formula
  desc "Wrapper around git, which helps with stax-like git workflow"
  homepage "https://staxforgit.com/"
  url "https://github.com/TarasMazepa/stax.git", tag: '0.9.2'

  depends_on "dart@3.2.3" => :build

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
