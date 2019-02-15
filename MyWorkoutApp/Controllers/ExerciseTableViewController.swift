//
//  ExerciseTableViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 16.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class ExerciseTableViewController: UITableViewController{
    
    var exercises:[PFObject] = []
    var exercisesEx:[Exercise] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isToolbarHidden = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.toolbar.isHidden = false
        exercisesEx.removeAll()
        var query = PFQuery(className: "Exercise")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
                print(error)
                
            }else{
                
                if let  exercises = objects{
                    
                    if exercises.count>0{
                        
                        for exercise in exercises as [PFObject] {
                            
                            if exercise != nil {
                                let newExercise = Exercise(ExerciseName: exercise["name"] as! String, ExercisePhoto:exercise["photo"] as! PFFile, Description: exercise["description"] as! String, Diffuculty: exercise["difficulty"] as! String, CreatedBy:exercise["createdBy"] as! String)
                                
                                self.exercisesEx.append(newExercise)
                                
                            }
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercisesEx.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! ExerciseTableViewCell
        cell.nameText.text = exercisesEx[indexPath.row].exerciseName
        cell.descriptionText.text = exercisesEx[indexPath.row].description
        cell.difficultyText.text = exercisesEx[indexPath.row].difficulty
        if let userPhoto = exercisesEx[indexPath.row].exercisePhoto as? PFFile{
            
            userPhoto.getDataInBackground { (data, error) in
                if let imageData = data {
                    
                    if let imageToDisplay = UIImage(data: imageData) {
                        
                        cell.exerciseImageView.image = imageToDisplay
                        
                    }
                    
                }
            }
            
        }
        return cell
    }
    

    
  
    @IBAction func addNewExercise(_ sender: Any) {
    }
    
    
}
