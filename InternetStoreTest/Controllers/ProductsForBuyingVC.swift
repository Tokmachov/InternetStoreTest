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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "Show products details":
            guard let productDetailsVC = segue.destination as? ProductDetailsVC,
                let productIndex = tableView.indexPathForSelectedRow?.row else { return }
            productDetailsVC.product = products[productIndex]
        default: break
        }
    }
}
extension ProductsForBuyingVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath)
        let productName = products[indexPath.row].name
        let productPrice = String(products[indexPath.row].price)
        productCell.textLabel?.text = productName
        productCell.detailTextLabel?.text = productPrice
        return productCell
    }
}







