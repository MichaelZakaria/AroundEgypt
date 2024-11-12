//
//  NetworkSevice.swift
//  AroundEgypt
//
//  Created by Marco on 2024-11-11.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(url: String, method: APIHandler.Method, type: T.Type, decodResult: Bool, handler: @escaping (Result<T, Error>) -> Void)
}

class NetworkSevice: NetworkServiceProtocol {
    static let instance = NetworkSevice()
    
    // Cache Key for UserDefaults
    private let cacheKeyPrefix = "cached_"
    
    private init () {}
    
    // Save data to UserDefaults cache
    private func saveToCache(data: Data, for url: String) {
        let key = cacheKey(for: url)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // Load data from cache
    private func loadFromCache(for url: String) -> Data? {
        let key = cacheKey(for: url)
        return UserDefaults.standard.data(forKey: key)
    }
    
    // Cache key generator to ensure unique keys for each endpoint
    private func cacheKey(for url: String) -> String {
        return "\(cacheKeyPrefix)\(url)"
    }
    
    func fetchData<T>(url: String, method: APIHandler.Method, type: T.Type, decodResult: Bool, handler: @escaping (Result<T, any Error>) -> Void) where T : Decodable, T : Encodable {
        
        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                // Check cache first
                if let cachedData = self.loadFromCache(for: url.absoluteString) {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: cachedData)
                        handler(.success(decodedData))
                        return
                    } catch {
                        handler(.failure(error))
                        return
                    }
                }
                handler(.failure(error))
                return
            }
            
            // Check if the response is valid (status code 200-299)
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                handler(.failure(URLError(.badServerResponse)))
                return
            }
            
            // Ensure there's data
            guard let data = data else {
                handler(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            if decodResult {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    // Save data to cache after successful network fetch
                    self.saveToCache(data: data, for: url.absoluteString)
                    handler(.success(response))
                } catch {
                    handler(.failure(error))
                }
            } else {
                handler(.success(data as! T))
            }
            
        }
        task.resume()
    }
}
