//
//  ItemsViewController.swift
//  WholesaleStore
//
//  Created by Abdullah Alsalamah on 03/05/2020.
//  Copyright © 2020 Abdullah Alsalamah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class ItemsViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var itemsTableView: UITableView!
    var dd: (Any)? = nil;
    var data: [String: Any] = [:];
    var deliveryPersonName: String = "";
    var items: [Item] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let ddd = dd as? [String: Any] {
            print(ddd["DPID"]!)
            data = ddd
            if let cart = data["WSSOrderInfo"] as? [String: Any] {
                if let cart = cart["cart"] as? [String: Any] {
                    if let cart = cart["items"] as? [[String: Any]]{
                        productLoad(arrItems: cart)
                    }
                }
            }
        }
        self.itemsTableView.rowHeight = 80
        navItem.title = deliveryPersonName
        
        //print(data!)
        print(deliveryPersonName)
        // Do any additional setup after loading the view.
        itemsTableView.dataSource = self
        itemsTableView.register(UINib(nibName: K.itemCellNipName, bundle: nil), forCellReuseIdentifier: K.itemCellIdentifier)
        
    }
    

    func productLoad(arrItems: [[String: Any]]) {
//        print(arrItems[0]["quantity"]!)
//        print("sdfsdfsd")
//        print(arrItems[0]["product"]!)
        
        for itemToAdd in arrItems {
            var imgURL: String = "";
            var productName: String = "";
            //var productSize: String = "";
            var productQuantity: String = "";
            if let product = itemToAdd["product"] as? [String: Any] {
                if let imurl = product["imgURLs"] as? [String] {
                    imgURL = imurl[0]
                }
                if let prodName = product["name"] as? [String: String], let qSize = product["quantativeSize"] as? [String: String] {
                    productName = "\(prodName["en"]!) - \(qSize["en"]!)";
                }
            }
            if let quan = itemToAdd["quantity"] {
                productQuantity = "\(quan)"
            }
            
            let nwItem = Item(itemName: productName, itemQuantity: productQuantity, itemImageURL: imgURL)
            
            items.append(nwItem)
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.itemCellIdentifier, for: indexPath) as! itemCell
        
        cell.productName.text = items[indexPath.row].itemName
        cell.productQuantity.text = items[indexPath.row].itemQuantity
        do {
            let url = URL(string: items[indexPath.row].itemImageURL)
            let data = try Data(contentsOf: url!)
            //self.imageView.image = UIImage(data: data)
            cell.productImage.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80
    }
    
    
}
