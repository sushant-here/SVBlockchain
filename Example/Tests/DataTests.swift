import XCTest
import Nimble
import SVBlockchain

class DataTests: XCTestCase {
    var service:BlockchainService?
    
    let STANDARD_TIMEOUT = 60
    let ETH_ADDRESS = "0xec5b3e7390302963f0d379d98c2fc39e741af210"
    let BTC_ADDRESS = "1DECAF2uSpFTP4L1fAHR8GCLrPqdwdLse9"
    let LTC_ADDRESS = "LQL9pVH1LsMfKwt82Y2wGhNGkrjF8vwUst"
    let XRP_ADDRESS = "rENDnFwR3CPvrsPjD9XXeqVoXeVt2CpPWX"
    let ETC_ADDRESS = "0x3F45616cFb992988943ff3bA00e8c0aA46B4540a"
    let BCH_ADDRESS = "qq07l6rr5lsdm3m80qxw80ku2ex0tj76vvsxpvmgme"

    func testEtheriumAPI() {
        
        service = EtheriumService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: ETH_ADDRESS, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                expect(number) == NSDecimalNumber.init(string: "0.057273534")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testEtheriumAddress() {
        
        service = EtheriumService()
        
        expect(self.service?.isValid(address: self.ETH_ADDRESS)) == true
        expect(self.service?.isValid(address: self.ETH_ADDRESS.uppercased())) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testEtheriumBalance() {
        
        service = EtheriumService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: ETH_ADDRESS, withCallback: { (number) in
                
                expect(number) == NSDecimalNumber.init(string: "0.057273534")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoinAPI() {
        
        service = BitcoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: BTC_ADDRESS, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoinAddress() {
        
        service = BitcoinService()
        
        expect(self.service?.isValid(address: self.BTC_ADDRESS)) == true
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testBitcoinBalance() {
        
        service = BitcoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: BTC_ADDRESS, withCallback: { (number) in
                
                expect(number.stringValue) == "3.76090018"
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testLitecoinAPI() {
        
        service = LitecoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: LTC_ADDRESS, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testLitecoinAddress() {
        
        service = LitecoinService()
        
        expect(self.service?.isValid(address: self.LTC_ADDRESS)) == true
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testLitecoinBalance() {
        
        service = LitecoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: LTC_ADDRESS, withCallback: { (number) in
                
                expect(number) == NSDecimalNumber.init(string: "897135.39008633")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testRippleAPI() {
        
        service = RippleService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: XRP_ADDRESS, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testRippleAddress() {
        
        service = RippleService()
        
        expect(self.service?.isValid(address: self.XRP_ADDRESS)) == true
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testEtheriumClassicAPI() {
        
        service = EtheriumClassicService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: ETC_ADDRESS, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testEtheriumClassicAddress() {
        
        service = EtheriumClassicService()
        
        expect(self.service?.isValid(address: self.ETC_ADDRESS)) == true
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
    
    func testBitcoinCashAPI() {
        
        service = BitcoinCashService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: BCH_ADDRESS, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(STANDARD_TIMEOUT)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoinCashAddress() {
        
        service = BitcoinCashService()
        
        expect(self.service?.isValid(address: self.BTC_ADDRESS)) == true
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
}
