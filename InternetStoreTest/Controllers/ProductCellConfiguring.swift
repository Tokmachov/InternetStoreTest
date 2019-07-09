
import Foundation

protocol ProductCellConfiguring {
    func configure(_ cell: ProductCell, withProduct product: Product)
}

extension ProductCellConfiguring {
    func configure(_ cell: ProductCell, withProduct product: Product) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let price = formatter.string(from: NSNumber(value: product.price))
        
        cell.nameLabel.text = product.name
        cell.priceLabel.text = price
        cell.statusLabel.text = product.status.textualDecription
    }
}
