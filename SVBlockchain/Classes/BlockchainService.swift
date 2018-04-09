//
//  BlockchainService.swift
//  SVBlockchain
//
//  Created by Sushant Verma on 22/3/18.
//

import UIKit
import SwiftyJSON
import Regex

public class BlockchainFactory {
    public static func service(forCoin:String?)->BlockchainService? {
        if let forCoin = forCoin {
            switch forCoin {
            case "ETH":
                return EtheriumService()
            case "BTC":
                return BitcoinService()
            case "LTC":
                return LitecoinService()
            case "XRP":
                return RippleService()
            case "ETC":
                return EtheriumClassicService()
            case "BCH":
                return BitcoinCashService()
            default:
                return nil
            }
        }
        return nil
    }
}

public protocol BlockchainService {
    func coinsForAddress(address:String, withCallback callback: @escaping (NSDecimalNumber)->Void ) -> Void
    
    func isValid(address:String?) -> Bool
    
    var externalServiceProvider:String { get }
}

public extension BlockchainService {
    func isValid(address:String?) -> Bool{
        return false
    }
}

public class EtheriumService : BlockchainService {
    
    public init() {
        
    }
    
    public var externalServiceProvider:String
    {
        get {
            return "tokenbalance.com"
        }
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
    
    public func isValid(address: String?) -> Bool {
        if let address = address {
            do {
                return try Regex(pattern: "^0x[a-fA-F0-9]{40}$",
                                 options: [],
                                 groupNames: []).matches(address)
            }
            catch { }
        }
        return false
    }
}

public class LitecoinService : BlockchainService {

    public init() {
        
    }
    
    public var externalServiceProvider:String
    {
        get {
            return "api.blockcypher.com"
        }
    }
    
    public func coinsForAddress(address: String, withCallback callback: @escaping (NSDecimalNumber) -> Void) {
        //let url = URL(string: "https://chain.so/api/v2/get_address_balance/LTC/\(address)/16")
        let url = URL(string: "https://api.blockcypher.com/v1/ltc/main/addrs/\(address)/balance")

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            let status = (response as! HTTPURLResponse).statusCode
            print("response status: \(status)")

            if let data = data {
                do {
                    let json = try JSON(data: data)
                    
                    let balance = NSDecimalNumber.init(string: json["final_balance"].stringValue).dividing(by: NSDecimalNumber.init(mantissa: 1, exponent: 8, isNegative: false))
                                        
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
    
    public func isValid(address: String?) -> Bool {
        if let address = address {
            do {
                return try Regex(pattern: "^[LM3][a-km-zA-HJ-NP-Z1-9]{26,33}$",
                                 options: [],
                                 groupNames: []).matches(address)
            }
            catch { }
        }
        return false
    }
}

public class BitcoinService : BlockchainService {
    
    public init() {
        
    }
    
    public var externalServiceProvider:String
    {
        get {
            return "blockchain.info"
        }
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
    
    public func isValid(address: String?) -> Bool {
        /**
         * bitcoin address is
         *
         * - an identifier of 26-35 alphanumeric characters
         * - beginning with the number 1 or 3
         * - random digits
         * - uppercase
         * - lowercase letters
         * - with the exception that the uppercase letter O, uppercase letter I, lowercase letter l, and the number 0 are never used to prevent visual ambiguity.
         * DOES NOT SUPPORT https://en.bitcoin.it/wiki/Bech32
         * https://en.bitcoin.it/wiki/Address
         */
        if let address = address {
            do {
                return try Regex(pattern: "^[13][a-km-zA-HJ-NP-Z1-9]{25,34}$",
                                 options: [],
                                 groupNames: []).matches(address)
            }
            catch {}
        }
        return false
    }
}

public class RippleService : BlockchainService {
    
    public init() {
        
    }
    
    public var externalServiceProvider:String
    {
        get {
            return "data.ripple.com"
        }
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
    
    public func isValid(address: String?) -> Bool {
        /**
         * https://github.com/k4m4/ripple-regex
         */
        if let address = address {
            do {
                return try Regex(pattern: "^r[0-9a-zA-Z]{33}$",
                                 options: [],
                                 groupNames: []).matches(address)
            }
            catch { }
        }
        return false
    }
}

public class EtheriumClassicService : BlockchainService {
    
    public init() {
        
    }
    
    public var externalServiceProvider:String
    {
        get {
            return "api.gastracker.io"
        }
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
    
    public func isValid(address: String?) -> Bool {
        /**
         * https://github.com/k4m4/ethereum-regex
         */
        if let address = address {
            do {
                return try Regex(pattern: "^0x[a-fA-F0-9]{40}$",
                                 options: [],
                                 groupNames: []).matches(address)
            }
            catch { }
        }
        return false
    }
}

public class BitcoinCashService : BlockchainService {
    
    public init() {
        
    }
    
    public var externalServiceProvider:String
    {
        get {
            return "blockdozer.com"
        }
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
    
    public func isValid(address: String?) -> Bool {
        if let address = address {
            do {
                return try Regex(pattern: "^[13][a-km-zA-HJ-NP-Z1-9]{33}$",
                                 options: [],
                                 groupNames: []).matches(address)
            }
            catch { }
        }
        return false
    }
}

