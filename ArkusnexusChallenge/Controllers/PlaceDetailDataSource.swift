//
//  PlaceDetailDataSource.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/10/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// String extension to store cell identifiers.
extension String {
    static let placeDetailCell = "PlaceDetailCellIdentifier"
}

// MARK: - Table view data source
class PlaceDetailDataSource: NSObject, UITableViewDataSource {
    
    var place: Place?
    private let images = [#imageLiteral(resourceName: "icons8RouteFilled"), #imageLiteral(resourceName: "cellIconsPhone"), #imageLiteral(resourceName: "cellIconsWebsite")]
    private let titles = ["Directions", "Call", "Visit Website"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row > 0 {
            guard let placeDetailCell = tableView.dequeueReusableCell(withIdentifier: .placeDetailCell, for: indexPath) as? PlaceDetailTableViewCell else {
                fatalError("Unable cast cell as PlaceDetailTableViewCell")
            }
            placeDetailCell.icon = images[indexPath.row - 1]
            placeDetailCell.title = titles[indexPath.row - 1]
            switch indexPath.row {
            case 1: placeDetailCell.subtitle = "\(place?.distance ?? 0) Km"
            case 2: placeDetailCell.subtitle = place?.phoneNumber
            case 3: placeDetailCell.subtitle = place?.site
            default: placeDetailCell.subtitle = ""
            }

            return placeDetailCell
        } else {
            guard let placeCell = tableView.dequeueReusableCell(withIdentifier: .placeCell, for: indexPath) as? PlaceTableViewCell else {
                fatalError("Unable cast cell as PlaceTableViewCell")
            }
            placeCell.place = self.place
            return placeCell
        }
        
    }
}
