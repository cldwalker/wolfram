Description
===========

Explore the vast world of computational knowledge available for free via Wolfram's v2 API.


### Install

To install this gem:

```bash
gem install wolfram
```


### Setup

You'll need a Wolfram Appid (api key) by [creating an account
here](http://developer.wolframalpha.com/portal/apisignup.html) and
then clicking on the 'Get an APPID' button.

Once you have your own appid, set it in your shell, preferably in your ~/.bashrc:

```bash
export WOLFRAM_APPID='YOURKEY'
```

If you want to explicitly set your appid in a script:

```ruby
Wolfram.appid = "YOURKEY"
```


### Usage

Query away on the commandline!

```bash
# Calculate distance and travel time between places
wolfram from boston to new york

# Solve an equation
wolfram x^3 - 4x^2 + 6x - 24 = 0

# Find words ending with able
wolfram words ending with able
```

Regular ruby usage:

```ruby
query = 'boston population'
result = Wolfram.fetch(query)
# to see the result as a hash of pods and assumptions:
hash = HashPresenter.new(result).to_hash
```

For many more examples, [see here](http://www.wolframalpha.com/examples/).


## Credits

* [Ian White](https://github.com/ianwhite) is the original author of this gem.
* bdigital for a bug fix


## Todo

* More tests!
* A better inspect
* Handle more api options including format
