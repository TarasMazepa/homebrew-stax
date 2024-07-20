class Stax < Formula
  desc "Wrapper around git, which helps with stax-like git workflow"
  homepage "https://staxforgit.com/"
  url "https://github.com/TarasMazepa/stax.git", tag: '0.7.35'

  depends_on "dart-lang/dart/dart" => :build

  def install
    ENV.prepend_path "PATH", Formula["dart"].opt_bin

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
