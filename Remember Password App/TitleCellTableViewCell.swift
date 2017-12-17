//
//  TitleCellTableViewCell.swift
//  Remember Password App
//
//  Created by burak on 16.12.2017.
//  Copyright © 2017 Burak Yıldırım. All rights reserved.
//

import UIKit

class TitleCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
