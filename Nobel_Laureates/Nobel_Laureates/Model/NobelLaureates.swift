//
//  NobelLaureates.swift
//  Nobel_Laureates
//
//  Created by Shyam on 12/12/20.
//  Copyright © 2020 shyamOrg. All rights reserved.
//

import Foundation

// MARK: - NobelLaureateModel
struct NobelLaureateModel: Codable {
    let id: Int
    let category: Category
    let died, diedcity, borncity, born: String
    let surname, firstname, motivation: String
    let location: Location
    let city, borncountry, year, diedcountry: String
    let country: String
    let gender: Gender
    let name: String
}

// MARK: - Category
enum Category: String, Codable {
    case chemistry = "Chemistry"
    case economics = "Economics"
    case medicine = "Medicine"
    case physics = "Physics"
}

// MARK: - Gender
enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}

// MARK: - NobelLaureates
typealias NobelLaureates = [NobelLaureateModel]
