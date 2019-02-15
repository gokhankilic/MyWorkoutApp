//
//  AddWorkoutsTableViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 26.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class AddWorkoutsTableViewController: UITableViewController {
    
    var exercises:[PFObject] = []
    var exercisesEx:[Exercise] = []
    var workoutsDict: [Int:String] = [:]
    var workoutsPhotoDict:[Int:PFFile] = [:]
    var workoutsPhotoArray:[PFFile] = []
    var addWorkoutsArray:[String] = []
    var buttonStates:[Int:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exercisesEx.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! AddWorkoutTableViewCell
        
          if let exerciseName = exercisesEx[indexPath.row].exerciseName as? String{
                cell.exerciseName.text = exerciseName
                if let exerciseDes = exercisesEx[indexPath.row].description as? String {
                    cell.exerciseDescription.text = exerciseDes
                    if let exerxiseDiff = exercisesEx[indexPath.row].difficulty as? String {
                        cell.exerciseDifficulty.text = exerxiseDiff
                        if let exercisePhoto = exercisesEx[indexPath.row].exercisePhoto as? PFFile{
                            workoutsPhotoDict[indexPath.row] = exercisePhoto
                            exercisePhoto.getDataInBackground { (data, error) in
                                if let imageData = data {
                                    if let imageToDisplay = UIImage(data: imageData) {
                                        cell.exerciseImageView.image = imageToDisplay
                                        }
                                }
                            }
                            
                        }
                     }
            }
        }
        
        cell.addButton.tag = indexPath.row
        workoutsDict[indexPath.row] = cell.exerciseName.text!
       
        
        cell.addButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        
        if buttonStates[indexPath.row] != nil {
            
            cell.addButton.setTitle("Remove", for: .normal)
            
        }else{
            
            cell.addButton.setTitle("Add", for: .normal)
            
        }
        
        return cell
    }
    
    
    
    @objc func buttonSelected(sender: UIButton){
        
        
        print(sender.tag)
        
        if (sender.titleLabel?.text)! == "Add"{
            
            addWorkoutsArray.append(workoutsDict[sender.tag]!)
            
            if workoutsPhotoDict[sender.tag] != nil{
                workoutsPhotoArray.append(workoutsPhotoDict[sender.tag]!)
            }
            
            buttonStates[sender.tag] = "Remove"
            
            sender.setTitle("Remove", for: .normal)
            
            
            
        }else{
            
            var counter = 0
            
            for removeExercise in addWorkoutsArray{
                
                
                if workoutsDict[sender.tag]! == removeExercise{
                    
                    addWorkoutsArray.remove(at:counter)
                    sender.setTitle("Add", for: .normal)
                    buttonStates[sender.tag] = nil
                    break
                    
                }
                
                
                counter = counter + 1
                
            }
            
            
        }
        
        print(addWorkoutsArray)
        print(workoutsPhotoArray.count)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FinalAddWorkoutViewController{
            
            vc.exercises = addWorkoutsArray
            vc.exercisePhotos = workoutsPhotoArray
            
        }
    }
}

