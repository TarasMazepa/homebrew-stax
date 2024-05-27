class Stax < Formula
  desc "Stax cli application"
  homepage "https://github.com/TarasMazepa/stax"
 
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/TarasMazepa/stax/releases/download/0.0.0.2/macos-13_.tar.gz"
      sha256 "f85a608532bd43429d9a2ee5a3303e786f70013d36b3bc932632603d57ff3ffa"
    elsif Hardware::CPU.arm?
      url "https://github.com/TarasMazepa/stax/releases/download/0.0.0.2/macos-latest_.tar.gz"
      sha256 "895f81b3490464de46753ecc2adb4eafeb7d2e7ba21260230b962c2a66749aa5"
    end
  end

  on_linux do
    url "https://github.com/TarasMazepa/stax/releases/download/0.0.0.2/ubuntu-latest_.tar.gz"
    sha256 "481ec0323930b989e6d7cfa2647132dab7245afc262167606e1bb18df70ae786"
  end

  def install
    bin.install "stax"
  end

  test do
    system "#{bin}/stax", "help"
  end
end
