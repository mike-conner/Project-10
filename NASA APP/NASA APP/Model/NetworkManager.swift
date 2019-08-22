//
//  NetworkManager.swift
//  NASA APP
//
//  Created by Mike Conner on 8/21/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation
import Alamofire

private let API_KEY = "XOl7yfT1mAZlsf3ZsQhMfbUXyG0XSbjzf14dX80z"

class WebAPI {
 
    func getMarsPhotos(rover: Rovers, date: String, completed: @escaping (_ photos: Photos) -> Void) {
        
        
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/\(rover)/photos?earth_date=\(date)&api_key=\(API_KEY)") else { return }
        
        AF.request(url, method: .get).responseJSON { (response) in           
            switch response.result {
            case .success:
 //               print("success")
                guard let data = response.data else {
//                    print("successfully retrieved data")
                    return
                }
                do {
                    let myResponse = try JSONDecoder().decode(Photos.self, from: data)
//                    print("JSON decoded successfully")
                    completed(myResponse)
                }
                catch {
//                    print("JSON did not decode successfully")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
