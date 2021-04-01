//
//  WebAPI.swift
//  GitHubAPI
//
//  Created by 三浦　登哉 on 2021/04/01.
//

import Foundation

// APIへの入力を表す
typealias Input = Request

// WebAPI
enum WebAPI {
    // API通信実行 ( アプリ →→ Request →→ サーバー →→ Response →→ アプリ )  //Input(Request)型の引数を受け、WebAPI.callで呼び出す
    static func call(with input: Input, _ block: @escaping(Output) -> Void) {
        // URLRequestを作成
        let urlRequest = createURLRequest(by: input)
        // 通信処理を作成
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            // アウトプットを作成
            let output = self.createOutput(data: data, response: urlResponse as? HTTPURLResponse, error: error)
            block(output)
        }
        // taskを実行
        task.resume()
    }
    
    // 実際にURLSessionクラスが扱うリクエストはURLRequest型なので変換する必要がある
    // Input型(Request型)をURLRequest型に変換
    static private func createURLRequest(by input: Input) -> URLRequest {
        // Input型で定義した構成要素をURLRequest型に当てはめていく
        var request = URLRequest(url: input.url)
        request.httpMethod = input.methodAndPayload.method
        request.httpBody = input.methodAndPayload.payload
        request.allHTTPHeaderFields = input.header
        
        return request
    }
    
    // 受け取るのはURLResponse型なので、Output型に変換する必要がある(URLRespnseをResponseに変換する)
    static private func createOutput(data: Data?, response: HTTPURLResponse?, error: Error?) -> Output {
        guard let data = data, let response = response else {
            return .noResponse(.noDataOrNoResponse(debugInfo: error.debugDescription))
        }
        var headers: [String: String] = [:]
        for (key, value) in response.allHeaderFields.enumerated() {
            headers[key.description] = String(describing: value)
        }
        
        // hasResponseの付属値(Response型)はURLResponse
        return .hasResponse(
            Response(
                // HTTPステータスコードからHTTPステータスを返す
                statusCode: HTTPStatus.from(statusCode: response.statusCode),
                // 変換後のヘッダーを返す
                headers: headers,
                // そのまま
                payload: data
            ))
    }
}

// APIからの出力を表す
// レスポンスがある場合とない場合
enum Output {
    // レスポンスがある場合
    // 連想値(付加情報)はResponse型
    case hasResponse(Response)
    // レスポンスがない場合
    // 連想値はconnectionError型
    case noResponse(ConnectionError)
    
    // output.hasResponse(response).resultでresponseにアクセスできる
    var result: Response? {
        switch self {
        case let .hasResponse(x):
            return x
        case .noResponse(_):
            return nil
        }
    }
    /*あとあと連想値を取り出す
     switch output {
     case .hasResponse(let response):
     // response.peyloadを型変換
     case .noResponse(let connectionError):
     // エラー時の処理
     }*/
}






