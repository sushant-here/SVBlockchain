//
//  BlockchainService.swift
//  SVBlockchain
//
//  Created by Sushant Verma on 22/3/18.
//

import UIKit
import SwiftyJSON

public protocol BlockchainService {
    func coinsForAddress(address:String, withCallback callback: @escaping (NSDecimalNumber)->Void ) -> Void
}

public class EtheriumService : BlockchainService {

    public init() {
        
    }
    
    public func coinsForAddress(address: String, withCallback callback: @escaping (NSDecimalNumber) -> Void) {
        
        let contract = "0x89205a3a3b2a69de6dbf7f01ed13b2108b2c43e7"
        let url = URL(string: "https://api.tokenbalance.com/token/\(contract)/\(address)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    
                    let balance = NSDecimalNumber.init(string: json["eth_balance"].stringValue)
                    
                    callback(balance)
                }
                catch {
                    
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
}

public class LitecoinService : BlockchainService {

    public init() {
        
    }
    
    public func coinsForAddress(address: String, withCallback callback: @escaping (NSDecimalNumber) -> Void) {
        
        let url = URL(string: "https://chain.so/api/v2/get_address_balance/LTC/\(address)/16")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    
                    let balance = NSDecimalNumber.init(string: json["data"]["confirmed_balance"].stringValue)
                                        
                    callback(balance)
                }
                catch {
                    
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
}

public class BitcoinService : BlockchainService {
    
    public init() {
        
    }
    
    public func coinsForAddress(address: String, withCallback callback: @escaping (NSDecimalNumber) -> Void) {
        
        let url = URL(string: "https://blockchain.info/q/addressbalance/\(address)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                let balance = NSDecimalNumber.init(string: String.init(data: data, encoding: String.Encoding.utf8)).dividing(by: NSDecimalNumber.init(mantissa: 1, exponent: 8, isNegative: false))
                
                callback(balance)
            }
        }
        
        task.resume()
    }
}

public class RippleService : BlockchainService {
    
    public init() {
        
    }
    
    public func coinsForAddress(address: String, withCallback callback: @escaping (NSDecimalNumber) -> Void) {
        
        let url = URL(string: "https://data.ripple.com/v2/accounts/\(address)/balances")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    
                    for (_,subJson):(String, JSON) in json["balances"] {
                        if subJson["currency"].stringValue == "XRP" {
                            let balance = NSDecimalNumber.init(string: subJson["value"].stringValue)
                            
                            callback(balance)
                        }
                    }
                    
                }
                catch {
                    
                }
            }
        }
        
        task.resume()
    }
}

public class EtheriumClassicService : BlockchainService {
    
    public init() {
        
    }
    
    public func coinsForAddress(address: String, withCallback callback: @escaping (NSDecimalNumber) -> Void) {
        
        let url = URL(string: "https://api.gastracker.io/addr/\(address)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    
                    let balance = NSDecimalNumber.init(string: json["balance"]["ether"].stringValue)
                    callback(balance)
                }
                catch {
                    
                }
            }
        }
        
        task.resume()
    }
}

public class BitcoinCashService : BlockchainService {
    
    public init() {
        
    }
    
    public func coinsForAddress(address: String, withCallback callback: @escaping (NSDecimalNumber) -> Void) {
        
        let url = URL(string: "https://blockdozer.com/insight-api/addr/\(address)/balance")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                let balance = NSDecimalNumber.init(string: String.init(data: data, encoding: String.Encoding.utf8)).dividing(by: NSDecimalNumber.init(mantissa: 1, exponent: 8, isNegative: false))
                
                callback(balance)
            }
        }
        
        task.resume()
    }
}

