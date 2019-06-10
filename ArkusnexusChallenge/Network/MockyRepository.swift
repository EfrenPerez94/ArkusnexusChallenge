//
//  mockyRepository.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/9/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

class MockyRepository {
/// Perform a GET request to Mocky, handling errors and response.
///
/// - Parameters:
///   - completion: Closure that returns `data` for the network request.
///   - data: Data information retrieve from the API as `Place` object.
    func execute(completion: @escaping (_ data: Result<[Place], Error>) -> Void) {
        
        guard let url = URL(string: Constants.apiURL) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil, let data = data else {
                completion(Result.failure(error ?? NetworkError.dataIsNil))
                return
            }
            
            do {
                let MockyData = try JSONDecoder().decode([Place].self, from: data)
                
                completion(Result.success(MockyData))
            } catch {
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                    print(JSONString)
                }
                completion(Result.failure(NetworkError.unableToDecode))
            }
        }.resume()
        return
    }
    
}

/// `NetworkError` specify problems when making a request.
enum NetworkError: Error {
    case dataIsNil
    case unableToDecode
}
