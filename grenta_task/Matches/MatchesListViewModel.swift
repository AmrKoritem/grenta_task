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
    func getIsFavouriteMatch(_ match: Match) -> Bool
    @discardableResult func getMatches() async -> ErrorMessage?
}

class MatchesListViewModel: MatchesListViewModelProtocol {
    var matches: [Match] = []
    var matchesPerDay: [String : [Match]] = [:]

    private weak var delegate: MatchesListViewModelDelegate?
    
    let networkManager: NetworkManagerProtocol
    let userDefaults: UserDefaultsProtocol

    init(
        _ delegate: MatchesListViewModelDelegate,
        networkManager: NetworkManagerProtocol? = nil,
        userDefaults: UserDefaultsProtocol? = nil
    ) {
        self.delegate = delegate
        self.networkManager = networkManager ?? NetworkManager.shared
        self.userDefaults = userDefaults ?? UserDefaults.standard
    }
    
    func getIsFavouriteMatch(_ match: Match) -> Bool {
        return userDefaults.favouriteMatches.contains(match.id)
    }
    
    func setMatch(_ matchId: Int, isFavourite: Bool) {
        var favouriteMatches = userDefaults.favouriteMatches
        if isFavourite {
            guard !favouriteMatches.contains(matchId) else { return }
            favouriteMatches.append(matchId)
        } else {
            favouriteMatches.removeAll { $0 == matchId }
        }
        userDefaults.set(favouriteMatches, forKey: UserDefaults.Keys.favourites.rawValue)
    }

    @discardableResult func getMatches() async -> ErrorMessage? {
        let today = Date()
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
        let format = "yyyy-MM-dd"
        let filters = [
            String.Filter.dateFrom : today.toString(withFormat: format),
            String.Filter.dateTo : nextMonth?.toString(withFormat: format)
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
