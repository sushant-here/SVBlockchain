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

class BalanceTests: XCTestCase {
    var service:BlockchainService?
        
    func testEtheriumBalance() {
        
        service = EtheriumService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: Addresses.ETH, withCallback: { (number) in
                
                expect(number) == NSDecimalNumber.init(string: "0.057273534")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoinBalance() {
        
        service = BitcoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: Addresses.BTC, withCallback: { (number) in
                
                expect(number.stringValue) == "3.76105098"
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testLitecoinBalance() {
        
        service = LitecoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        service?.coinsForAddress(address: Addresses.LTC, withCallback: { (number) in
            
            expect(number) == NSDecimalNumber.init(string: "897135.39855629")
            semaphore.signal()
        })
        
        if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
            XCTFail("Timed out")
        }
    }
}
