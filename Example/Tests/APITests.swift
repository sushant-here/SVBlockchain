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
    
    func testEtheriumAddress() {
        
        service = EtheriumService()
        
        expect(self.service?.isValid(address: Addresses.ETH)) == true
        expect(self.service?.isValid(address: Addresses.ETH.uppercased())) == false
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
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
    
    func testBitcoinAddress() {
        
        service = BitcoinService()
        
        expect(self.service?.isValid(address: Addresses.BTC)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
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
    
    func testLitecoinAddress() {
        
        service = LitecoinService()
        
        expect(self.service?.isValid(address: Addresses.LTC)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
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
    
    func testRippleAddress() {
        
        service = RippleService()
        
        expect(self.service?.isValid(address: Addresses.XRP)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
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
    
    func testEtheriumClassicAddress() {
        
        service = EtheriumClassicService()
        
        expect(self.service?.isValid(address: Addresses.ETC)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
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
    
    func testBitcoinCashAddress() {
        
        service = BitcoinCashService()
        
        expect(self.service?.isValid(address: Addresses.BCH)) == true
        expect(self.service?.isValid(address: nil)) == false
        expect(self.service?.isValid(address: "")) == false
        expect(self.service?.isValid(address: "abc")) == false
    }
}
