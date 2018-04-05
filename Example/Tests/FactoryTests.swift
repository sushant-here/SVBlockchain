//
//  FactoryTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 5/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

class FactoryTests: XCTestCase {
    
    func testEtheriumFactory() {
        let service = BlockchainFactory.service(forCoin: "ETH")
        expect(service).toNot(beNil())
    }
    
    func testBitcoinFactory() {
        let service = BlockchainFactory.service(forCoin: "BTC")
        expect(service).toNot(beNil())
    }
    
    func testLitecoinFactory() {
        let service = BlockchainFactory.service(forCoin: "LTC")
        expect(service).toNot(beNil())
    }
    
    func testRippleFactory() {
        let service = BlockchainFactory.service(forCoin: "XRP")
        expect(service).toNot(beNil())
    }
    
    func testEtheriumClassicFactory() {
        let service = BlockchainFactory.service(forCoin: "ETC")
        expect(service).toNot(beNil())
    }
    
    func testBitcoinCashFactory() {
        let service = BlockchainFactory.service(forCoin: "BCH")
        expect(service).toNot(beNil())
    }
        
    func testInvalidFactory() {
        expect( BlockchainFactory.service(forCoin: "") ).to(beNil())
        expect( BlockchainFactory.service(forCoin: "xrp") ).to(beNil())
    }
    
}
