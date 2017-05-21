//
//  Information_CustomTableViewCell.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/14.
//  Copyright © 2017年 横山　新. All rights reserved.
//

import UIKit

class Information_CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var Info_department: UILabel!
    @IBOutlet weak var Info_title: UILabel!
    @IBOutlet weak var Info_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
