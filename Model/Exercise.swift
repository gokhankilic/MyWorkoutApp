//
//  Exercise.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 15.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import Foundation
import Parse

class Exercise {
    
    let exerciseName : String
    let exercisePhoto: PFFile
    let description : String
    let difficulty : String
    let createdBy: String
    
    init(ExerciseName exerciseName:String, ExercisePhoto exercisePhoto:PFFile, Description description:String, Diffuculty difficulty:String, CreatedBy createdBy:String ) {
        
        self.exerciseName = exerciseName
        self.exercisePhoto = exercisePhoto
        self.description = description
        self.difficulty = difficulty
        self.createdBy = createdBy
    }
    
}
