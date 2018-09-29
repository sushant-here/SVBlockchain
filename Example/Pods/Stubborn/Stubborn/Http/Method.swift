//
//  Method.swift
//
//  Created by materik on 2018-08-15.
//

import Foundation

public enum Method: String {
    
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
    
}

extension Method: Equatable {}

public func == (lhs: Method, rhs: Method) -> Bool {
    return lhs.rawValue == rhs.rawValue
}
