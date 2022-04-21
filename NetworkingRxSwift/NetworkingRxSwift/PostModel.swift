//
//  PostModel.swift
//  NetworkingRxSwift
//
//  Created by Aleksandar Filipov on 4/21/22.
//

import Foundation

// MARK: - PostModel
public struct PostModel: Codable {
    private var id: Int
    private var userId: Int
    private var title: String
    private var body: String
    
    init(id: Int, userId: Int, title: String, body: String) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
    
    func getId() -> Int {
        self.id
    }
    
    func getUserId() -> Int {
        self.userId
    }
    
    func getTitle() -> String {
        self.title
    }
    
    func getBody() -> String {
        self.body
    }
}
