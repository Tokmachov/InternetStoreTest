//
//  ProductSupplier.swift
//  InternetStoreTest
//
//  Created by mac on 08/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class SupplierSingleton {
    static var shared: SupplierSingleton {
        get {
            if supplier != nil {
                return supplier!
            } else {
                supplier = SupplierSingleton()
                return supplier!
            }
        }
    }
    static private var supplier: SupplierSingleton?
    
    private var isolationQueue = DispatchQueue.init(label: "InternetStoreTestSupplierIsolationQueue", qos: .userInitiated)
    var delegate: SupplierDelegate?
    
    init() {}
    
    func order(_ product: Product) {
        isolationQueue.async {
            DispatchQueue.main.async {
                self.delegate?.supplier(self, didStartSupplying: product)
            }
            sleep(5)
            DispatchQueue.main.async {
                self.delegate?.supplier(self, didSupply: product)
            }
        }
    }
}

protocol SupplierDelegate: AnyObject {
    func supplier(_ supplier: SupplierSingleton, didStartSupplying product: Product)
    func supplier(_ supplier: SupplierSingleton, didSupply product: Product)
}
