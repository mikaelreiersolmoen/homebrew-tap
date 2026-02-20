class Logdog < Formula
  desc "Text-based interface for viewing and filtering Android logcat stream"
  homepage "https://github.com/mikaelreiersolmoen/logdog"
  head "https://github.com/mikaelreiersolmoen/logdog.git", branch: "main"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mikaelreiersolmoen/logdog/releases/download/v#{version}/logdog-v#{version}-macos-arm64.tar.gz"
      sha256 "732ed456811e600de6442a69b3527716af6eef8f9a00ab4e3d24234d9e2b9cb0"
    else
      url "https://github.com/mikaelreiersolmoen/logdog/releases/download/v#{version}/logdog-v#{version}-macos-amd64.tar.gz"
      sha256 "cfa862d9b4ee6a764bcb32e0788e6c854d431c9891f9842c494def963d8d2d4c"
    end
  end


  depends_on "go" => :build if build.head?

  def install
    if build.head?
      system "go", "build", *std_go_args
      return
    end

    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "logdog-v#{version}-macos-#{arch}" => "logdog"
  end

  test do
    system "#{bin}/logdog", "--help"
  end
end
