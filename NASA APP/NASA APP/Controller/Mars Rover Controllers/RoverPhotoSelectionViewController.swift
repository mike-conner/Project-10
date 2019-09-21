//
//  RoverPhotoSelectionViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class RoverPhotoSelectionViewController: UIViewController {
    
    // hard coded dates for when the rovers landed on Mars.
    private let curiosityLandingDate = "2012-08-06"
    private let opportunityLandingDate = "2004-01-25"
    private let spiritLandingDate = "2004-01-04"
    
    var userSelectedRover: Rovers?
    var userSelectedDate: String?
    
    @IBOutlet weak var roverSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roverSelectionSegmentControl.selectedSegmentIndex = 0
        userSelectedRover = .Curiosity // set the default selection when the view loads
        getDateFromDatePicker() // set the default date when the view loads
    }
    
    @IBAction func roverSelectionSegmentControl(_ sender: Any) {
        getSelectedRover() // function called when rover selection changes. Used to change the user selection variable.
    }
    
    @IBAction func datePicker(_ sender: Any) {
        getDateFromDatePicker() // function called when date selection changes. Used to change user selection variable.
    }
    
    @IBAction func searchButton(_ sender: Any) {}
    
    // when the search button is pressed, this function is called and used to pass the user selected rover and date to the PhotoGalleryViewController
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
    
    // function converts date picker date to string in format needed for API call
    func getDateFromDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        userSelectedDate = selectedDate
    }
}
