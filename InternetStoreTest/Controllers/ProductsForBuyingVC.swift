//
//  AvailableProductsList.swift
//  InternetStoreTest
//
//  Created by mac on 03/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ProductsForBuyingVC: UITableViewController {

    private var store = StoreSingleton.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.delegate = self
        tableView.reloadData()
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show products details" {
            guard let vc = segue.destination as? ProductDetailsVC,
                let index = tableView.indexPathForSelectedRow?.row else { return }
            vc.indexOfProductToDisplay = index
        } else {
            return
        }
    }
}

extension ProductsForBuyingVC: ProductCellConfiguring {}

extension ProductsForBuyingVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.productsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as? ProductCell else { fatalError() }
        let product = store.product(atIndex: indexPath.row)
        configure(productCell, withProduct: product)
        return productCell
    }
}

extension ProductsForBuyingVC {
    func configure(_ cell: ProductCell, withProduct product: Product) {
        cell.nameLabel.text = product.name
        cell.priceLabel.text = String(product.price)
        cell.statusLabel.text = product.status.textualDecription
    }
}

extension ProductsForBuyingVC: StoreDelegate {
    func store(_ store: StoreSingleton, didUpdateProductStatusAtIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func store(_ store: StoreSingleton, didReserveSlotForProductAtIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}



