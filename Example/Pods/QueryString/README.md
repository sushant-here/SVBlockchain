![](logo.png)

[![](https://img.shields.io/badge/contact-@thematerik-blue.svg?style=flat-square)](http://twitter.com/thematerik)
[![](https://img.shields.io/cocoapods/v/QueryString.svg?style=flat-square)](https://cocoapods.org/pods/QueryString)
[![](https://img.shields.io/travis/materik/querystring.svg?style=flat-square)](https://travis-ci.org/materik/querystring)
![](https://img.shields.io/cocoapods/p/QueryString.svg?style=flat-square)
![](https://img.shields.io/cocoapods/l/QueryString.svg?style=flat-square)

Model for parsing and appending query strings to URLs.

# Install

```bash
pod 'QueryString'
```

# Usage

```swift
let qs = QueryString(key: "query", value: "stockholm")
let url = qs.append(to: "http://google.com")
print(url) // http://google.com?query=stockholm
```

