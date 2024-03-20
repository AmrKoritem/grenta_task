//
//  grenta_taskTests.swift
//  grenta_taskTests
//
//  Created by Amr Koritem on 17/03/2024.
//

import XCTest
@testable import grenta_task

final class ViewModelTests: XCTestCase, MatchesListViewModelDelegate {
    var viewModel: MatchesListViewModelProtocol?
    let userDefaults = UserDefaultsMock()

    override func setUpWithError() throws {
        viewModel = MatchesListViewModel(self, networkManager: NetworkManagerMock(), userDefaults: userDefaults)
    }
    
    func testGetMatches() async {
        let error = await viewModel?.getMatches()
        XCTAssertNil(error)
        XCTAssertEqual(viewModel?.matchesPerDay.keys.count, 2)
        XCTAssertFalse(viewModel?.matchesPerDay.values.first?.isEmpty ?? true)
    }

    func testSetFavourite() async {
        await viewModel?.getMatches()
        guard let matchId = viewModel?.matchesPerDay["2023-08-11"]?.first?.id else {
            XCTFail("match not found")
            return
        }
        viewModel?.setMatch(matchId, isFavourite: true)
        XCTAssertTrue(userDefaults.favouriteMatches.contains(matchId))
        viewModel?.setMatch(matchId, isFavourite: false)
        XCTAssertFalse(userDefaults.favouriteMatches.contains(matchId))
    }
}
