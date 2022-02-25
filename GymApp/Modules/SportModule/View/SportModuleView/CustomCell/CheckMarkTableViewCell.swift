//
//  CheckMarkTableViewCell.swift
//  GymApp
//
//  Created by Chris on 2021/8/19.
//  Copyright © 2021 Chris. All rights reserved.
//

import UIKit

class CheckMarkTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        accessoryType = isSelected ? .checkmark : .none
    }

}
