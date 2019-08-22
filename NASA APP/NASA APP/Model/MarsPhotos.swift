//
//  MarsPhotos.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Photos: Codable {
    var photos: [Photo]
}

struct Photo: Codable {
    var img_src: String
}
