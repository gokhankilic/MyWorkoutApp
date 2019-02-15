//
//  Workout.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 27.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import Foundation
import Parse

class Workout{
    
    let name : String
    let description: String
    let cycleCount : String
    let exerciseSets : [String]
    let exerciseNames: [String]
    let exercisePhotos:[PFFile]
    
    
    init(exerciseName:String, exerciseDescription:String,exerciseCycleCount:String, exerciseSets:[String], exerciseNames:[String],exercisePhoto:[PFFile]) {
        self.name = exerciseName
        self.description = exerciseDescription
        self.cycleCount = exerciseCycleCount
        self.exerciseSets = exerciseSets
        self.exerciseNames = exerciseNames
        self.exercisePhotos = exercisePhoto
    }
}
