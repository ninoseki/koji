# koji

[![Gem Version](https://badge.fury.io/rb/koji.svg)](https://badge.fury.io/rb/koji)
[![Build Status](https://travis-ci.org/ninoseki/koji.svg?branch=master)](https://travis-ci.org/ninoseki/koji)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/koji/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/koji?branch=master)
[![CodeFactor](https://www.codefactor.io/repository/github/ninoseki/koji/badge)](https://www.codefactor.io/repository/github/ninoseki/koji)

koji (`工事`) is a development/staging environment detector.

## Features

- Web app debug feature detection (CodeIgniter, Django, FuelPHP and etc.)
- Suspicious domain detection (e.g. `dev.*.com`, `stg.*.com`)
- Self-signed certificate detection

## Installation

```bash
gem install koji
```

## Usage

### As a CLI

```bash
$ koji help
Commands:
  koji check URL       # check a given URL
  koji help [COMMAND]  # Describe available commands or one specific command

$ koji check https://github.com/ninoseki/koji
{
  "verdict": "Not underconstruction",
  "score": 0
}

$ koji check https://dev.example.com
{
  "verdict": "Possibly underconstruction",
  "score": 50
}

$ koji check http://phpdebugbar.com/
{
  "verdict": "Underconstruction",
  "score": 100
}

$ koji check http://phpdebugbar.com/ --verbose
{
  "verdict": "Underconstruction",
  "score": 100,
  "plugin_reports": [
    {
      "name": "PHPDebugBar",
      "evidence_list": [
        "The website contains PHP DebugBar"
      ],
      "score": 100
    }
  ]
}

$ koji check https://self-signed.badssl.com/ --verbose
{
  "verdict": "Underconstruction",
  "score": 100,
  "plugin_reports": [
    {
      "name": "SelfSignedCertificate",
      "evidence_list": [
        "The website has a self-signed certificate"
      ],
      "score": 100
    }
  ]
}
```

### As a library

```ruby
require "koji"

website = Koji::Website.new("http://example.com")
detector = Koji::Detector.new(website)

puts detector.report
puts detector.detailed_report
```
