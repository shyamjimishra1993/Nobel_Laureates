//
//  SearchLaureatesViewController.swift
//  Nobel_Laureates
//
//  Created by Shyam on 12/12/20.
//  Copyright © 2020 shyamOrg. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class SearchLaureatesViewController: UIViewController {
    @IBOutlet weak var selectYearButton: UIButton!
    @IBOutlet weak var selectLatLongButton: UIButton!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var searchContainerView: UIView!
    
    let datePicker = UIDatePicker()
    var allowedSearchYears:[Int] = Array(1900...2020)
    var selectedYear: Int = 2020 // Default Selected year
    var selectedLocation:CLLocationCoordinate2D?
    private var laureatesViewModel : LaureatesViewModel!
    
    // MARK: - UI LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.showPickerView(hidden:true)
        self.selectYearButton.setTitle(String(self.selectedYear), for: UIControl.State.normal)
        self.pickerView.selectRow(allowedSearchYears.count - 1, inComponent: 0, animated: false)
        laureatesViewModel = LaureatesViewModel()
    }
    
    // MARK: - Button Actions
    @IBAction func selectYearButtonTapped(_ sender: Any) {
        self.showPickerView(hidden:false)
    }
    
    @IBAction func selectLatLongButtonTapped(_ sender: Any) {
        let viewController = LocationPickerController(success: {
            [weak self] (coordinate: CLLocationCoordinate2D) -> Void in
            self?.selectLatLongButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
            self?.selectLatLongButton.titleLabel?.textAlignment = NSTextAlignment.center;
            self?.selectLatLongButton.setTitle("\(coordinate.latitude),\n\(coordinate.longitude)", for: UIControl.State.normal)
            self?.selectedLocation = coordinate
        })
        let navigationController = UINavigationController(rootViewController: viewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if let location = selectedLocation {
            let top20Laureates = laureatesViewModel.searchTop20Laureates(year: selectedYear, location: location)
            let laureatesListviewController: LaureatesTableViewController? = (self.storyboard?.instantiateViewController(withIdentifier: "listViewController") as! LaureatesTableViewController)
            laureatesListviewController?.laureatesList = top20Laureates
            self.navigationController?.pushViewController(laureatesListviewController!, animated: true)
        }
        else{
            let alertController = UIAlertController(title: "Alert!", message:"Please select an Year and a location to proceed further." ,preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Ok",
                                                    style: UIAlertAction.Style.default,
                                                    handler: {(_: UIAlertAction!) in
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showPickerView(hidden: Bool) {
        self.pickerContainerView.isHidden = hidden
        self.searchContainerView.alpha = hidden ? 1 : 0.3
        self.searchContainerView.isUserInteractionEnabled = hidden
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        self.selectYearButton.setTitle(String(self.selectedYear), for: UIControl.State.normal)
        self.showPickerView(hidden: true)
    }
}

extension SearchLaureatesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - UIPickerViewDelegate UIPickerViewDataSource protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.allowedSearchYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.allowedSearchYears[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedYear = self.allowedSearchYears[row]
    }
}
