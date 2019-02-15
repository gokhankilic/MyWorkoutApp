//
//  AddWorkoutTableViewCell.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 26.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class AddWorkoutTableViewCell: UITableViewCell{
    
   
    
    
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseDescription: UILabel!
    
    @IBOutlet weak var exerciseDifficulty: UILabel!
    
    @IBOutlet weak var exerciseImageView: UIImageView!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
   
        
       
}
