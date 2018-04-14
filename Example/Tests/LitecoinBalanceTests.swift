//
//  LitecoinBalanceTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 13/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

import Stubborn

class LitecoinBalanceTests: BalanceTests {
    
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

    func testLitecoinInvalidResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/v1/ltc/main/addrs/.*/balance",
                     resource: Stubborn.Body.Resource("EMPTY_JSON", in: bundle)
        )
        
        let service:BlockchainService = LitecoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.LTC, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLitecoinEmptyResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/v1/ltc/main/addrs/.*/balance",
                     resource: Stubborn.Body.Resource("EMPTY_BODY", in: bundle)
        )
        
        let service:BlockchainService = LitecoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.LTC, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testLitecoinErrorResponse() {
        Stubborn.add(url: ".*/v1/ltc/main/addrs/.*/balance",
                     error: Stubborn.Body.Error(404, "Not Found"))
        
        let service:BlockchainService = LitecoinService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.LTC, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
