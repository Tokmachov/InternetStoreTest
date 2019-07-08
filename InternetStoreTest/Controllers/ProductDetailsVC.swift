//
//  ProductDetailsVC.swift
//  InternetStoreTest
//
//  Created by mac on 04/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    var product: Product!
    
    weak var delegate: ProductDetailsVCDelegate!
    
    private var seller: SellerSingleton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUIWithProductInfo()
        setupSeller()
        renderProductStatus()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate.productDetailsVCDelegate(self, didFinishWorkWith: product)
    }
    @IBAction func buyButtonIsTapped() {
        seller.sell(product)
    }
}

extension ProductDetailsVC: SellerDelegate {
    func seller(_ seller: SellerSingleton, didStartSelling product: Product) {
        print("Начал продавать")
        self.product.status = Product.Status.inProcessOfSelling
        renderProductStatus()
    }
    func seller(_ seller: SellerSingleton, didSell product: Product) {
        print("Продал")
        self.product.status = Product.Status.sold
        renderProductStatus()
        self.product.status = Product.Status.available
        renderProductStatus()
    }
}

extension ProductDetailsVC {
    private func populateUIWithProductInfo() {
        self.nameLabel.text = product.name
        self.descriptionLabel.text = product.description
        self.priceLabel.text = String(product.price)
        self.statusLabel.text = product.status.textualDecription
    }
    
    private func setupSeller() {
        self.seller = SellerSingleton.shared
        self.seller.delegate = self
    }
    private func renderProductStatus() {
        self.statusLabel.text = product.status.textualDecription
        switch product.status {
        case .available, .sold:
            activityIndicator.stopAnimating()
        case .inProcessOfSelling:
            activityIndicator.startAnimating()
        }
    }
}
