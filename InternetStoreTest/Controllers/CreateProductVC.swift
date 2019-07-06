//
//  CreateProductVC.swift
//  InternetStoreTest
//
//  Created by mac on 04/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CreateProductVC: UIViewController {
    private var name: String?
    private var productDescription: String?
    private var price: Double?
    private var product: Product? {
        guard let name = name,
        let productDescription = productDescription,
            let price = price else { return nil }
        return Product(name: name, description: description, price: price)
    }
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBAction func editingDidChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        price = Double(text)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.textContainer.heightTracksTextView = true
        nameTextView.isScrollEnabled = false
        descriptionTextView.isScrollEnabled = false
    }
}

extension CreateProductVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case let textView where textView === nameTextView:
            name = textView.text
        case let textView where textView === descriptionTextView:
            productDescription = textView.text
        default: break
    }
    
    }
}
