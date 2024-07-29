//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Abd Elrahman Atallah on 29/07/2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badUrlResponse
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badUrlResponse:
                return "[🔥] Bad response from URL"
            case .unknown:
                return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
       return URLSession.shared.dataTaskPublisher(for: url)
             .subscribe(on: DispatchQueue.global(qos: .default))
             .tryMap (handelOutput)
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
    }
    
   static func handelOutput(output : URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let respnse = output.response as? HTTPURLResponse ,
            respnse.statusCode >= 200 && respnse.statusCode < 300 else {
            throw NetworkingError.badUrlResponse
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<any Error> ) {
        switch completion {
        case .finished:
            print("finishes")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
