//
//  StoresApi.swift
//  Find A Coop
//
//  Created by Karl Thomas Hauglid on 22/11/2022.
//

import Foundation
class StoresApi{
    func getStores(query: String) -> Void {
        
        
        var request = URLRequest(url: URL(string: "https://coop.no/StoreService/SearchStores?searchInput=Lindeberg")!,timeoutInterval: Double.infinity)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        
    }
}
