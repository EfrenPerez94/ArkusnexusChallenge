//
//  File.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/9/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// Place Table View Cell. Show data for each place.
final class PlaceTableViewCell: UITableViewCell {
    
    // MARK: - Public properties

    var place: Place? {
        didSet {
            self.nameLabel.text = place?.name
            self.ratingLabel.text = "Rating: \(place?.rating ?? 0)"
            self.addressLabel.text = (place?.addressLine1 ?? "") + " " + (place?.addressLine2 ?? "")
            self.profileImageView.imageFromURL(place?.thumbnail ?? "")
            self.distanceLabel.text = "\(place?.distance ?? 0) Km"
            if place?.isPetFriendly ?? false {
                     self.petFriendlyImageView.image = #imageLiteral(resourceName: "dogFriendlyActive")
            } else {
                self.petFriendlyImageView.image = nil
            }
        }
    }

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        let subviews = [profileImageView, petFriendlyImageView, nameLabel, ratingLabel, addressLabel, distanceLabel ]
        addSubviews(subviews)
    }
    
    private var isViewConstrained = false
    
    lazy private var profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy private var petFriendlyImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.gunmetal
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.gunmetal
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var distanceLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Constants.gray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Constraints setup.
    override public class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    private func setupConstraints() {
        if !isViewConstrained {
            let contraints = [
                // profile ImageView
                profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(10)),
                profileImageView.heightAnchor.constraint(equalToConstant: frame.height - CGFloat(20)),
                profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
                // name label
                nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: CGFloat(10)),
                nameLabel.widthAnchor.constraint(equalToConstant: frame.width / CGFloat(2)),
                // ranking label
                ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                ratingLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: CGFloat(10)),
                ratingLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
                // adress Label
                addressLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
                addressLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: CGFloat(10)),
                addressLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
                // distance Label
                distanceLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
                distanceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: CGFloat(10)),
                distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-10)),
                // pet friendly Image View
                petFriendlyImageView.bottomAnchor.constraint(equalTo: addressLabel.bottomAnchor),
                petFriendlyImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(-10)),
                petFriendlyImageView.heightAnchor.constraint(equalToConstant: frame.height / CGFloat(3)),
                petFriendlyImageView.widthAnchor.constraint(equalTo: petFriendlyImageView.heightAnchor)
                
            ]
            NSLayoutConstraint.activate(contraints)
            isViewConstrained = true
        }
    }
    
}
