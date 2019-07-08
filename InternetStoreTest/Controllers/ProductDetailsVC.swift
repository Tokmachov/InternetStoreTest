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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUIWithProductInfo()
        setupSeller()
    }
    
    @IBAction func buyButtonIsTapped() {
        seller.buy(product)
    }
}

extension ProductDetailsVC: SellerDelegate {
    func seller(_ seller: SellerSingleton, didStartSelling product: Product) {
        print("Details: Начата продажа \(product.name)")
    }
    func seller(_ seller: SellerSingleton, didSell product: Product) {
        print("Details: Продукт \(product.name) продан")
    }
}

extension ProductDetailsVC {
    private func populateUIWithProductInfo {
        self.nameLabel.text = product.name
        self.descriptionLabel.text = product.description
        self.priceLabel.text = String(product.price)
    }
    private func setupSeller() {
        self.seller = SellerSingleton.shared
        self.seller.delegate = self
    }
}
