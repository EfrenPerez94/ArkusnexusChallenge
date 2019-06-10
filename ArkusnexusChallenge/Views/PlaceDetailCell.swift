//
//  PlaceDetailCell.swift
//  ArkusnexusChallenge
//
//  Created by Efrén Pérez Bernabe on 6/10/19.
//  Copyright © 2019 Efrén Pérez Bernabe. All rights reserved.
//

import Foundation
import UIKit

/// Place Detail Table View Cell. Show data for each place.
final class PlaceDetailTableViewCell: UITableViewCell {
    
    // MARK: - Public properties
    
    var subtitle: String? {
        didSet {
            self.subtitleLabel.text = subtitle ?? ""
        }
    }
    
    var title: String? {
        didSet {
            self.titleLabel.text = title ?? ""
        }
    }
    
    var icon: UIImage? {
        didSet {
            self.iconImageView.image = icon ?? #imageLiteral(resourceName: "figoLogo")
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
        let subviews = [iconImageView, titleLabel, subtitleLabel]
        addSubviews(subviews)
    }
    
    private var isViewConstrained = false
    
    lazy private var iconImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.gunmetal
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.gunmetal
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
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
                // icon ImageView
                iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(10)),
                iconImageView.heightAnchor.constraint(equalToConstant: frame.height - CGFloat(20)),
                iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
                // title label
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: CGFloat(30)),
                titleLabel.widthAnchor.constraint(equalToConstant: frame.width * 0.6),
                // subtitle label
                subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
                subtitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: CGFloat(30)),
                subtitleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)
            ]
            NSLayoutConstraint.activate(contraints)
            isViewConstrained = true
        }
    }
    
}
