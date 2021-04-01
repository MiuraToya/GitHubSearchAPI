//
//  Either.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

// レスポンスについて、エラーor正常の2パターンを定義(APIによって柔軟に変更できるようにEitherで定義)
enum Either<Left, Right> {
    // 付属値は左に入った型
    case left(Left)
    // 付属値は右に入った型
    case right(Right)
    
    // 左側の型ならその値を返す。
    var left: Left? {
        switch self {
        case let .left(x):
            return x
        case .right:
            return nil
        }
    }
// 右側の値ならその値を返す。
    var right: Right? {
        switch self {
        case .left:
            return nil
        case let .right(x):
            return x
        }
    }
}

