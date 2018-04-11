//
//  AddressTests.swift
//  SVBlockchain_Tests
//
//  Created by Sushant Verma on 11/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble
import SVBlockchain

class AddressTests: XCTestCase {
    var service:BlockchainService?
    
    func testEtheriumAddress() {
        
        service = EtheriumService()
        
        expect(self.service?.isValid(address: Addresses.ETH)) == true
        expect(self.service?.isValid(address: Addresses.ETH.uppercased())) == false
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testBitcoinAddress() {
        
        service = BitcoinService()
        
        expect(self.service?.isValid(address: Addresses.BTC)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testLitecoinAddress() {
        
        service = LitecoinService()
        
        expect(self.service?.isValid(address: Addresses.LTC)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testRippleAddress() {
        
        service = RippleService()
        
        expect(self.service?.isValid(address: Addresses.XRP)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testEtheriumClassicAddress() {
        
        service = EtheriumClassicService()
        
        expect(self.service?.isValid(address: Addresses.ETC)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testBitcoinCashAddress() {
        
        service = BitcoinCashService()
        
        expect(self.service?.isValid(address: Addresses.BCH)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
}
