//
//  Response.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

// Responseの構成要素
struct Response {
    // HTTPステータスコード
    var statusCode: HTTPStatus
    // HTTPヘッダー
    var headers: [String: String]
    // ペイロード レスポンスの内容
    var payload: Data
}

// HTTPステータス　HTTPステータスコードから判定
enum HTTPStatus {
    // HTTPステータスコードが200番台の場合
    case ok
    // HTTPステータスコードが404の場合 リクエストで要求された項目がない場合
    case notFpund
    // 他にもステータスコードがあるが面倒なのでひとまとめにする
    case notSupported(code: Int)
    
    // HTTPステータスコードからHTTPStatus型を作る
    static func from(statusCode: Int) -> HTTPStatus {
        switch statusCode {
        case 200:
            return .ok
        case 404:
            return .notFpund
        default:
            return .notSupported(code: statusCode)
        }
    }
}
