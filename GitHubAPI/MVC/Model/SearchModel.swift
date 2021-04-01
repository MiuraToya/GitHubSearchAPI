//
//  SearchModel.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

struct SearchModel<Item:Codable>: Codable {
    var totalCount: Int
    var items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
