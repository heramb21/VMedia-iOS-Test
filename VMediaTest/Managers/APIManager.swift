//
//  APIManager.swift
//  VMediaTest
//
//  Created by Heramb on 01/03/23.
//

import Foundation

class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://demo-c.cdn.vmedia.ca/json/"
    }()
}
