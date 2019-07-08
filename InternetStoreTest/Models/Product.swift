//
//  Product.swift
//  InternetStoreTest
//
//  Created by mac on 03/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
struct Product: Codable {
    enum Status: Int, Codable {
        case available
        case isInProcessOfSelling
        case isSold
        case isInProcessOfAdding
        
        var textualDecription: String {
            switch self {
            case .available:
                return "В наличии"
            case .isInProcessOfSelling:
                return "В процессе продажи"
            case .isSold:
                return "Продан"
            case .isInProcessOfAdding:
                return "В процессе поставки"
            }
        }
    }
    var name: String
    var description: String
    var price: Double
    var status: Status
}
