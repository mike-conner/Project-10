//
//  MapViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 9/28/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var coordinate: CLLocationCoordinate2D? = nil
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImage(gestureRecognizer:)))
        gestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        mapView.addGestureRecognizer(gestureRecognizer)        
    }
    
    @objc func showImage(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        performSegue(withIdentifier: "eyeInTheSkySegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! UINavigationController
        let targetViewController = destinationViewController.topViewController as! ImageViewController
        if let lat = coordinate?.latitude, let lon = coordinate?.longitude {
            targetViewController.lat = lat
            targetViewController.lon = lon
        }
        
    }

}


