//
//  AvailableProductsList.swift
//  InternetStoreTest
//
//  Created by mac on 03/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductsForBuyingVC: UITableViewController {
    
    var products: [Product]!
    var seller: SellerSingleton = SellerSingleton.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        seller.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "Show products details":
            guard let productDetailsVC = segue.destination as? ProductDetailsVC,
                let productIndex = tableView.indexPathForSelectedRow?.row else { return }
            productDetailsVC.product = products[productIndex]
            productDetailsVC.delegate = self
        default: break
        }
    }
}
extension ProductsForBuyingVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as? ProductCell else { fatalError() }
        let productName = products[indexPath.row].name
        let productPrice = String(products[indexPath.row].price)
        let productStatus = products[indexPath.row].status.textualDecription
        
        productCell.nameLabel.text = productName
        productCell.priceLabel.text = productPrice
        productCell.statusLabel.text = productStatus
        
        return productCell
    }
}

extension ProductsForBuyingVC: ProductDetailsVCDelegate {
    func productDetailsVCDelegate(_ productDetailsVC: ProductDetailsVC, didFinishWorkWith product: Product) {
        
    }
}

extension ProductsForBuyingVC: SellerDelegate {
    func seller(_ seller: SellerSingleton, didStartSelling product: Product) {
        
    }
    func seller(_ seller: SellerSingleton, didSell product: Product) {
        print("ProductsForBuyingVC: продан продукт \(product.name) в ")
    }
}
protocol ProductDetailsVCDelegate: AnyObject {
    func productDetailsVCDelegate(_ productDetailsVC: ProductDetailsVC, didFinishWorkWith product: Product)
}





