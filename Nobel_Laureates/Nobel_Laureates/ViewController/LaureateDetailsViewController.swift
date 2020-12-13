//
//  LaureateDetailsViewController.swift
//  Nobel_Laureates
//
//  Created by Shyam on 12/12/20.
//  Copyright © 2020 shyamOrg. All rights reserved.
//

import UIKit

class LaureateDetailsViewController: UIViewController {
    var laureateItem:LaureatesWithRatingDetails?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var bornCity: UILabel!
    @IBOutlet weak var bornDate: UILabel!
    @IBOutlet weak var diedCity: UILabel!
    @IBOutlet weak var diedDate: UILabel!
    @IBOutlet weak var awardYear: UILabel!
    @IBOutlet weak var university: UILabel!
    @IBOutlet weak var motivation: UILabel!
    
    // MARK: - UI LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = (laureateItem?.laureate.firstname ?? "") + (laureateItem?.laureate.surname ?? "")
        category.text = laureateItem?.laureate.category.rawValue
        bornCity.text = laureateItem?.laureate.borncity
        bornDate.text = laureateItem?.laureate.born
        diedCity.text = laureateItem?.laureate.diedcity
        diedDate.text = laureateItem?.laureate.died
        awardYear.text = laureateItem?.laureate.year
        university.text = laureateItem?.laureate.name
        motivation.text = laureateItem?.laureate.motivation
    }
    
}
