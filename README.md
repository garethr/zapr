# Zapr

A command line tool that:

* Launches [OWASP ZAP](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project)
* Spiders the target URL
* Scans the responses for a variety of vulnerabilities
* Presents the results either as a human friendly table or as JSON

Note that you need to [install OWASP ZAP](https://code.google.com/p/zaproxy/wiki/Downloads?tm=2) before using Zapr.

## Usage

```
Usage:
    zapr [OPTIONS] TARGET

Parameters:
    TARGET                        Web address to scan and attack with ZAP

Options:
    --debug                       More verbose output (default: false)
    --summary                     Output a summary of the results instead of JSON (default: false)
    --zap-path PATH               Path to zap.sh startup script (default: $ZAP_PATH)
    --timeout TIMEOUT             Timeout for spider and scan (default: $ZAPR_TIMEOUT, or 300)
    -h, --help                    print help
```


## Installation

Add this line to your application's Gemfile:

    gem 'zapr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zapr

## Contributing

1. Fork it ( http://github.com/<my-github-username>/zapr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
