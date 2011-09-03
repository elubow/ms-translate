# Microsoft Translation Gem
This gem is simple.  It provides 3 methods, *get_languages*, *detect*, and *translate*.

It allows you take advantage of the Microsoft Translation API version 2 using HTTP.

To obtian a Microsoft API key, go [here](http://www.bing.com/developers/createapp.aspx).

## Installation
    $ gem install ms-translate

## Usage
    require 'ms-translate'
    msappid = 'GET_THIS_TOKEN_FROM_MICROSOFT'
    t = Microsoft::Translate.new(msappid)

    # Get available languages
    g.get_languages

    # Detect the language
    t.detect('This is a test of English')

    # Translate text
    t.translate('This is a test', {:to => :es, :from => :en})
