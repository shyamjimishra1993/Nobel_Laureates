//
//  ViewController.swift
//  Nobel_Laureates
//
//  Created by Shyam on 12/12/20.
//  Copyright © 2020 shyamOrg. All rights reserved.
//

import UIKit
import Foundation

class SearchLaureatesViewController: UIViewController {
    var laureatesWithRating = [LaureatesWithRating]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.readJSONFromFile(fileName: "nobel_prize_laureates")
    }


    func readJSONFromFile(fileName: String)
    {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let laureates = try? decoder.decode(NobelLaureates.self, from: data)
                for laureate in laureates!
                {
                    laureatesWithRating.append(LaureatesWithRating(laureate: laureate, distancee: 210, yearDiff: 10))
                }
                print(laureatesWithRating)
            } catch {
                // Handle error here
            }
        }
    }

}

struct LaureatesWithRating {
    let laureate:NobelLaureateModel
    let distancee:Double
    let yearDiff:Int
}
