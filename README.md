# SVBlockchain

[![CI Status](http://img.shields.io/travis/sushant.40@gmail.com/SVBlockchain.svg?style=flat)](https://travis-ci.org/sushant.40@gmail.com/SVBlockchain)
[![Version](https://img.shields.io/cocoapods/v/SVBlockchain.svg?style=flat)](http://cocoapods.org/pods/SVBlockchain)
[![License](https://img.shields.io/cocoapods/l/SVBlockchain.svg?style=flat)](http://cocoapods.org/pods/SVBlockchain)
[![Platform](https://img.shields.io/cocoapods/p/SVBlockchain.svg?style=flat)](http://cocoapods.org/pods/SVBlockchain)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Supported coins / blockchains
Currently the following blockchain coins are supported

- Bitcoin
- Litecoin
- Etherium
- Etherium Classic
- Ripple
- Bitcoin Cash

## Usage

Simple to use!...

```
let service = BitcoinService()

service.coinsForAddress(address: "1DECAF2uSpFTP4L1fAHR8GCLrPqdwdLse9", withCallback: { (number) in
// 'number' constains the balance for this bitcoin
})
```

for for assistance see Tests.swift in the example pod

## Installation

SVBlockchain is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SVBlockchain'
```

## Author

Sushant Verma

## License

SVBlockchain is available under the MIT license. See the LICENSE file for more info.
