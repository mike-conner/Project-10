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
    var userSelectedCamera: Cameras?
    
    @IBOutlet weak var roverSelectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var cameraSelectionSegmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCameraOptions()
        roverSelectionSegmentControl.selectedSegmentIndex = 0
        cameraSelectionSegmentControl.selectedSegmentIndex = 0
        userSelectedRover = .Curiosity
        userSelectedCamera = .FHAZ
    }
    
    @IBAction func roverSelectionSegmentControl(_ sender: Any) {
        setUpCameraOptions()
        getSelectedRover()
        cameraSelectionSegmentControl.selectedSegmentIndex = 0
        userSelectedCamera = .FHAZ
    }
    
    @IBAction func cameraSelectionSegmentControl(_ sender: Any) {
        getSelectedCamera()
    }
    
    @IBAction func searchButton(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController = segue.destination as! UINavigationController
        let targetViewController = destinationViewController.topViewController as! PhotoGalleryViewController
        
        targetViewController.userSelectedRover = userSelectedRover
        targetViewController.userSelectedCamera = userSelectedCamera
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
        default: return
        }
    }
    
    func getSelectedRover() {
        switch roverSelectionSegmentControl.selectedSegmentIndex {
        case 0: userSelectedRover = .Curiosity
        case 1: userSelectedRover = .Opportunity
        case 2: userSelectedRover = .Spirit
        default: return
        }
    }
    
    func getSelectedCamera() {
        switch cameraSelectionSegmentControl.selectedSegmentIndex {
        case 0: userSelectedCamera = .FHAZ
        case 1: userSelectedCamera = .RHAZ
        case 2: if roverSelectionSegmentControl.selectedSegmentIndex == 0 { userSelectedCamera = .MAST } else { userSelectedCamera = . NAVCAM }
        case 3: if roverSelectionSegmentControl.selectedSegmentIndex == 0 { userSelectedCamera = .CHEMCAM } else { userSelectedCamera = .PANCAM }
        case 4: if roverSelectionSegmentControl.selectedSegmentIndex == 0 { userSelectedCamera = .MAHLI } else { userSelectedCamera = .MINITIES }
        case 5: userSelectedCamera = .MARDI
        case 6: userSelectedCamera = .NAVCAM
        default: return
        }
    }
}
