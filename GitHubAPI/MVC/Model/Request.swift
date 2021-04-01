//
//  Request.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

// Requestの構成要素
struct Request {
    // URL
    var url: URL
    // 検索文字列やページ数の指定
    var queries: [URLQueryItem]
    // HTTPヘッダー。　ヘッダー名と値の辞書
    var header: [String: String]
    // メソッド(GETなど)とペイロードは関係あるからセットにする
    var methodAndPayload: HTTPMethodAndPayload
}


// HTTPメソッドとペイロードの組み合わせ
enum HTTPMethodAndPayload {
    // 今回はGETの場合のみを考慮
    case get
    // HTTPメソッド　methodはGET
    var method: String {
        switch self {
        case .get:
            return "GET"
        }
    }
    // ペイロード HTTPメソッドがGETの時は不要なのでnil
    var payload: Data? {
        switch self {
        case .get:
            // HTTOメソッドがGETの時はペイロードは取れない
            return nil
        }
    }
}
