//
//  ProductDetailsVC.swift
//  InternetStoreTest
//
//  Created by mac on 04/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MessageUI

class ProductDetailsVC: UIViewController  {
    
    var indexOfProductToDisplay: Int!
    
    private var store = StoreSingleton.shared
    private lazy var priceFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
       formatter.numberStyle = .currency
       return formatter
    }()
    
    private var product: Product! {
        didSet {
            renderProductStaticData()
            renderProductStatus()
        }
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        product = store.product(atIndex: indexOfProductToDisplay)
        store.delegate = self
    }
    
    @IBAction func buyButtonIsTapped() {
        store.buyProduct(atIndex: indexOfProductToDisplay)
    }
    @IBAction func shareButtonIsTapped() {
        sendEmail()
    }
}

extension ProductDetailsVC {
    private func renderProductStaticData() {
        let price = priceFormatter.string(from: NSNumber(value: product.price))
        
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        priceLabel.text = price
    }
    private func renderProductStatus() {
        statusLabel.text = product.status.textualDecription
        switch product.status {
        case .available, .isSold:
            activityIndicator.stopAnimating()
        case .isInProcessOfSelling:
            activityIndicator.startAnimating()
        case .isInProcessOfAdding:
            activityIndicator.startAnimating()
        }
    }
}

extension ProductDetailsVC: StoreDelegate {
    func store(_ store: StoreSingleton, didUpdateProductStatusAtIndex index: Int) {
        guard index == indexOfProductToDisplay else { return }
        product = store.product(atIndex: index)
    }
    func store(_ store: StoreSingleton, didAddNewProductAtIndex index: Int) {
        guard index == indexOfProductToDisplay else { return }
        product = store.product(atIndex: index)
    }
}

extension ProductDetailsVC {
    private func createPDF() -> Data {
        let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        let formattedPrice = priceFormatter.string(from: NSNumber(value: product.price))!
        let text = """
        Название товара: \(product.name)
        
        Описание товара: \(product.description)
        
        Цена товара: \(formattedPrice)
        """
        let textAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]
        
        let formattedText = NSMutableAttributedString(string: text, attributes: textAttributes)
        
        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            formattedText.draw(in: pageRect.insetBy(dx: 50, dy: 50))
        }
        return data
    }
}

extension ProductDetailsVC: MFMailComposeViewControllerDelegate {
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            let pdf = createPDF()
            mail.addAttachmentData(pdf, mimeType: "application/pdf", fileName: "Some")
            present(mail, animated: true)
        }
    }
    
    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
