class Stax < Formula
  desc "Wrapper around git, which helps with stax-like git workflow"
  homepage "https://github.com/TarasMazepa/stax"
  url "https://github.com/TarasMazepa/stax.git",
      using:  :git,
      branch: "main"
  version "0.6.8"
  head "https://github.com/TarasMazepa/stax.git", using: :git

  depends_on "dart-lang/dart/dart" => :build

  def install
    ENV.prepend_path "PATH", Formula["dart"].opt_bin

    cd "cli" do
      system "dart", "pub", "get"
      system "dart", "compile", "exe", "bin/cli.dart", "-o", "stax"
      bin.install "stax"
    end
  end

  test do
    system "#{bin}/stax", "help"
  end
end
