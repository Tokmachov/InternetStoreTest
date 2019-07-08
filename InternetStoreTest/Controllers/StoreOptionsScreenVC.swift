
import UIKit

class StoreOptionsScreenVC: UITableViewController {
    var storeOptionNamesList = ["Покупки", "Продажи"]

    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
            saveProductsToMemory()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        products = loadProductsFromMemory()
    }
    
    
}
extension StoreOptionsScreenVC {
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
    }
}

extension StoreOptionsScreenVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeOptionNamesList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOptionCell", for: indexPath)
        let optionName = storeOptionNamesList[indexPath.row]
        cell.textLabel?.text = optionName
        return cell
    }
}

extension StoreOptionsScreenVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionName = storeOptionNamesList[indexPath.row]
        switch  optionName {
        case "Покупки":
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductForBuying") as? ProductsForBuyingVC  else { return }
            vc.products = products
            showDetailViewController(vc, sender: nil)
        case "Продажи":
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsForSellingVC") as? ProductsForSellingVC  else { return }
            vc.products = products
            vc.completion = { [weak self] products in
                guard let self = self else { return }
                self.products = products
            }
            showDetailViewController(vc, sender: nil)
        default: break
        }
    }
}


