require 'formula'

class Tmux < Formula
  homepage 'https://github.com/gnachman/tmux2'
  url 'git://github.com/gnachman/tmux2.git'
  sha1 ''

  depends_on 'pkg-config' => :build
  depends_on 'libevent'

  depends_on :automake
  depends_on :libtool

  def install
    system "sh", "autogen.sh"

    ENV.append "LDFLAGS", '-lresolv'
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make install"

    (prefix+'etc/bash_completion.d').install "examples/bash_completion_tmux.sh" => 'tmux'

    # Install addtional meta file
    prefix.install 'NOTES'
  end

  def caveats; <<-EOS.undent
    Additional information can be found in:
      #{prefix}/NOTES
    EOS
  end

  def test
    system "#{bin}/tmux", "-V"
  end
end

