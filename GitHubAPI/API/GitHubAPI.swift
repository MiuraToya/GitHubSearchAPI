//
//  GithubAPI.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

struct GitHubAPI {

    // レスポンスをGitHubのリポジトリに変換するメソッド(JSONなのでDecode)
    static func from(response: Response) -> Either<TransformError, SearchModel<Repository>> {
        switch response.statusCode {
        case .ok:
            do{
                let decoder = JSONDecoder()
                let repositoly = try decoder.decode(SearchModel<Repository>.self, from: response.payload)
                return .right(repositoly)
            } catch {
                return .left(.malformedData(debugInfo: "\(error.localizedDescription)"))
            }
        default:
            return .left(.unExpectedStatudCode(debugInfo: "\(response.statusCode)"))
        }
    }
    
    //from()を実行して変換後の配列を取得
    static func fetch(by keyword: String, _ block: @escaping(Either<Either<ConnectionError, TransformError>, SearchModel<Repository>>) -> Void) -> Void {
        let urlStr: String = "https://api.github.com/search/repositories"
        guard let baseUrl = URL(string: urlStr) else {
            block(.left(.left(.noDataOrNoResponse(debugInfo: ""))))
            return
        }
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "q", value: keyword)]
        guard let url = components?.url else {return}
        
        let input = Input(
            url: url,
            queries: [],
            header: [:],
            methodAndPayload: .get
        )
        // WebAPIを呼び出して通信開始
        WebAPI.call(with: input) { output in
            switch output {
            // レスポンスを受け取れなかった場合
            case let .noResponse(connectionError):
                block(Either.left(.left(connectionError)))
                return
            // レスポンスを受け取った場合
            case let .hasResponse(response):
                // 型変換メソッド実行
                let repositoly = GitHubAPI.from(response: response)
                // 型変換の結果
                switch repositoly {
                // 失敗
                case let .left(transformError): // エラーはここ！
                    block(Either.left(.right(transformError)))
                // 成功
                case let .right(repositoly):
                    block(Either.right(repositoly))
                }
            }
        }
    }
}
