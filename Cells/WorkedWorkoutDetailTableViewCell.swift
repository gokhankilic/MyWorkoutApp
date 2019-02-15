//
//  WorkedWorkoutDetailTableViewCell.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 29.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class WorkedWorkoutDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var repCount: UILabel!
    @IBOutlet weak var exerciseName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
