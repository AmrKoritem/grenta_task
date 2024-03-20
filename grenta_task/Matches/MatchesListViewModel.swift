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
    var matchesPerDay: [String : [Match]] { get }
    func setMatch(_ matchId: Int, isFavourite: Bool)
    func getMatches() async -> ErrorMessage?
}

class MatchesListViewModel: MatchesListViewModelProtocol {
    var matches: [Match] = []
    var matchesPerDay: [String : [Match]] = [:]

    private weak var delegate: MatchesListViewModelDelegate?
    
    private let networkManager = NetworkManager.shared

    init(_ delegate: MatchesListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setMatch(_ matchId: Int, isFavourite: Bool) {
        var favouriteMatches = UserDefaults.favouriteMatches
        if isFavourite {
            guard !favouriteMatches.contains(matchId) else { return }
            favouriteMatches.append(matchId)
        } else {
            favouriteMatches.removeAll { $0 == matchId }
        }
        UserDefaults.standard.set(favouriteMatches, forKey: UserDefaults.Keys.favourites.rawValue)
    }

    func getMatches() async -> ErrorMessage? {
        let today = Date()
        let nextYear = Calendar.current.date(byAdding: .day, value: 1, to: Date())
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
        matches.forEach { match in
            guard let day = match.date else { return }
            matchesPerDay[day] = matches.filter { $0.date == day }
        }
        return nil
    }
}
