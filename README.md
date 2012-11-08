Description
===========

Uses the `rbenv` cookbook to install sets of Rubies.

Requirements
============

Depends on the `rbenv` cookbook. The Chef community has more than one cookbook
by that name. The `rbenv_ruby` cookbook tests successfully against [Fletcher
Nichol's `rbenv`](https://github.com/fnichol/chef-rbenv).

Attributes
==========

* node[:rbenv_rubies]

  An array of strings, each string specifying a Ruby version number. Defaults
  to array `['1.9.3-p286']`, meaning install just one Ruby version: 1.9.3,
  patch level 286. After installation, you will find the gem binary for this
  version at `/usr/local/rbenv/versions/1.9.3-p286/bin/gem`.

Usage
=====

Just include the recipe, `recipe[rbenv_ruby]` within your roles or recipes.

