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
    let requestClient: RequestClient
    var cancellables: [AnyCancellable] = []
    
    init(_ requestClient: RequestClient = RequestClient()) {
        self.requestClient = requestClient
    }
    
    func fetchImage(for urlString: String,completion: @escaping (Result<UIImage?, Error>) -> ()) {
        requestClient.make(requestWith: urlString)
            .sink { _ in
                
            } receiveValue: { data in
                completion(.success(ImagerParser.parse(data)))
            }.store(in: &cancellables)
    }
}

public class ImagerParser {
    static func parse(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}

protocol Requestable {
    func make(
        requestWith urlString: String
    ) -> AnyPublisher<Data, Error>
}

final class RequestClient: Requestable {
    func make(requestWith urlString: String) -> AnyPublisher <Data, Error> {
        return URLSession
            .DataTaskPublisher(request: URLRequest(url: URL(string: urlString)!), session: .shared)
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
