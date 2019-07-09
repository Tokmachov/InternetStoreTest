//
//  Store.swift
//  InternetStoreTest
//
//  Created by mac on 08/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class StoreSingleton {
    
    private static var store: StoreSingleton?
    
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
    
    private var isolationQueue = DispatchQueue(
        label: "InternetStoreIsolationQueue",
        qos: .userInitiated
    )
    
    private var products: [Product] {
        didSet {
            saveProductsToMemory()
        }
    }
    
    private init() {
        self.products = []
        self.products = loadProductsFromMemory()
    }
    
    weak var delegate: StoreDelegate?
    
    var productsCount: Int {
        return products.count
    }
    
    func product(atIndex index: Int) -> Product {
        return products[index]
    }
    
    func buyProduct(atIndex index: Int) {
        isolationQueue.async {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.products[index].status = .isInProcessOfSelling
                self.delegate?.store(self, didUpdateProductStatusAtIndex: index)
            }
            sleep(3)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.products[index].status = .isSold
                self.delegate?.store(self, didUpdateProductStatusAtIndex: index)
            }
        }
    }
    
    func addToStore(_ product: Product) {
        var product = product
        product.status = .isInProcessOfAdding
        isolationQueue.async {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.products.append(product)
                self.delegate?.store(self, didAddNewProductAtIndex: (self.products.endIndex - 1))
            }
            sleep(5)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.products[self.products.endIndex - 1].status = .available
                self.delegate?.store(self, didUpdateProductStatusAtIndex: (self.products.endIndex - 1))
            }
        }
    }
}

extension StoreSingleton {
    private func loadProductsFromMemory() -> [Product] {
        guard let url = Bundle.main.url(forResource: "Products", withExtension: "plist") else { fatalError() }
        let xml = try! Data(contentsOf: url)
        return try! PropertyListDecoder().decode([Product].self, from: xml)
    }
    private func saveProductsToMemory() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        let url = Bundle.main.url(forResource: "Products" , withExtension: "plist")!
        do {
            let data = try encoder.encode(products)
            try data.write(to: url)
        } catch {
            print(error)
        }
    print("Saved")
    }
}

protocol StoreDelegate: AnyObject {
    func store(_ store: StoreSingleton, didUpdateProductStatusAtIndex index: Int)
    func store(_ store: StoreSingleton, didAddNewProductAtIndex index: Int)
}
