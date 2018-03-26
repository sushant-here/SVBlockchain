import XCTest
import Nimble
import SVBlockchain

class SimpleTests: XCTestCase {
    var service:BlockchainService?

    func testEtherium() {
        
        service = EtheriumService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: "0xec5b3e7390302963f0d379d98c2fc39e741af210", withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                expect(number) == NSDecimalNumber.init(string: "0.057273534")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(20)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoin() {
        
        service = BitcoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: "1DECAF2uSpFTP4L1fAHR8GCLrPqdwdLse9", withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                expect(number) == NSDecimalNumber.init(string: "3.29924984")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(20)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testLitecoin() {
        
        service = LitecoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: "LQL9pVH1LsMfKwt82Y2wGhNGkrjF8vwUst", withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                expect(number) == NSDecimalNumber.init(string: "897135.39008633")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(20)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testRipple() {
        
        service = RippleService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: "rENDnFwR3CPvrsPjD9XXeqVoXeVt2CpPWX", withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(20)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testEtheriumClassic() {
        
        service = EtheriumClassicService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: "0x3F45616cFb992988943ff3bA00e8c0aA46B4540a", withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(20)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoinCash() {
        
        service = BitcoinCashService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: "qq07l6rr5lsdm3m80qxw80ku2ex0tj76vvsxpvmgme", withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(20)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
}
