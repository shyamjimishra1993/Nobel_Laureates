//
//  LaureatesViewModel.swift
//  Nobel_Laureates
//
//  Created by Shyam on 12/12/20.
//  Copyright © 2020 shyamOrg. All rights reserved.
//

import UIKit
import CoreLocation

class LaureatesViewModel: NSObject {
    let jsonFileName = "nobel_prize_laureates"
    
    /// This function returns top 20 nobel laureates baseed on search criteria passed in the method arguments
    ///
    /// ```
    /// It first calculates averageOfDistanceAndYearDiff.
    /// averageOfDistanceAndYearDiff represents the number by which a laureate differs
    /// from the search criteria and calucalted as the average of following two-
    /// 1) The year difference between award year and year entered by user in serach criterai.
    /// 2) The distance between the location of Laureate and the location entered in the search criteria.
    /// The less this number, the more rating laureate will have
    /// Then based on averageOfDistanceAndYearDiff, It sorts the results and returns top 20 laureates
    /// ```
    ///
    /// - Parameter year: The year for which to search the laureates
    /// - Parameter location: The locationn for which to search the laureates
    /// - Returns: Top 20 nobel laureates baseed on search criteria passed in the method arguments.
    func searchTop20Laureates(year:Int, location:CLLocationCoordinate2D) -> [LaureatesWithRatingDetails] {
        var laureatesWithRatingDetails = [LaureatesWithRatingDetails]()
        let nobelLaureates = self.readJSONFromFile(fileName: jsonFileName)
        if let laureates = nobelLaureates {
            for laureate in laureates
            {
                let awardYear = laureate.year
                let lat = laureate.location.lat
                let long = laureate.location.lng
                let yearDifference = abs(year - Int(awardYear)!)
                let location1 = CLLocation(latitude: location.latitude, longitude: location.longitude)
                let location2 = CLLocation(latitude: lat, longitude: long)
                let distance = location1.distance(from: location2) / 1000 // Distance in KM
                let averageOfDistanceAndYearDiff = (Double(yearDifference) + distance) / 2
                laureatesWithRatingDetails.append(LaureatesWithRatingDetails(laureate: laureate, distance: distance, yearDifference: yearDifference, averageOfDistanceAndYearDiff: averageOfDistanceAndYearDiff))
            }
        }
        let laureatesInSortedOrder = laureatesWithRatingDetails.sorted(by:{ $0.averageOfDistanceAndYearDiff < $1.averageOfDistanceAndYearDiff}) // O(n log n), where n is the length of the sequence.
        return Array(laureatesInSortedOrder.prefix(20))
    }
    
    func readJSONFromFile(fileName: String) -> [NobelLaureateModel]?
    {
        var laureates:[NobelLaureateModel]?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                laureates = try? decoder.decode(NobelLaureates.self, from: data)
            } catch {
                // Handle error here
                print("The file could not be loaded")
            }
        }
        return laureates
    }
}

struct LaureatesWithRatingDetails {
    let laureate:NobelLaureateModel
    let distance:Double //in KM
    let yearDifference:Int
    let averageOfDistanceAndYearDiff:Double // "This represents the number by which a laureate differs from the search criteria. The number represents the value calucalted as the average of following two- 1) The year difference between award year and year entered by user in serach criterai. 2) The distance between the location of Laureate and the location entered in the search criteria. The less this number, the more rating laureate will have."
}
