//
//  MarsPhotos.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

// Photos are a codable collection of photo objects.
struct Photos: Codable {
    var photos: [Photo]
}

// Photo is a codable object consisting of a string that is the url to where the photo is stored.
struct Photo: Codable {
    var img_src: String
}

struct Image: Codable {
    var url: String
}
