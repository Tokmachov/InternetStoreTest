
import UIKit

class StoreOptionsScreenVC: UITableViewController {
    private var storeOptionNamesListModel = [
        OptionInfo(name: "Покупки", storeBoardIDForOptionVC: "ProductForBuying"),
        OptionInfo(name: "Продажи", storeBoardIDForOptionVC: "ProductsForSelling")
    ]
}
extension StoreOptionsScreenVC {
    struct OptionInfo {
        var name: String
        var storeBoardIDForOptionVC: String
    }
}
extension StoreOptionsScreenVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeOptionNamesListModel.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreOptionCell", for: indexPath)
        let optionInfo = storeOptionNamesListModel[indexPath.row]
        cell.textLabel?.text = optionInfo.name
        return cell
    }
}

extension StoreOptionsScreenVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionInfo = storeOptionNamesListModel[indexPath.row]
        let vcID = optionInfo.storeBoardIDForOptionVC
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: vcID)
        showDetailViewController(vc, sender: nil)
    }
}
