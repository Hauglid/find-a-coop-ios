//
//  SearchViewLogicController.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 22/11/2022.
//

import Foundation

class SearchViewLogicController{
    
    typealias Handler = (StoreViewState) -> Void
    
    func load(query: String?, then handler: @escaping Handler) {
        // Load the state of the view and then run a completion handler
        handler(.loading)
        
        // Get stores and present
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "coop.no"
        components.path = "/StoreService/SearchStores"

        components.queryItems = [
            URLQueryItem(name: "searchInput", value: query),
        ]
        
        var request = URLRequest(url: components.url!,timeoutInterval: Double.infinity)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                handler(.failed(String(describing: error)))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromPascalCase

            do {
                let storesInfo = try decoder.decode(StoresInfo.self, from: data)
                handler(.presentingStores(storesInfo.stores))
            } catch {
                handler(.failed(String(describing: error)))
            }
            
        }
        
        task.resume()
        
    }
    
    
    
}
extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: JSONDecoder.KeyDecodingStrategy {
        return .custom { keys -> CodingKey in
            // keys array is never empty
            let key = keys.last!
            // Do not change the key for an array
            guard key.intValue == nil else {
                return key
            }

            let codingKeyType = type(of: key)
            let newStringValue = key.stringValue.firstCharLowercased()

            return codingKeyType.init(stringValue: newStringValue)!
        }
    }
}

private extension String {
    func firstCharLowercased() -> String {
        prefix(1).lowercased() + dropFirst()
    }
}
