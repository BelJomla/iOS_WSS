

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class OrdersViewController: UIViewController {

    @IBOutlet weak var tableViewDP: UITableView!
    let db = Firestore.firestore()
    
    var deliveryPerson: [DeliveryPerson] = [];
    var dbData: [Any] = [];
    var userEmail: String = "";
    var userIDAuth: String = "";
    var clickedCell: Int = 0;
    var numberOfItems: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        // Do any additional setup after loading the view.
        tableViewDP.delegate = self
        tableViewDP.dataSource = self
        tableViewDP.register(UINib(nibName: K.dpCellNipName, bundle: nil), forCellReuseIdentifier: K.dpCellIdentifier)
        
        
        if let userIDDD = Auth.auth().currentUser?.uid {
            userIDAuth = userIDDD
        }
        if let user11 = Auth.auth().currentUser?.email {
            userEmail = user11
        }
        print(userEmail)
        loadOrders()
    }
    
    func loadOrders() {
        
        db.collection(K.KDatabase.newAccumlatedOrders)
            .whereField("WSSID", isEqualTo: userIDAuth)
            .whereField("accumOrderState", isEqualTo: 0)
            .order(by: K.KDatabase.dateField, descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                self.deliveryPerson = []
                self.dbData = []
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)");
            } else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        
                        let data = doc.data()
                        
                        self.dbData.append(data)
                        
                        //print("printing data:   \(data["accumOrderID"]!)")
                        //print("Delivery Person ID = \(data["DPID"]!)")
                        
                        if let deliveryPersonID = data[K.KDatabase.deliverPersonidForAccumlatedOrders] as? String {
                            self.addDeliveryPerson(deliveryPersonID: deliveryPersonID)
                        } else {
                            print("error")
                        }
                        DispatchQueue.main.async {
                            self.tableViewDP.reloadData()
                        }
                        
                    }
                }
            }
        }
    }
    
    func addDeliveryPerson (deliveryPersonID: String) {
        print("printing delivery person ID = \(deliveryPersonID)")
        db.collection(K.KDatabase.testUser).document(deliveryPersonID)
        .getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                
                if let dpFirstName = data?[K.KDatabase.firstName] as? String, let dpLastName = data?[K.KDatabase.lastName] as? String, let dpPhoneNumber = data?[K.KDatabase.phoneNumber] as? String {
                    //self.numberOfProduct(data: data22)
                    let newDp = DeliveryPerson(deliveryPersonName: "\(dpFirstName) \(dpLastName)", deliveryPersonPhoneNumber: dpPhoneNumber, numberOfItems: "Items to prepare")
                    self.numberOfItems = 0
                    //print(dpFirstName)
                    self.deliveryPerson.append(newDp)
                    
                    DispatchQueue.main.async {
                        self.tableViewDP.reloadData()
                    }
                    
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func numberOfProduct(data:[String: Any]) {
        if let cart = data["WSSOrderInfo"] as? [String: Any] {
            if let cart = cart["cart"] as? [String: Any] {
                if let cart = cart["items"] as? [[String: Any]]{
                    for itemToAdd in cart {
                        if let quan = itemToAdd["quantity"] as? Int {
                                      numberOfItems = numberOfItems + quan
                        }
                    }
                }
            }
        }
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



extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryPerson.count //Number of cells in the Table View Controller (Need to be changed)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.dpCellIdentifier, for: indexPath) as! deliveryPersonCell
        print(deliveryPerson[indexPath.row].deliveryPersonName)
        cell.nameLabel.text = deliveryPerson[indexPath.row].deliveryPersonName
        cell.phoneLabel.text = deliveryPerson[indexPath.row].deliveryPersonPhoneNumber
        cell.numberOfItemsLabel.text = deliveryPerson[indexPath.row].numberOfItems
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
}


extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        clickedCell = indexPath.row
        self.performSegue(withIdentifier: K.orderSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ItemsViewController
        vc.dd = dbData[clickedCell]
        vc.deliveryPersonName = deliveryPerson[clickedCell].deliveryPersonName
    }
}

