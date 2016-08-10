class Gitignore < Formula
  homepage "https://github.com/karan/joe"
  url "https://pypi.python.org/packages/source/j/joe/joe-0.0.7.tar.gz"
  sha256 "51396a06ee83694f48a16bb4e78f4bd3ee27a30809b19f7ede4881b7366539c7"

  depends_on :python if MacOS.version <= :snow_leopard

  resource "docopt" do
    url "https://github.com/docopt/docopt/archive/0.6.1.tar.gz"
    sha256 "e5e9fc58fc25acd8837f608296007e309a4d54d4402529a12d7b450c14d40317"
  end

  resource "GitPython" do
    url "https://pypi.python.org/packages/source/G/GitPython/GitPython-1.0.2.tar.gz"
    sha256 "85de72556781480a38897a77de5b458ae3838b0fd589593679a1b5f34d181d84"
  end

  def install
    ENV["PYTHONPATH"] = libexec/"vendor/lib/python2.7/site-packages"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"

    resource("docopt").stage { system "python", *Language::Python.setup_install_args(libexec/"vendor") }
    resource("GitPython").stage { system "python", *Language::Python.setup_install_args(libexec/"vendor") }

    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/joe", "ls"
  end
end
