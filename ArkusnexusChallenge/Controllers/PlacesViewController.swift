//
//  MainViewController.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/9/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

final class PlacesViewController: UIViewController, UITableViewDelegate, CLLocationManagerDelegate {
    
    // MARK: - Private properties
    private var placesData: [Place] = []
    private var tableView: UITableView!
    private var placesDataSource = PlacesDataSource()
    private var loadDataIndicator: UIActivityIndicatorView!
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "figoLogo"))
        locationSetup()
        currentLocation = locationManager.location
        indicatorSetup()
        tableViewSetup()
    }
    
    // MARK: - View Controller configuration
    /// Indicator configuration.
    fileprivate func indicatorSetup() {
        loadDataIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        loadDataIndicator.center = view.center
        loadDataIndicator.startAnimating()
        view.addSubview(loadDataIndicator)
    }
    
    /// Table View configuration.
    fileprivate func tableViewSetup() {
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.rowHeight = view.frame.height / 7
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: .placeCell)
        tableView.dataSource = placesDataSource
        view.addSubview(tableView)
        getPlaces()
    }
    
    /// Location configuration
    fileprivate func locationSetup() {
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PlaceTableViewCell,
            let place = cell.place else {
                fatalError("Unable cast cell as PlaceTableViewCell")
        }
        navigationController?.pushViewController(PlaceDetailViewController(with: place, location: currentLocation ?? CLLocation(latitude: 0, longitude: 0)), animated: true)
    }
    
    // MARK: - Auxiliar functions
    func getPlaces() {
        let mockyRepository = MockyRepository()
        mockyRepository.execute { [weak self] result in
            
            guard let weakSelf = self else {
                return
            }
            
            switch result {
                
            case .failure(let error):
                let alert = UIAlertController(title: "Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
                
            case .success(var data):
                DispatchQueue.main.async {

                    for (index, place) in data.enumerated() {
                        if let coordinate1 = weakSelf.locationManager.location {
                            let coordinate2 = CLLocation(latitude: place.latitude, longitude: place.longitude)
                            data[index].distance = Int(coordinate1.distance(from: coordinate2) / 1000)
                        } else {
                            data[index].distance = 0
                        }
                    }

                    data.sort(by: { $0.distance ?? 0 < $1.distance ?? 0 })
                        
                    weakSelf.placesDataSource.places = data
                    weakSelf.tableView.reloadData()
                    weakSelf.loadDataIndicator.removeFromSuperview()
                    
                }
            }
        }
    }
}
