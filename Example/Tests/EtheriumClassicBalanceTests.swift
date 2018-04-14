//
//  EtheriumClassicBalanceTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 13/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

import Stubborn

class EtheriumClassicBalanceTests: BalanceTests {
    
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
    
    func testEtheriumClassicInvalidResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/addr/.*",
                     resource: Stubborn.Body.Resource("EMPTY_JSON", in: bundle)
        )
        
        let service:BlockchainService = EtheriumClassicService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.ETC, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testEtheriumClassicEmptyResponse() {
        let bundle = Bundle(for: self.classForCoder)
        Stubborn.add(url: ".*/addr/.*",
                     resource: Stubborn.Body.Resource("EMPTY_BODY", in: bundle)
        )
        
        let service:BlockchainService = EtheriumClassicService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.ETC, withCallback: { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testEtheriumClassicErrorResponse() {
        Stubborn.add(url: ".*/addr/.*",
                     error: Stubborn.Body.Error(404, "Not Found"))
        
        let service:BlockchainService = EtheriumClassicService()
        let expectation = self.expectation(description: "request")
        service.coinsForAddress(address: Addresses.ETC) { (number) in
            
            expect(number).to(beNil())
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }
}
