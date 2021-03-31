//
//  BasketViewController.swift
//  GBShop
//
//  Created by Александр Ипатов on 22.03.2021.
//

import UIKit

class BasketViewController: UIViewController {
    var analytics: FirebaseAnalytics
    private let user: User
    private let requestFactory: RequestFactory
    private var basket: GetBasketResult? {
        didSet {
            DispatchQueue.main.async {
                self.basketView.animationView.stop()
                self.basketView.animationView.isHidden = true
                self.basketView.tableView.reloadData()
            }
        }
    }

    private var basketView: BasketView {
        view as! BasketView
    }

    // MARK: - Init
    init(user: User, requestFactory: RequestFactory, analytics: FirebaseAnalytics) {
        self.analytics = analytics
        self.requestFactory = requestFactory
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = BasketView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.basketView.animationView.play()
        navigationSetUp()
        setupTableView()
        getBasket()
        addButtonTarget()
    }
    // MARK: - Methods
    private func addButtonTarget() {
        basketView.payBasketVeiw.payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }
    private func navigationSetUp() {
        self.navigationItem.title = "Basket"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupTableView() {
        basketView.tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.reuseId)
        basketView.tableView.dataSource = self
        basketView.tableView.delegate = self
    }
    private func tryToPayBasket() {
        let creditCard = self.secureCreditCard(creditCardNumber: user.creditCard)
        let alertText = "Do you want to buy goods for \(basket!.amount) rubles from card number \(creditCard)"
        self.showAlert(needСancellation: true, with: "", and: alertText) {
            self.payBasket()
        }
    }
    private func payBasket() {
        let payBasketFactory = requestFactory.makePayBasketRequestFactory()
        payBasketFactory.payBasket(idUser: user.idUser, paymentAmount: basket?.amount ?? 0) {(response) in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.analytics.payBasket(paymentAmount: self.basket?.amount ?? 0)
                    self.showAlert(with: "Congratulations!", and: "Payment successful, wait for a call from our operator")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Oops!", and: error.localizedDescription)
                }
            }
        }
    }
    private func getBasket() {
        let basketFactory = requestFactory.makeGetBasketRequestFactory()
        basketFactory.getBasket(idUser: user.idUser) { (response) in
            switch response.result {
            case .success(let basket):
                self.basket = basket
                DispatchQueue.main.async {
                    self.basketView.payBasketVeiw.priceLabel.text = "\(basket.amount) руб"
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Oops!", and: error.localizedDescription)
                }
            }
        }
    }
    private func deleteFromBasket(productIndex: IndexPath) {
        guard let productsInBasket = basket?.contents else { return }
        let idProduct = productsInBasket[productIndex.row].idProduct
        let deleteFromFactory = requestFactory.makeDeleteFromBasketRequestFactory()
        deleteFromFactory.deleteFromBasket(idProduct: idProduct) { (response) in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                self.basketView.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Oops!", and: error.localizedDescription)
                }
            }
        }
    }
    private func presentDetailViewController(idProduct: Int) {
        navigationController?.pushViewController(DetailProductViewContriller(user: user,
                                                                             requestFactory: requestFactory,
                                                                             idProduct: idProduct,
                                                                             analytics: analytics),
                                                 animated: true)
    }

}
// MARK: - UITableViewDataSource
extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basket?.contents.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productsInBasket = basket?.contents else { return UITableViewCell()}
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.reuseId,
                                                       for: indexPath) as? BasketTableViewCell else {
            return UITableViewCell()}

        let product = productsInBasket[indexPath.row]
        cell.configure(with: product)
        return cell
}
}
// MARK: - UITableViewDelegate
extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let productsInBasket = basket?.contents else { return }
        let selectedProductId = productsInBasket[indexPath.row].idProduct
        presentDetailViewController(idProduct: selectedProductId)
    }

}
// MARK: - RemoveFromBasket
extension BasketViewController {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromBasket(productIndex: indexPath)
            basket?.contents.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            analytics.removeFromBasket(idProduct: basket?.contents[indexPath.row].idProduct ?? 0)
        }
    }
}
// MARK: - Actions
extension BasketViewController {
    @objc private func payButtonTapped() {
        tryToPayBasket()
    }
}
