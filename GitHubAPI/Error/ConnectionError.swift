//
//  ConnectionError.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

// レスポンスのエラー(データがない、接続の問題でレスポンス自体が無いなど)
enum ConnectionError {
    case noDataOrNoResponse(debugInfo: String)
}
