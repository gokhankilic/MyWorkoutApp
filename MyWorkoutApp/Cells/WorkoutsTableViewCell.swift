//
//  WorkoutsTableViewCell.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 22.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class WorkoutsTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutDescription: UILabel!
    @IBOutlet weak var workoutName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
