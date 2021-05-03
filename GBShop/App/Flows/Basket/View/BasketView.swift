//
//  BasketView.swift
//  GBShop
//
//  Created by Александр Ипатов on 22.03.2021.
//

import UIKit
import Lottie

class BasketView: UIView {
    let animationView = AnimationView(name: "loadingCatalog2")
    // MARK: - Subviews
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        return tableView
    }()
    let payBasketVeiw = PayBasketVeiw()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        animationSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Setup UI
extension BasketView {
    private func animationSetup() {
        animationView.animationSpeed = 1
        animationView.loopMode = .loop
    }
    private func setupConstraints() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        addSubview(payBasketVeiw)
        addSubview(animationView)
        NSLayoutConstraint.activate([
            payBasketVeiw.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            payBasketVeiw.leftAnchor.constraint(equalTo: leftAnchor),
            payBasketVeiw.rightAnchor.constraint(equalTo: rightAnchor),
            payBasketVeiw.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07),

            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor)
        ])
    }
}
