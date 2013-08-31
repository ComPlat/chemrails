chemrails
=========

A set of cheminformatic components for fast & easy development of web based applications.


## Contains the following components:

checkmol (by Norbert Haider, GPL), included as binary
canvasmol (by AlteredQualia, http://alteredqualia.com)
ketcher (by GGA Software, http://ggasoftware.com)


## Installation as part of a Ruby on Rails project (gem)

Add this line to your application's Gemfile:

    gem 'chemrails'

Change these settings in /config/environments/production.rb

    config.serve_static_assets = true
    config.assets.compress = false
    config.assets.compile = true

And then execute:

    $ bundle

## License

GPLv3