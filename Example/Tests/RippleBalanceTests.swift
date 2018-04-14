//
//  RippleBalanceTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 13/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

import Stubborn

class RippleBalanceTests: BalanceTests {
    
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

    func testRippleInvalidResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/v2/accounts/r.*/balances",
                     resource: Stubborn.Body.Resource("EMPTY_JSON", in: bundle)
        )
        
        let service:BlockchainService = RippleService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.XRP, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testRippleEmptyResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/v2/accounts/r.*/balances",
                     resource: Stubborn.Body.Resource("EMPTY_BODY", in: bundle)
        )
        
        let service:BlockchainService = RippleService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.XRP, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testRippleErrorResponse() {
        Stubborn.add(url: ".*/v2/accounts/r.*/balances",
                     error: Stubborn.Body.Error(404, "Not Found"))
        
        let service:BlockchainService = RippleService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.XRP, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
