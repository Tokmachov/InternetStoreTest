//
//  ProductCellConfiguring.swift
//  InternetStoreTest
//
//  Created by mac on 08/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol ProductCellConfiguring {
    func configure(_ cell: ProductCell, withProduct product: Product)
}

extension ProductCellConfiguring {
    func configure(_ cell: ProductCell, withProduct product: Product) {
        cell.nameLabel.text = product.name
        cell.priceLabel.text = String(product.price)
        cell.statusLabel.text = product.status.textualDecription
    }
}
