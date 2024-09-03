class BrewPkg < Formula
  desc "Homebrew command for building OS X packages from installed formulae"
  homepage "https://github.com/metacall/brew-pkg"
  head "https://github.com/metacall/brew-pkg.git", branch: "master"

  # This is an .rb that must be executable in order for Homebrew to
  # find it with the 'which' method, so we skip_clean
  skip_clean "bin"

  def install
    bin.install "brew-pkg.rb"
  end

  test do
    system "brew", "pkg", "jq"
    output_pkg = Dir.glob("*.pkg").first
    system "pkgutil", "--expand", output_pkg, "extract"
    assert_match "org.homebrew.jq", File.read("extract/PackageInfo")
    rm_rf "extract"
  end
end
