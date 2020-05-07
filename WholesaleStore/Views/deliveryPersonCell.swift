//
//  deliveryPersonCell.swift
//  WholesaleStore
//
//  Created by Abdullah Alsalamah on 05/05/2020.
//  Copyright © 2020 Abdullah Alsalamah. All rights reserved.
//

import UIKit

class deliveryPersonCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBOutlet weak var viewForShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewForShadow.layer.shadowColor = UIColor.black.cgColor
        viewForShadow.layer.shadowOpacity = 0.3
        viewForShadow.layer.shadowOffset = .zero
        viewForShadow.layer.shadowRadius = 3
        
        viewForShadow.layer.cornerRadius = viewForShadow.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
