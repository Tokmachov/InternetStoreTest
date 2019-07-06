
import UIKit

class StoreOptionsScreenVC: UITableViewController {
    var storeOptionNamesList = ["Покупки", "Продажи"]

    var products = [car, bear, pear, water, air]

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
            
            showDetailViewController(vc, sender: nil)
        default: break
        }
    }
}



let car = Product(name: "Машина", description: "Хорошая машина", price: 2500)
let bear = Product(name: "Плюшевый медведь", description: "Хороший медведь", price: 10)
let pear = Product(name: "Груша", description: "Хорошая груша", price: 20)
let water = Product(name: "Вода", description: "Хорошая вода", price: 1)
let air = Product(name: "Воздух", description: "Хороший воздух", price: 100.66)

