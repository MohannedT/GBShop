//
//  LoadingView.swift
//  GBShop
//
//  Created by Александр Ипатов on 18.03.2021.
//

import UIKit
import Lottie

class LoadingView: UIView {

    private let animationLoaderView = AnimationView(name: "loadingCat")

    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        configBackground()
        animationSetup()
        setupConstraints()
        backgroundColor = .clear

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configBackground() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    private func animationSetup() {
        animationLoaderView.animationSpeed = 1
        animationLoaderView.loopMode = .loop
        animationLoaderView.play()
    }
    //
    func showLoadingView() {
        isHidden = false
        animationLoaderView.play()
    }
    //
    func hideLoadingView() {
        isHidden = true
        animationLoaderView.stop()
    }

   private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animationLoaderView)
        animationLoaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationLoaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationLoaderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationLoaderView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            animationLoaderView.heightAnchor.constraint(equalTo: animationLoaderView.widthAnchor )
        ])
    }
}
