//
//  MarsPhotos.swift
//  NASA APP
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let imageSource: URL
    let rover: [String: Rover]
}

struct Rover: Codable {
    let landingDate: String
}
