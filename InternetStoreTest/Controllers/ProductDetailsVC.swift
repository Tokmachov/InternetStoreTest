//
//  ProductDetailsVC.swift
//  InternetStoreTest
//
//  Created by mac on 04/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {
    
    var indexOfProductToDisplay: Int!
    
    private var store = StoreSingleton.shared
    
    private var product: Product! {
        didSet {
            renderProductStaticData()
            renderProductStatus()
        }
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        product = store.product(atIndex: indexOfProductToDisplay)
        store.delegate = self
    }
    
    @IBAction func buyButtonIsTapped() {
        store.buyProduct(atIndex: indexOfProductToDisplay)
    }
}

extension ProductDetailsVC {
    private func renderProductStaticData() {
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = String(product.price)
    }
    private func renderProductStatus() {
        statusLabel.text = product.status.textualDecription
        switch product.status {
        case .available, .sold:
            activityIndicator.stopAnimating()
        case .inProcessOfSelling:
            activityIndicator.startAnimating()
        }
    }
}

extension ProductDetailsVC: StoreDelegate {
    func store(_ store: StoreSingleton, didStartSellingProductAtIndex index: Int) {
        guard index == indexOfProductToDisplay else { return }
        product = store.product(atIndex: index)
        print("1")
    }
    
    func store(_ store: StoreSingleton, didSellProductAtIndex index: Int) {
        guard index == indexOfProductToDisplay else { return }
        product = store.product(atIndex: index)
        print("2")
    }
}

