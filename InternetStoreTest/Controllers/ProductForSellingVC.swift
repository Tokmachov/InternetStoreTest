//
//  ProductForSellingVC.swift
//  InternetStoreTest
//
//  Created by mac on 04/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductsForSellingVC: UITableViewController {
    var products: [Product]!
    var completion: (([Product]) -> Void)!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateProductVC" {
            guard let vc = (segue.destination as? UINavigationController)?
                .viewControllers.first as? CreateProductVC else { return }
            vc.completion = { [ weak self ] product in
                guard let self = self else { return }
                self.products.append(product)
                self.completion(self.products)
                self.tableView.reloadData()
            }
        }
    }
}

extension ProductsForSellingVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = String(product.price)
        return cell
    }
}
