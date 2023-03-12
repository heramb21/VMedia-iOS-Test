//
//  ChannelsService.swift
//  VMediaTest
//
//  Created by Heramb on 10/03/23.
//

import ObjectMapper

class ChannelsService {
    
    static let shared = { ChannelsService() }()
    
    func getChannels(count: Int, success: @escaping (Int, [Channel]) -> (), failure: @escaping (Int) -> ()) {
        
        let urlString = self.configureApiCall(Endpoints.CHANNELS, "count", "\(count)")
        
        APIClient.shared.getArray(urlString: urlString, success: { (code, arrayOfChannels) in
            success(code, arrayOfChannels)
            
        }) { (code) in
            failure(code)
        }
    }
    
    func configureApiCall(_ baseURL: String, _ parameter: String, _ value: String) -> String {
        return "https://demo-c.cdn.vmedia.ca/json/" + baseURL
    }
}

