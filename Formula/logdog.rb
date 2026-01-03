class Logdog < Formula
  desc "Text-based interface for viewing and filtering Android logcat stream"
  homepage "https://github.com/mikaelreiersolmoen/logdog"
  head "https://github.com/mikaelreiersolmoen/logdog.git", branch: "main"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mikaelreiersolmoen/logdog/releases/download/v#{version}/logdog-v#{version}-macos-arm64.tar.gz"
      sha256 "8f7c43c843bdb02d97aade413d6a15c7191611ba43779bd1dc89abc503a51bca"
    else
      url "https://github.com/mikaelreiersolmoen/logdog/releases/download/v#{version}/logdog-v#{version}-macos-amd64.tar.gz"
      sha256 "f74b63ebfc522abf8c2fc6fd56c14ebf0ed749315b4762a82e9330c48f20b92e"
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
