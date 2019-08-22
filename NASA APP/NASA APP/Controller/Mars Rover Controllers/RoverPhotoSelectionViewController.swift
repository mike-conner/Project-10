//
//  RoverPhotoSelectionViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class RoverPhotoSelectionViewController: UIViewController {
    
    var userSelectedRover: Rovers?
    var userSelectedDate: String?
    
    @IBOutlet weak var roverSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roverSelectionSegmentControl.selectedSegmentIndex = 0
        userSelectedRover = .Curiosity
        getDateFromDatePicker()
    }
    
    @IBAction func roverSelectionSegmentControl(_ sender: Any) {
        getSelectedRover()
    }
    
    @IBAction func datePicker(_ sender: Any) {
        getDateFromDatePicker()
    }
    
    @IBAction func searchButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination as! UINavigationController
        let targetViewController = destinationViewController.topViewController as! PhotoGalleryViewController
        targetViewController.userSelectedDate = userSelectedDate
        targetViewController.userSelectedRover = userSelectedRover
    }
    
    func getSelectedRover() {
        switch roverSelectionSegmentControl.selectedSegmentIndex {
        case 0: userSelectedRover = .Curiosity
        case 1: userSelectedRover = .Opportunity
        case 2: userSelectedRover = .Spirit
        default: return
        }
    }
    
    func getDateFromDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        userSelectedDate = selectedDate
    }
}
