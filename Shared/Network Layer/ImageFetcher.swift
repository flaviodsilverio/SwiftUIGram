//
//  ImageFetcher.swift
//  SwiftUIGram
//
//  Created by Flávio Silvério on 08/10/2021.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case malformedURL
    case unknown
}

public class ImageFetcher {
    let requestMaker = RequestMaker()
    
    func fetchProfileImage(for urlString: String, completion: @escaping (UIImage?) -> ()) {
        requestMaker.make(requestWithURLString: urlString) { data, error in
            guard let data = data,
                  error == nil else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            
           completion(image)
        }
    }
    
    func fetchImage(for urlString: String, completion: @escaping (UIImage?) -> ()) {
        requestMaker.make(requestWithURLString: urlString) { data, error in
            guard let data = data,
                  error == nil else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            
           completion(image)
        }
    }
}

public class RequestMaker {
    let session = URLSession.shared

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
