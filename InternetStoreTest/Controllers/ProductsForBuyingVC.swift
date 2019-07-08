
import UIKit

class ProductsForBuyingVC: UITableViewController {

    private var store = StoreSingleton.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.delegate = self
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show product details" {
            guard let vc = segue.destination as? ProductDetailsVC,
                let index = tableView.indexPathForSelectedRow?.row else { return }
            vc.indexOfProductToDisplay = index
        }
    }
}

extension ProductsForBuyingVC: ProductCellConfiguring {}

extension ProductsForBuyingVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.productsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "Product Cell", for: indexPath) as! ProductCell
        let product = store.product(atIndex: indexPath.row)
        configure(productCell, withProduct: product)
        return productCell
    }
}

extension ProductsForBuyingVC: StoreDelegate {
    func store(_ store: StoreSingleton, didUpdateProductStatusAtIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    func store(_ store: StoreSingleton, didAddNewProductAtIndex index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}



