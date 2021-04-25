//
//  CatalogView.swift
//  GBShop
//
//  Created by Александр Ипатов on 15.03.2021.
//

import UIKit
import Lottie

class CatalogView: UIView {

    // MARK: - Subviews
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let animationView = AnimationView(name: "loadingCatalog2")

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.animationSetup()
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
// MARK: - Setup UI
extension CatalogView {

    private func animationSetup() {
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
    }

    private func setupUI() {
        collectionView.backgroundColor = .white
        addSubview(collectionView)
        addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),

            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor)

        ])
    }
}
