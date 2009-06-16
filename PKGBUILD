# Contributor: Colin 'Evaryont' Shea <evaryont@saphrix.com>
pkgname=arson
pkgver=2.1.1
pkgrel=1
pkgdesc="The HOT AUR search helper!"
arch=(any)
url="http://evaryont.github.com/arson/"
license=('GPL')
depends=(ruby-json ruby-facets)
makedepends=(rubygems)
filename="evaryont-$pkgname-$pkgver.gem"
source=(http://gems.github.com/gems/$filename)
noextract=($filename)
md5sums=('f509e388af796c211e53266a5fb34114')

build() {
  cd $srcdir
  gem install --ignore-dependencies -i "$pkgdir/usr/lib/ruby/gems/1.8" -n "$pkgdir/usr/bin" $filename
}


# vim:set ts=2 sw=2 et:
