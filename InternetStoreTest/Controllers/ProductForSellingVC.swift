//
//  ProductForSellingVC.swift
//  InternetStoreTest
//
//  Created by mac on 04/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductsForSellingVC: UITableViewController {
    
    private var store = StoreSingleton.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.delegate = self
        tableView.reloadData()
    }
}

extension ProductsForSellingVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.productsCount
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = store.product(atIndex: indexPath.row)
        configure(productCell, withProduct: product)
        return productCell
    }
}

extension ProductsForSellingVC: ProductCellConfiguring {}

extension ProductsForSellingVC: StoreDelegate {
    func store(_ store: StoreSingleton, didUpdateProductStatusAtIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func store(_ store: StoreSingleton, didReserveSlotForProductAtIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
