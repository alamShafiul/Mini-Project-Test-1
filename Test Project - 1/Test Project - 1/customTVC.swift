//
//  customTVC.swift
//  Test Project - 1
//
//  Created by Admin on 12/1/23.
//

import UIKit

class customTVC: UITableViewCell {

    @IBOutlet weak var imgField: UIImageView!
    @IBOutlet weak var titleField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
