//
//  BitcoinBalanceTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 13/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

import Stubborn

class BitcoinBalanceTests: BalanceTests {
    
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
    
    func testBitcoinInvalidResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/blockchain.info/q/addressbalance/.*",
                     resource: Stubborn.Body.Resource("EMPTY_JSON", in: bundle)
        )
        
        let service:BlockchainService = BitcoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BTC, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBitcoinEmptyResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/blockchain.info/q/addressbalance/.*",
                     resource: Stubborn.Body.Resource("EMPTY_BODY", in: bundle)
        )
        
        let service:BlockchainService = BitcoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BTC, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBitcoinErrorResponse() {
        Stubborn.add(url: ".*/blockchain.info/q/addressbalance/.*",
                     error: Stubborn.Body.Error(404, "Not Found"))
        
        let service:BlockchainService = BitcoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BTC) { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
