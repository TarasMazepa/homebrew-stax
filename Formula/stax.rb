class Stax < Formula
  desc "Stax Dart CLI application"
  homepage "https://github.com"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/TarasMazepa/stax/releases/download/0.0.0.2/macos-13_.tar.gz"
      sha256 "macos_amd64_sha256_checksum_here"
    elsif Hardware::CPU.arm?
      url "https://github.com/TarasMazepa/stax/releases/download/0.0.0.2/macos-latest_.tar.gz"
      sha256 "macos_arm_sha256_checksum_here"
    end
  end

  on_linux do
    url "https://github.com/TarasMazepa/stax/releases/download/0.0.0.2/ubuntu-latest_.tar.gz"
    sha256 "linux_amd64_sha256_checksum_here"
  end

  def install
    bin.install "stax"
  end

  test do
    system "#{bin}/stax", "--version"
  end
end
