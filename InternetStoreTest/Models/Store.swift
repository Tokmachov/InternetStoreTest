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
            self.products[index].status = .inProcessOfSelling
            DispatchQueue.main.async {
                self.delegate?.store(self, didStartSellingProductAtIndex: index)
            }
            sleep(3)
            self.products[index].status = .sold
            DispatchQueue.main.async {
                self.delegate?.store(self, didSellProductAtIndex: index)
            }
        }
    }
    
}

protocol StoreDelegate: AnyObject {
    func store(_ store: StoreSingleton, didStartSellingProductAtIndex index: Int)
    func store(_ store: StoreSingleton, didSellProductAtIndex index: Int)
}
