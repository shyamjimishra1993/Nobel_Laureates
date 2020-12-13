//
//  LaureatesViewModelTests.swift
//  Nobel_LaureatesTests
//
//  Created by Shyam on 12/12/20.
//  Copyright © 2020 shyamOrg. All rights reserved.
//

import XCTest
import CoreLocation

@testable import Nobel_Laureates

class LaureatesViewModelTests: XCTestCase {

    func testSearchTop20Laureates() throws {
        let laureatesViewModel = LaureatesViewModel()
        let lat = 42.335631100000001
        let lng = -71.104119099999991
        let topLaureates = laureatesViewModel.searchTop20Laureates(year: 2010, location: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        var isSorted = true
        for i in 1 ..< topLaureates.count {
            if topLaureates[i-1].averageOfDistanceAndYearDiff > topLaureates[i].averageOfDistanceAndYearDiff {
                isSorted = false
                break
            }
        }
        XCTAssertTrue(topLaureates.count == 20)
        XCTAssertTrue(isSorted) // Checking if the returned results are sorted based on averageOfDistanceAndYearDiff
    }
}
