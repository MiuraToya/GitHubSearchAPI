//
//  Repository.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

//<<<<<<<<<<<<<<<<本題>>>>>>>>>>>>>>>>>
// GitHubのユーザー
struct User: Codable {
    var id: Int
    var login: String
}
// GitHubのリポジトリ
struct  Repository: Codable {
    var id: Int
    var name: String
    var fullName: String
    var owner: User
    
    // JSONではfull_nameとなっているので対応関係を少し明確にする
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name" // JSONではfull_name
        case owner
    }
}
