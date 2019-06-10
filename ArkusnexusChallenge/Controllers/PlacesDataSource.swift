//
//  PlacesDataSource.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/9/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// String extension to store cell identifiers.
extension String {
    static let placeCell = "PlaceCellIdentifier"
}

// MARK: - Table view data source
final class PlacesDataSource: NSObject, UITableViewDataSource {
    
    var places = [Place]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let placeCell = tableView.dequeueReusableCell(withIdentifier: .placeCell, for: indexPath) as? PlaceTableViewCell else {
            fatalError("Unable cast cell as PlaceTableViewCell")
        }
        
        placeCell.place = self.places[indexPath.row]
        return placeCell
    }
}
