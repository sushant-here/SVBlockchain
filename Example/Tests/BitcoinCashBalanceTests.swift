//
//  BitcoinCashBalanceTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 13/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

import Stubborn

class BitcoinCashBalanceTests: BalanceTests {
    
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
    
    func testBitcoinCashInvalidResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/insight-api/addr/.*/balance",
                     resource: Stubborn.Body.Resource("EMPTY_JSON", in: bundle)
        )
        
        let service:BlockchainService = BitcoinCashService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BCH, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBitcoinCashEmptyResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/insight-api/addr/.*/balance",
                     resource: Stubborn.Body.Resource("EMPTY_BODY", in: bundle)
        )
        
        let service:BlockchainService = BitcoinCashService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BCH, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testBitcoinCashErrorResponse() {
        Stubborn.add(url: ".*/insight-api/addr/.*/balance",
                     error: Stubborn.Body.Error(404, "Not Found"))
        
        let service:BlockchainService = BitcoinCashService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.BCH, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
