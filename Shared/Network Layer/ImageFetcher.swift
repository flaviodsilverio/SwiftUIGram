//
//  ImageFetcher.swift
//  SwiftUIGram
//
//  Created by Flávio Silvério on 08/10/2021.
//

import Foundation
import UIKit
import Combine

enum NetworkError: Error {
    case malformedURL
    case unknown
}

public class ImageFetcher {
    let requestMaker = RequestMaker()
    var cancellables: [AnyCancellable] = []
    
    func fetchImage(for urlString: String, completion: @escaping (UIImage?) -> ()) {
        requestMaker.make(requestWithURLString: urlString)
            .sink { receiveCompletion in
                print("completion")
            } receiveValue: { data in
                completion(ImagerParser.parse(data))
            }.store(in: &cancellables)
    }
}

public class ImagerParser {
    static func parse(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}

public class RequestMaker {
    let session: URLSession

    init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func make(requestWithURLString string: String) -> AnyPublisher <Data, Error> {
        return session.dataTaskPublisher(for: URLRequest(url: URL(string: string)!)).tryMap { data, response in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw APIError.unknown
            }
            return data

        }
        .mapError { error in
            if let error = error as? APIError {
                return error
            } else {
                return APIError.apiError(description: error.localizedDescription)
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func make(requestWithURLString string: String, completion: @escaping (_ data: Data?, _ error: NetworkError?)->()) {
        
        guard let url = URL(string: string) else {
            completion(nil, NetworkError.malformedURL)
            return
        }
                
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  error == nil else {
                completion(nil, NetworkError.unknown)
                return
            }
            
            completion(data, nil)
            
        }.resume()
    }
}


protocol Requestable {
    func make(
        _ request: URLRequest,
        _ decoder: JSONDecoder
    ) -> AnyPublisher<Data, Error>
}

struct RequestClient: Requestable {
    func make(_ request: URLRequest, _ decoder: JSONDecoder) -> AnyPublisher <Data, Error> {
        return URLSession
            .DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown
                }
                return data

            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(description: error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case apiError(description: String?)
    case unknown

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}
