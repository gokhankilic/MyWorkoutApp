//
//  WorkoutDetailTableViewCell.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 27.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class WorkoutDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseRep: UILabel!
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
