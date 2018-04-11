import XCTest
import Nimble
import SVBlockchain

class APITests: XCTestCase {
    var service:BlockchainService?
    
    func testEtheriumAPI() {
        
        service = EtheriumService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: Addresses.ETH, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                expect(number) == NSDecimalNumber.init(string: "0.057273534")
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoinAPI() {
        
        service = BitcoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: Addresses.BTC, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testLitecoinAPI() {
        
        service = LitecoinService()
        
        let semaphore = DispatchSemaphore(value: 0)
        service?.coinsForAddress(address: Addresses.LTC, withCallback: { (number) in

            expect(number) > NSDecimalNumber.zero

            semaphore.signal()
        })

        if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
            XCTFail("Timed out")
        }
    }
    
    func testRippleAPI() {
        
        service = RippleService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: Addresses.XRP, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testEtheriumClassicAPI() {
        
        service = EtheriumClassicService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: Addresses.ETC, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout)) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
    
    func testBitcoinCashAPI() {
        
        service = BitcoinCashService()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        measure {
            service?.coinsForAddress(address: Addresses.BCH, withCallback: { (number) in
                
                expect(number) > NSDecimalNumber.zero
                semaphore.signal()
            })
            
            if semaphore.wait(timeout: DispatchTime.now() + .seconds(Constants.StandardTimeout  )) == .timedOut {
                XCTFail("Timed out")
            }
        }
    }
}
