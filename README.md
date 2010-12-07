# Linklists for Jekyll

A [Jekyll](http://jekyllrb.com/) plugin for linklists. The concept is borrowed from Shopify.

## Install

Copy `linklist.rb` into your site's `_plugins` directory.

## Usage

Define linklists in your site's `_linklists` directory:

`_linklists/main-menu.yml`

    ---
    - title: Home
      url  : /
    - title: About Us
      url  : /about
    - title: Products
      url  : /products
    - title: Contact
      url  : mailto:info@example.com

In your page or layout:

    {% for link in site.linklists.main-menu.links %}
      <a href="{{ link.url }}">{{ link.title }}</a>
    {% endfor %}

## License

See LICENSE.