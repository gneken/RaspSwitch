//
//  TableViewCell.swift
//  RemoteRaspSwitch
//
//  Created by Keng Jy Feng on 2015-05-05.
//  Copyright (c) 2015 gneken. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
