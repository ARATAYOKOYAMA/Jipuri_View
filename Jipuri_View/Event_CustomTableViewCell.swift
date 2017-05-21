//
//  Event_CustomTableViewCell.swift
//  Jipuri_View
//
//  Created by 横山　新 on 2017/05/15.
//  Copyright © 2017年 横山　新. All rights reserved.
//

import UIKit

class Event_CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var Event_Image: UIImageView!
    @IBOutlet weak var Event_department: UILabel!
    @IBOutlet weak var Event_lastupdateted: UILabel!
    @IBOutlet weak var Event_title: UILabel!
    @IBOutlet weak var Event_day: UILabel!
    @IBOutlet weak var Event_starttime: UILabel!
    @IBOutlet weak var Event_finishtime: UILabel!
    @IBOutlet weak var Event_location: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
