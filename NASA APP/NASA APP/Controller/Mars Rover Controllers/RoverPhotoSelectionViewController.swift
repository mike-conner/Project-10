//
//  RoverPhotoSelectionViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class RoverPhotoSelectionViewController: UIViewController {
    
    @IBOutlet weak var roverSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var cameraSelectionSegmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCameraOptions()
    }
    
    @IBAction func roverSelectionSegmentControl(_ sender: Any) {
        setUpCameraOptions()
    }
    
    
    @IBAction func searchButton(_ sender: Any) {
        if cameraSelectionSegmentControl.selectedSegmentIndex != -1 {
            print("ok")
        }
    }
    
    func setUpCameraOptions() {
        switch roverSelectionSegmentControl.selectedSegmentIndex {
        case 0:
            cameraSelectionSegmentControl.removeAllSegments()
            cameraSelectionSegmentControl.insertSegment(withTitle: "FHAZ", at: 0, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "RHAZ", at: 1, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "MAST", at: 2, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "CHEMCAM", at: 3, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "MAHLI", at: 4, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "MARDI", at: 5, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "NAVCAM", at: 6, animated: false)
        case 1, 2:
            cameraSelectionSegmentControl.removeAllSegments()
            cameraSelectionSegmentControl.insertSegment(withTitle: "FHAZ", at: 0, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "RHAZ", at: 1, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "NAVCAM", at: 2, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "PANCAM", at: 3, animated: false)
            cameraSelectionSegmentControl.insertSegment(withTitle: "MINITES", at: 4, animated: false)
        default: print("not possible")
        }
    }
    
}
