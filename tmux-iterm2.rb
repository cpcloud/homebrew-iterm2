require 'formula'

class TmuxIterm2 < Formula
  homepage 'https://code.google.com/p/iterm2/wiki/TmuxIntegration'
  url 'https://iterm2.googlecode.com/files/tmux-for-iTerm2-20130319.tar.gz'
  sha1 'f14a0bad6991b9e3380d5c3a6057e09f62597d1f'

  depends_on 'pkg-config' => :build
  depends_on :autoconf => :build
  depends_on 'libevent'
  depends_on :automake => :build
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
    # prefix.install 'NOTES'
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

