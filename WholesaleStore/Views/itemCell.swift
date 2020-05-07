//
//  itemCell.swift
//  WholesaleStore
//
//  Created by Abdullah Alsalamah on 05/05/2020.
//  Copyright © 2020 Abdullah Alsalamah. All rights reserved.
//

import UIKit

class itemCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var vieww: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //vieww.layer.borderWidth = 1
        //vieww.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
