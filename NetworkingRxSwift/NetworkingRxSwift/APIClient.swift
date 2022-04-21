//
//  APIClient.swift
//  NetworkingRxSwift
//
//  Created by Aleksandar Filipov on 4/21/22.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - extension for converting our RecipeModel to jsonObject
fileprivate extension Encodable {
    var dictionaryValue: [String: Any?]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}

class APIClient {
    static var shared = APIClient()
    lazy var requestObservable = RequestObservable(config: .default)
    
    func getRecipes() throws -> Observable<[PostModel]> {
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return requestObservable.callAPI(request: request)
    }
    
    func sendPost(recipeModel: PostModel) -> Observable<PostModel> {
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payloadData = try? JSONSerialization.data(withJSONObject: recipeModel.dictionaryValue!, options: [])
        request.httpBody = payloadData
        return requestObservable.callAPI(request: request)
    }
}
