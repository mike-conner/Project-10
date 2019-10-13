//
//  NetworkManager.swift
//  NASA APP
//
//  Created by Mike Conner on 8/21/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation
import Alamofire

// Shhhhh... this is my API Key. Don't share please. :D
private let API_KEY = "XOl7yfT1mAZlsf3ZsQhMfbUXyG0XSbjzf14dX80z"

// Below is my Networking code which utilizes Alamofire.
// This class contains a single function to get the data from the API.
// Create the URL based on selections passed in the above function. If URL fails to be created, return.
// Using Alamofire, send request and evaluate the response. If the request is a success, try to decode the JSON. If the request is a fail, print the error. If json decoded successfully, assign to myResponse and call escaping closure, else catch the error and notify user.

class WebAPI {
    func getMarsPhotos(rover: Rovers, date: String, completed: @escaping (_ photos: Photos) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?earth_date=\(date)&api_key=\(API_KEY)") else { return }
        AF.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let myResponse = try JSONDecoder().decode(Photos.self, from: data)
                    completed(myResponse)
                }
                catch { print("JSON did not decode successfully") }
            case .failure(let error): print(error)
            }
        }
    }
    
    func getEyeInTheSkyPhoto(lat: Double, lon: Double, completed: @escaping (_ image: Image) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/planetary/earth/imagery/?lon=\(lon)&lat=\(lat)&api_key=\(API_KEY)") else { return }
//        guard let url = URL(string: "https://api.nasa.gov/planetary/earth/imagery/?lon=100.75&lat=1.5&api_key=DEMO_KEY") else { return }
        AF.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let myResponse = try JSONDecoder().decode(Image.self, from: data)
                    completed(myResponse)
                }
                catch {
                    print("JSON did not decode successfully")
                    let myResponse = Image(url: "")
                    completed(myResponse)
                }
            case .failure(let error): print(error)
            }
        }
    }
}
