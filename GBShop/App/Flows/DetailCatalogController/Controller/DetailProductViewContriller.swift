//
//  DetailProductViewContriller.swift
//  GBShop
//
//  Created by Александр Ипатов on 21.03.2021.
//

import UIKit

class DetailProductViewContriller: UIViewController {
    var analytics: FirebaseAnalytics
    private let idProduct: Int
    private let user: User
    private let requestFactory: RequestFactory

    private var product: ProductWithDescription? {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
                self.detailCatalogVeiw.animationView.stop()
                self.detailCatalogVeiw.animationView.isHidden = true
                self.getReviewList()
                self.detailCatalogVeiw.addButton.isHidden = false
            }
        }
    }
    private var reviews = [Review]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    private var detailCatalogVeiw: DetailCatalogVeiw {
        view as! DetailCatalogVeiw
    }

    // MARK: - Init
    init(user: User, requestFactory: RequestFactory, idProduct: Int, analytics: FirebaseAnalytics ) {
        self.analytics = analytics
        self.idProduct = idProduct
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
        self.view = DetailCatalogVeiw()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailCatalogVeiw.animationView.play()
        setupCollectionView()
        createDataSource()
        getProduct()
        reloadData()
        addButtonTarget()
        self.analytics.viewProduct(idProduct: idProduct)
    }
    // MARK: - Methods
    private func addButtonTarget() {
        detailCatalogVeiw.addButton.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?

    private func setupCollectionView() {
        detailCatalogVeiw.collectionView.register(AddNewReviewCell.self,
                                                  forCellWithReuseIdentifier: AddNewReviewCell.reuseId)
        detailCatalogVeiw.collectionView.register(PhotosDetailCatalogCell.self,
                                                  forCellWithReuseIdentifier: PhotosDetailCatalogCell.reuseId)

        detailCatalogVeiw.collectionView.register(DescriptionDetailCatalogCell.self,
                                                  forCellWithReuseIdentifier: DescriptionDetailCatalogCell.reuseId)

        detailCatalogVeiw.collectionView.register(SectionHeader.self,
                                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: SectionHeader.reuseId)

        detailCatalogVeiw.collectionView.register(ReviewsDetailCatalogCell.self,
                                                  forCellWithReuseIdentifier: ReviewsDetailCatalogCell.reuseId)

        detailCatalogVeiw.collectionView.delegate = self
    }

    @objc private func addToBasket() {
        let addToBasketFactory = requestFactory.makeAddToBasketRequestFactory()
        addToBasketFactory.addToBasket(idProduct: idProduct, quantity: 1) { (response) in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.showAlert(with: "", and: "The product was successfully added to the basket")
                    self.analytics.addToBasket(idProduct: self.idProduct)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Oops!", and: error.localizedDescription)
                }
            }
        }
    }

    private func getProduct() {
        let productFactory = requestFactory.makeProductFromCatalogRequestFactory()
        productFactory.getProduct(idProduct: idProduct) { (response) in
            switch response.result {
            case .success(let product):
                self.product = product
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Oops!", and: error.localizedDescription)
                }
            }
        }
    }
    private func getReviewList() {
        let reviewFactory = requestFactory.makeReviewListRequestFactory()
        reviewFactory.getReviewList(idProduct: idProduct) { (response) in
            switch response.result {
            case .success(let reviews):
                self.reviews = reviews.reviews
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Oops!", and: error.localizedDescription)
                }
            }
        }
    }

    private func reloadData() {
        guard let product = product else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.photos, .info, .addReview, .review])
        snapshot.appendItems(product.productPhotos, toSection: .photos)
        snapshot.appendItems([product], toSection: .info)
        snapshot.appendItems([user], toSection: .addReview)
        snapshot.appendItems(reviews, toSection: .review)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
// MARK: - Data Source
extension DetailProductViewContriller {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: detailCatalogVeiw.collectionView, cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .photos:
                return self.configure(collectionView: collectionView,
                                      cellType: PhotosDetailCatalogCell.self,
                                      with: item,
                                      for: indexPath)
            case .info:
                return self.configure(collectionView: collectionView,
                                      cellType: DescriptionDetailCatalogCell.self,
                                      with: item,
                                      for: indexPath)
            case .addReview:
                return self.configure(collectionView: collectionView,
                                      cellType: AddNewReviewCell.self,
                                      with: item,
                                      for: indexPath)
            case .review:
                return self.configure(collectionView: collectionView,
                                      cellType: ReviewsDetailCatalogCell.self,
                                      with: item,
                                      for: indexPath)
            }
        })
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: SectionHeader.reuseId,
                                                                                      for: indexPath) as? SectionHeader else {
                fatalError("Can not create new section header")
            }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            sectionHeader.configure(text: section.description(),
                                    font: .infoTextFont(),
                                    textColor: .gray)
            return sectionHeader
        }
    }
}

// MARK: - UICollectionViewDelegate
extension DetailProductViewContriller: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        if section == .addReview {
            let addReviewVC = AddReviewViewController(user: user, requestFactory: requestFactory, analytics: analytics)
            present(addReviewVC, animated: true, completion: nil)
        }
    }
    }
