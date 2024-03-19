//
//  MatchesListViewModel.swift
//  grenta_task
//
//  Created by Amr Koritem on 19/03/2024.
//

import Foundation

typealias ErrorMessage = String

protocol MatchesListViewModelDelegate: AnyObject {}

protocol MatchesListViewModelProtocol {
    var matches: [Match] { get }
    func getMatches() async -> ErrorMessage?
}

class MatchesListViewModel: MatchesListViewModelProtocol {
    var matches: [Match] = []

    private weak var delegate: MatchesListViewModelDelegate?
    
    private let networkManager = NetworkManager.shared

    init(_ delegate: MatchesListViewModelDelegate) {
        self.delegate = delegate
    }

    func getMatches() async -> ErrorMessage? {
        let today = Date()
        let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        let format = "yyyy-MM-dd"
        let filters = [
            String.Filter.dateFrom : today.toString(withFormat: format),
            String.Filter.dateTo : nextYear?.toString(withFormat: format)
        ]
        let url = String.Urls.matches.withFilters(filters)
        let request = DataRequest(
            url: url,
            method: .get
        )
        let (status, data) = await networkManager.request(request)
        guard let status = status,
              status >= 200 && status < 300 else {
            let errors = data?.get(ApiError.self)
            return errors?.message ?? "Something went wrong"
        }
        let response = data?.get(MatchesListResponse.self)
        matches = response?.matches ?? []
        return nil
    }
}
