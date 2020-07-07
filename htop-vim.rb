# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class HtopVim < Formula
  desc "htop with vim keybindings"
  homepage "https://github.com/KoffeinFlummi/htop-vim"
  # url "https://codeload.github.com/KoffeinFlummi/htop-vim/tar.gz/1.0.3"
  # sha256 "074287a596c63de44d94b0ed6b935bd68bb9628e744760a3ca57e398be1ea83e"
  license "GPL-2.0"
  conflicts_with "htop", :because => "htop and htop-vim install conflicting executables"

  head do
    url "https://github.com/KoffeinFlummi/htop-vim.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats
    <<~EOS
      htop-vim requires root privileges to correctly display all running processes,
      so you will need to run `sudo htop`.
      You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    pipe_output("#{bin}/htop", "q", 0)
  end
end
