//
//  NetworkManager.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    var isConnected: Bool { get }
    var baseUrl: String { get }
    @discardableResult func request(_ request: DataRequest) async -> (status: Int?, data: Data?)
}

struct DataRequest {
    let url: String
    let method: HTTPMethod
    let parameters: Parameters?
    let headers: HTTPHeaders?

    init(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
}

class NetworkManager: NetworkManagerProtocol {
    static let notConnectedStatus = 1010
    static let shared = NetworkManager()

    var isConnected: Bool { NetworkReachabilityManager()?.isReachable ?? false }
    var defaultHeader: HTTPHeaders { [:] }
    var baseUrl: String { String.Urls.base.rawValue }

    private init() {}
    
    @discardableResult public func request(_ request: DataRequest) async -> (status: Int?, data: Data?) {
        let isUrlEncoding = request.method == .get || request.method == .patch
        let encoding: ParameterEncoding = isUrlEncoding ? URLEncoding.default : JSONEncoding.default
        return await self.request(request, encoding: encoding)
    }

    private func request(_ request: DataRequest, encoding: ParameterEncoding) async -> (status: Int?, data: Data?) {
        guard isConnected else { return (NetworkManager.notConnectedStatus, nil) }
        let reqUrl = baseUrl.appending(request.url)
        let timeBefore = Date()
        let req = AF.request(
            reqUrl,
            method: request.method,
            parameters: request.parameters,
            encoding: encoding,
            headers: request.headers)
        let response = await req.serializingData().response
        let timeAfter = Date()
        printInDebug("headers: \(String(describing: request.headers))")
        printInDebug("url: \(reqUrl)")
        printInDebug("type: \(request.method.rawValue)")
        printInDebug("parameters: \(request.parameters ?? [:])")
        printInDebug("encoding: \(encoding)")
        printInDebug("requestTime: \(timeAfter.timeIntervalSince1970 - timeBefore.timeIntervalSince1970)")
        return handleResponse(response: response)
    }

    private func handleResponse(response: AFDataResponse<Data>) -> (status: Int?, data: Data?) {
        printInDebug("status: \(String(describing: response.response?.statusCode))")
        switch response.result {
        case .success(let data):
//        if let data = response.data {
//            print("string data: \(String(describing: String(data: data, encoding: .utf8)))")
//        }
            printInDebug("json: \(String(describing: data.printable))")
            return (response.response?.statusCode, data)
        case .failure(let error):
            printInDebug("error: \(String(describing: error.errorDescription))")
            if let data = response.data {
                printInDebug("string error: \(String(describing: String(data: data, encoding: .utf8)))")
            }
            printInDebug("json: \(String(describing: response.data?.printable))")
            return (response.response?.statusCode, response.data)
        }
    }

    func printInDebug(_ string: String) {
        #if DEBUG
        print(string)
        #endif
    }
}
