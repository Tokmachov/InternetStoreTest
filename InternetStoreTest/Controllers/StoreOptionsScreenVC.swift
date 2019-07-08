
import UIKit

class StoreOptionsScreenVC: UITableViewController {
    var storeOptionNamesList = ["Покупки", "Продажи"]
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
            guard let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ProductForBuying") as? ProductsForBuyingVC  else { return }
            showDetailViewController(vc, sender: nil)
        case "Продажи":
            guard let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "ProductsForSellingVC") as? ProductsForSellingVC  else { return }
            showDetailViewController(vc, sender: nil)
        default: break
        }
    }
}



