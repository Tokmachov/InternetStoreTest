
import UIKit

class StoreOptionsScreenVC: UITableViewController {
    var storeOptionNamesList = ["Покупки", "Продажи"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let products = loadProductsFromMemory()
        StoreSingleton.shared.add(products)
    }
}
extension StoreOptionsScreenVC {
    private func loadProductsFromMemory() -> [Product] {
        guard let url = Bundle.main.url(forResource: "Products", withExtension: "plist") else { fatalError() }
        let xml = try! Data(contentsOf: url)
        return try! PropertyListDecoder().decode([Product].self, from: xml)
    }
//    private func saveProductsToMemory() {
//        let encoder = PropertyListEncoder()
//        encoder.outputFormat = .xml
//        
//        let url = Bundle.main.url(forResource: "Products" , withExtension: "plist")!
//        do {
//            let data = try encoder.encode(products)
//            try data.write(to: url)
//        } catch {
//            print(error)
//        }
//    }
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
            showDetailViewController(vc, sender: nil)
        case "Продажи":
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsForSellingVC") as? ProductsForSellingVC  else { return }
            showDetailViewController(vc, sender: nil)
        default: break
        }
    }
}



