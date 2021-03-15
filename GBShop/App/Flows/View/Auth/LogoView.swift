//
//  LogoView.swift
//  task7
//
//  Created by Александр Ипатов on 07.03.2021.
//

import UIKit

class LogoView: UIView {
    private(set) lazy var logoImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "GBlogo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    private(set) lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "GBShop"
        label.font = .logoFont()
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstraints() {
        self.addSubview(logoImageView)
        self.addSubview(logoLabel)
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),

            logoLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            logoLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 5),
            logoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            logoLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
