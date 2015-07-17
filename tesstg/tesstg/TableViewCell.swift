//
//  TableViewCell.swift
//  tesstg
//
//  Created by andyhu on 15/7/17.
//  Copyright (c) 2015年 andyhu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var a: UIImageView!
    @IBOutlet weak var b: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
