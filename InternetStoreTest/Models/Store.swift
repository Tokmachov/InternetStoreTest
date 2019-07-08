//
//  Store.swift
//  InternetStoreTest
//
//  Created by mac on 08/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class StoreSingleton {
    static var shared: StoreSingleton {
        get {
            if store != nil {
                return store!
            } else {
                store = StoreSingleton()
                return store!
            }
        }
    }
    private static var store: StoreSingleton?
   
    private var isolationQueue: DispatchQueue = DispatchQueue(label: "InternetStoreIsolationQueue", qos: .userInitiated)
    
    private var products: [Product] = []
    
    weak var delegate: StoreDelegate?
    
    private init() {}
    
    func add(_ products: [Product]) {
        isolationQueue.async {
            self.products += products
        }
    }
    var productsCount: Int {
        return products.count
    }
    
    func product(atIndex index: Int) -> Product {
        var product: Product?
        product = products[index]
        return product!
    }
    
    func buyProduct(atIndex index: Int) {
        isolationQueue.async {
            self.products[index].status = .isInProcessOfSelling
            DispatchQueue.main.async {
                self.delegate?.store(self, didUpdateProductStatusAtIndex: index)
            }
            sleep(3)
            self.products[index].status = .isSold
            DispatchQueue.main.async {
                self.delegate?.store(self, didUpdateProductStatusAtIndex: index)
            }
        }
    }
    func supplyProductToStore(_ product: Product) {
        var product = product
        product.status = .isInProcessIfSupplying
        isolationQueue.async {
            self.products.append(product)
            DispatchQueue.main.async {
                self.delegate?.store(self, didReserveSlotForProductAtIndex: (self.products.endIndex - 1))
            }
            sleep(5)
            self.products[self.products.endIndex - 1].status = .available
            DispatchQueue.main.async {
                self.delegate?.store(self, didUpdateProductStatusAtIndex: (self.products.endIndex - 1))
            }
        }
    }
}

protocol StoreDelegate: AnyObject {
    func store(_ store: StoreSingleton, didUpdateProductStatusAtIndex index: Int)
    func store(_ store: StoreSingleton, didReserveSlotForProductAtIndex index: Int)
}
