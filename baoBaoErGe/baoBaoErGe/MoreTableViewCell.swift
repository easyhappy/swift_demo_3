


//
//  MoreTableViewCell.swift
//  baoBaoErGe
//
//  Created by andyhu on 15/8/3.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
