//
//  FinishWorkoutTableViewCell.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 28.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class FinishWorkoutTableViewCell: UITableViewCell {
    
    //Users enter the count of the finished exercises into this cell

    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseRep: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
