//
//  TodoTableViewCell.swift
//  Todo
//
//  Created by 영현 on 1/9/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var isCompletedSwitch: UISwitch!
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
