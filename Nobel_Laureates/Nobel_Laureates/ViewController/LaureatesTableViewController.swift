//
//  LaureatesTableViewController.swift
//  Nobel_Laureates
//
//  Created by Shyam on 12/12/20.
//  Copyright © 2020 shyamOrg. All rights reserved.
//

import UIKit

class LaureatesTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var laureatesList:[LaureatesWithRatingDetails] = []
    
    // MARK: - UI LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top 20 Laureates"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Button Action
    @objc func infoButtonTapped(sender: UIButton)
    {
        self.showAlert(messageString: "This represents the number by which a laureate differs from the search criteria. The number represents the value calucalted as the average of following two- \n1. The year difference between award year and year entered by user in serach criterai.\n2. The distance between the location of Laureate and the location entered in the search criteria. \n The less this number, the more rating laureate will have.")
    }
    
    func showAlert(messageString: String) {
        let alertController = UIAlertController(title: "Info!", message:messageString ,preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: UIAlertAction.Style.default,
                                                handler: {(_: UIAlertAction!) in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UI TableView Delegates
extension LaureatesTableViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laureatesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LaureateTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "laureateCell") as! LaureateTableViewCell
        let laureateItem = laureatesList[indexPath.row]
        cell.name.text = "\(laureateItem.laureate.firstname) \(laureateItem.laureate.surname)"
        cell.awardyear.text = "\(laureateItem.laureate.year)"
        cell.location.text = "\(laureateItem.laureate.location.lat), \(laureateItem.laureate.location.lng)"
        cell.distannce.text = "\(String(format: "%.3f", laureateItem.distance)) KM"
        cell.differenceValue.text = "\(String(format: "%.3f", laureateItem.averageOfDistanceAndYearDiff))"
        cell.infoButton.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let laureateDetailsviewController: LaureateDetailsViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! LaureateDetailsViewController)
        laureateDetailsviewController!.laureateItem = laureatesList[indexPath.row]
        self.navigationController?.pushViewController(laureateDetailsviewController!, animated: true)
    }
}
