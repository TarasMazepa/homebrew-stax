class Stax < Formula
  desc "Stack your PRs with stax"
  homepage "https://staxforgit.com/"
  version '0.9.29'

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.29/macos-x64.zip"
    sha256 '178fa34508d1e850257d5115c7b4135076c4420f9c25c17b06ba0144375eed17' # macos-x64
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.29/macos-arm.zip"
    sha256 '8705fd7adafd306ed5ad9b5ed35446e191b9a461b0ab4f64a8a0327203b66f3e' # macos-arm
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/TarasMazepa/stax/releases/download/0.9.29/linux-x64.zip"
    sha256 '3d8c66c522ec09cba69eba266cb8504ae4e2c77fe62aba575b46296272d5932f' # linux-x64
  else
    depends_on 'dart-lang/dart/dart@3.5.1' => :build
    url "https://github.com/TarasMazepa/stax.git", tag: '0.9.29'
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
