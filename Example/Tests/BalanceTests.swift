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

}
