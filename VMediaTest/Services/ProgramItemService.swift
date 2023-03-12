//
//  ProgramItemService.swift
//  VMediaTest
//
//  Created by Heramb on 10/03/23.
//

import ObjectMapper

class ProgramItemService {
    
    static let shared = { ProgramItemService() }()
    
    func getProgramItems(count: Int, success: @escaping (Int, [ProgramItem]) -> (), failure: @escaping (Int) -> ()) {
        
        let urlString = self.configureApiCall(Endpoints.PROGRAMITEMS, "count", "\(count)")
        
        APIClient.shared.getArray(urlString: urlString, success: { (code, arrayOfPrograms) in
            success(code, arrayOfPrograms)
            
        }) { (code) in
            failure(code)
        }
    }
    
    func configureApiCall(_ baseURL: String, _ parameter: String, _ value: String) -> String {
        return "https://demo-c.cdn.vmedia.ca/json/" + baseURL
    }
}


