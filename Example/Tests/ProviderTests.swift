//
//  ProviderTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 8/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

class ProviderTests: XCTestCase {
    
    func testEtheriumProvider() {
        expect(EtheriumService().externalServiceProvider) == "tokenbalance.com"
    }
    
    func testBitcoinProvider() {
        expect(BitcoinService().externalServiceProvider) == "blockchain.info"
    }
    
    func testLitecoinProvider() {
        expect(LitecoinService().externalServiceProvider) == "api.blockcypher.com"
    }
    
    func testRippleProvider() {
        expect(RippleService().externalServiceProvider) == "data.ripple.com"
    }
    
    func testEtheriumClassicProvider() {
        expect(EtheriumClassicService().externalServiceProvider) == "api.gastracker.io"
    }
    
    func testBitcoinCashProvider() {
        expect(BitcoinCashService().externalServiceProvider) == "blockdozer.com"
    }
}
