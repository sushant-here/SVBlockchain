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
}
