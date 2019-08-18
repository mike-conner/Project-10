//
//  NetworkingManager.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit
import Nuke

class NetworkingManager {
    
    let earthDate: String = "2019-08-01"         // for testing only!
    
    static let sharedNetworkingManager = NetworkingManager(configuration: .default)
    
    let URLBase: String = "https://images-api.nasa.gov/mars-photos/api/v1/rovers/"
    private let apiKey: String = "XOl7yfT1mAZlsf3ZsQhMfbUXyG0XSbjzf14dX80z"
    
    let rover: Rovers? = .Curiosity
    let camera: Cameras? = nil
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: .default)
    }

    func getPhotos(page: Int, completionHandler completion: @escaping (Photo?, Error?) -> Void) {
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: "\(URLBase)/\(String(describing: rover))/photos?earth_date=\(earthDate)&api_key=\(apiKey)") else { return }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    
                }
            }
        }
    }
    
}

