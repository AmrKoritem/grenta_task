//
//  DataRequest.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation
import Alamofire

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
