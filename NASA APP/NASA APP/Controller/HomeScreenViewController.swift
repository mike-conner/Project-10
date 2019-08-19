//
//  HomeScreenViewController.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import Nuke
import Alamofire


class HomeScreenViewController: UIViewController {
    
    @IBAction func marsRoverButton(_ sender: Any) {
        AF.request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=DEMO_KEY").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            let json = response.result
            print("JSON: \(json)") // serialized json response
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
    }
}
    
    @IBAction func eyeInTheSkyButton(_ sender: Any) {
        // add functionality once Mars Rover potion is complete
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

