//
//  EtheriumBalanceTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 12/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

import Stubborn

class EtheriumBalanceTests: BalanceTests {
    
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
    
    func testEtheriumInvalidResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/token/.*/.*",
                     resource: Stubborn.Body.Resource("EMPTY_JSON", in: bundle)
        )
        
        let service:BlockchainService = EtheriumService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.ETH, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testEtheriumEmptyResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/token/.*/.*",
                     resource: Stubborn.Body.Resource("EMPTY_BODY", in: bundle)
        )
        
        let service:BlockchainService = EtheriumService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.ETH, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
