
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
