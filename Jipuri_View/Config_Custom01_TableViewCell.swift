//
//  Config_Custom01_TableViewCell.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/21.
//  Copyright © 2017年 横山　新. All rights reserved.
//

import UIKit

class Config_Custom01_TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var mid_label: UILabel!
    @IBOutlet weak var bottom_label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
