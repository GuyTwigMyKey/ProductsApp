//
//  NetworkManager.swift
//  ProductsApp
//
//  Created by Guy Twig on 16/07/2023.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    private var cancellables = Set<AnyCancellable>()
    private let output: PassthroughSubject<Output, Never> = .init()
    
    enum Input {
        case fetchData
    }
    
    enum Output {
        case fetchDataDidFail(error: Error)
        case fetchDataDidSucceed(T: Codable)
    }
    
    func genericCombineGetCall<T: Codable>(url: URLRequest, type: T.Type) -> AnyPublisher<T, Error> {
        var request = url
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .catch { error in
                return Fail(error: NetworkManagerErrorsHandler.requestError(.invalidRequest(request))).eraseToAnyPublisher()
            }
            .tryMap { res in
                guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw NetworkManagerErrorsHandler.serverError(.invalidStatusCode("Invalid status code"))
                }

                let decoder = JSONDecoder()
                guard let finalData = try? decoder.decode(T.self, from: res.data) else {
                    throw NetworkManagerErrorsHandler.requestError(.decodingError("Fail to decode"))
                }
                
                  return finalData
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

