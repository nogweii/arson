# Contributor: Colin 'Evaryont' Shea <evaryont@saphrix.com>
pkgname=arson
pkgver=2.0.0
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
md5sums=('0b88cc61664bb566f78be9f9b969e703')

build() {
  cd $srcdir
  gem install --ignore-dependencies -i "$pkgdir/usr/lib/ruby/gems/1.8" $filename
}


# vim:set ts=2 sw=2 et:
