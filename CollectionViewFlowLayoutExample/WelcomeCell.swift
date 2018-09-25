//
//  WelcomeCell.swift
//  CollectionViewFlowLayoutExample
//
//  Created by Fernando Cardenas on 25.09.18.
//  Copyright © 2018 Fernando Cardenas. All rights reserved.
//

import UIKit

class WelcomeCell: UICollectionViewCell {

    var noImageConstraints: [NSLayoutConstraint]!
    var imageConstraints: [NSLayoutConstraint]!

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Something great"
        label.backgroundColor = .lightGray
        return label
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {

        addSubview(titleLabel)
        addSubview(imageView)

        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        noImageConstraints = [
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
        noImageConstraints.forEach { $0.isActive = true }

        imageConstraints = [
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ]
    }

    func updateSetupForNoImage() {
        guard let constraint = noImageConstraints.first else { return }
        if !constraint.isActive {
            imageConstraints.forEach { $0.isActive = false }
            noImageConstraints.forEach { $0.isActive = true }
        }
    }

    func updateSetupForImage(with image: UIImage?) {
        guard let constraint = imageConstraints.first else { return }
        if !constraint.isActive {
            imageConstraints.forEach { $0.isActive = true }
            noImageConstraints.forEach { $0.isActive = false }
        }
        imageView.image = image
    }
}
