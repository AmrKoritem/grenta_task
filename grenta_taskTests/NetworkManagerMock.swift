//
//  NetworkManagerMock.swift
//  grenta_taskTests
//
//  Created by Amr Koritem on 20/03/2024.
//

import Foundation
@testable import grenta_task

class NetworkManagerMock: NetworkManagerProtocol {
    var isConnected: Bool { true }
    
    var baseUrl: String { "" }
    
    func request(_ request: grenta_task.DataRequest) async -> (status: Int?, data: Data?) {
        guard let path = Bundle.main.path(forResource: "mockMatches", ofType: "json") else { return (nil, nil) }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return (nil, data)
        } catch {
            printInDebug("\(error)")
            return (nil, nil)
        }
    }
}
