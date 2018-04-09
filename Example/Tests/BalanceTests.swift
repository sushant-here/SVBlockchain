//
//  BalanceTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 9/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

import Stubborn

class BalanceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        Stubborn.start()
    }
    
    override func tearDown() {
        Stubborn.reset()

        super.tearDown()
    }
    
    func testEtheriumBalance() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/token/.*/.*",
                     resource: Stubborn.Body.Resource("ETH", in: bundle)
        )
        
        let service:BlockchainService = EtheriumService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.ETH, withCallback: { (number) in
            
            expect(number) == NSDecimalNumber.init(string: "13.14159265")
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBitcoinBalance() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/blockchain.info/q/addressbalance/.*",
                     resource: Stubborn.Body.Resource("BTC", in: bundle)
        )
        
        let service:BlockchainService = BitcoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BTC, withCallback: { (number) in
            
            expect(number) == NSDecimalNumber.init(string: "23.14159265")
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLitecoinBalance() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/v1/ltc/main/addrs/.*/balance",
                     resource: Stubborn.Body.Resource("LTC", in: bundle)
        )
        
        let service:BlockchainService = LitecoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.LTC, withCallback: { (number) in
            
            expect(number) == NSDecimalNumber.init(string: "33.14159265")
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testRippleBalance() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/v2/accounts/r.*/balances",
                     resource: Stubborn.Body.Resource("XRP", in: bundle)
        )
        
        let service:BlockchainService = RippleService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.XRP, withCallback: { (number) in
            
            expect(number) == NSDecimalNumber.init(string: "43.14159265")
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testEtheriumClassicBalance() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/addr/.*",
                     resource: Stubborn.Body.Resource("ETC", in: bundle)
        )
        
        let service:BlockchainService = EtheriumClassicService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.ETC, withCallback: { (number) in
            
            expect(number) == NSDecimalNumber.init(string: "53.14159265")
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBitcoinCashBalance() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/insight-api/addr/.*/balance",
                     resource: Stubborn.Body.Resource("BCH", in: bundle)
        )
        
        let service:BlockchainService = BitcoinCashService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BCH, withCallback: { (number) in
            
            expect(number) == NSDecimalNumber.init(string: "63.14159265")
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
