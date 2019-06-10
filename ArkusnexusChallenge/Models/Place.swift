//
//  Mocky.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/9/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation

/// Model for place retrieve from Mocky.
struct Place: Codable {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let thumbnail: String
    let rating: Double
    let isPetFriendly: Bool
    let addressLine1: String
    let addressLine2: String
    let phoneNumber: String
    let site: String
    var distance: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "PlaceId"
        case name = "PlaceName"
        case address = "Address"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case thumbnail = "Thumbnail"
        case rating = "Rating"
        case isPetFriendly = "IsPetFriendly"
        case addressLine1 = "AddressLine1"
        case addressLine2 = "AddressLine2"
        case phoneNumber = "PhoneNumber"
        case site = "Site"
        case distance = "Distance"
    }
}
