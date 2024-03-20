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

    override func setUpWithError() throws {
        viewModel = MatchesListViewModel(self, networkManager: NetworkManagerMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetMatches() async {
        let error = await viewModel?.getMatches()
        XCTAssertNil(error)
        XCTAssertEqual(viewModel?.matchesPerDay.keys.count, 2)
        XCTAssertFalse(viewModel?.matchesPerDay.values.first?.isEmpty ?? true)
    }
}
