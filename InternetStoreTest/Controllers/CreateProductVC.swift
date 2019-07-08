//
//  CreateProductVC.swift
//  InternetStoreTest
//
//  Created by mac on 04/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CreateProductVC: UIViewController {
    //MARK: Model
    private var store = StoreSingleton.shared
    
    private var name: String?
    private var productDescription: String?
    private var price: Double?
    private var product: Product? {
        guard let name = name,
        let productDescription = productDescription,
            let price = price else { return nil }
        return Product(name: name, description: productDescription, price: price, status: .available)
    }
    
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextView.isScrollEnabled = false
        descriptionTextView.isScrollEnabled = false
    }
    
    @IBAction func editingDidChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        price = Double(text)
    }
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonWasTapped(_ sender: Any) {
        guard let product = product else { return }
        store.supplyProductToStore(product)
        presentingViewController?.dismiss(animated: true, completion: nil)
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
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}
extension CreateProductVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        priceTextField.resignFirstResponder()
        return true
    }
}

