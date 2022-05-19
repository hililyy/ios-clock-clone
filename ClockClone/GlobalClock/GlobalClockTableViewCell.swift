//
//  GlobalClockTableViewCell.swift
//  ClockClone
//
//  Created by 강조은 on 2022/05/19.
//

import UIKit

class GlobalClockTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
