//
//  FinalAddWorkoutTableViewCell.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 27.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class FinalAddWorkoutTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    //This cell takes the information about the final step of creating new workouts

    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseReps: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exerciseReps.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        exerciseReps.resignFirstResponder()
        return true
    }
   
   
}
