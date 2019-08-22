//
//  NetworkManager.swift
//  NASA APP
//
//  Created by Mike Conner on 8/21/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation
import Alamofire

class WebAPI {
 
    func getMarsPhotos(completed: @escaping (_ photos: Photos) -> Void) {
        guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=DEMO_KEY") else { return }
        
        AF.request(url, method: .get).responseJSON { (response) in           
            switch response.result {
            case .success:
                print("success")
                guard let data = response.data else {
                    print("successfully retrieved data")
                    return
                }
                do {
                    let myResponse = try JSONDecoder().decode(Photos.self, from: data)
                    print("JSON decoded successfully")
                    completed(myResponse)
                }
                catch {
                    print("JSON did not decode successfully")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
