//
//  ImageViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 9/28/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import Nuke

class ImageViewController: UIViewController {
    
    static let api = WebAPI() // create the WebAPI object for networking call.
    
    @IBOutlet weak var imageView: UIImageView!
    var lat: Double?
    var lon : Double?
    var photoURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Eye In The Sky Photo" // create title for VC
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Find New Image", style: .done, target: self, action: #selector(newImage)) // create "New Search" option on the title bar for going back to the previous VC so the user can make a new search.
        if let lat = lat, let lon = lon {
            getImage(lat: lat, lon: lon)
        }
    }
    
    @objc
    func newImage() {
        dismiss(animated: true, completion: nil) // when "New Search" is pressed, simply dismiss the current VC
    }
    
    func getImage(lat: Double, lon: Double) {
        ImageViewController.api.getEyeInTheSkyPhoto(lat: lat, lon: lon) { (image) in
                self.photoURL = image.url
            if let url = URL(string: self.photoURL ?? "") {
                Nuke.loadImage(with: url, into: self.imageView)
            }
        }
    }
}
