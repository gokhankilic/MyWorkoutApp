//
//  ExerciseTableViewCell.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 16.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var difficultyText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
