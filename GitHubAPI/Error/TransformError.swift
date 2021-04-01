//
//  TransformError.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

//　受け取ったレスポンスを型変換するときに発生しうるエラー
enum TransformError {
    // HTTPステータスOK意外だった時
    case unExpectedStatudCode(debugInfo: String)
    // ペイロードに問題がある時
    case malformedData(debugInfo: String)
}
