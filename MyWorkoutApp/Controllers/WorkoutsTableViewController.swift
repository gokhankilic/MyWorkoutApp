//
//  WorkoutsTableViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 22.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class WorkoutsTableViewController: UITableViewController {
    var workouts:[Workout] = []
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        workouts.removeAll()
        var query = PFQuery(className: "Workouts")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
                print(error)
                
            }else{
                
                if let  workoutsObjects = objects{
                    
                    if workoutsObjects.count>0{
                        
                        for workout in workoutsObjects as [PFObject] {
                        
                            if workout != nil {
                                if let name = workout["name"] as? String{
                                    if let cylces = workout["cycleCount"] as? String {
                                         if let exerciseNames = workout["exerciseNames"] as? [String] {
                                            if let exerciseSets = workout["exercisesSets"] as? [String]{
                                                if let description = workout["description"] as? String{
                                                    if let exercisePhotos = workout["exercisePhotos"] as? [PFFile]{
                                                    var newWorkout = Workout(
                                                        exerciseName: name, exerciseDescription: description, exerciseCycleCount: cylces, exerciseSets: exerciseSets, exerciseNames: exerciseNames, exercisePhoto: exercisePhotos)
                                        
                                                    self.workouts.append(newWorkout)
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                            
                                        }
                                      
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workouts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! WorkoutsTableViewCell
        
        cell.workoutName.text = workouts[indexPath.row].name
        cell.workoutDescription.text = workouts[indexPath.row].description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRow = indexPath.row
        performSegue(withIdentifier: "goToDetails", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            let query = PFQuery(className: "Workouts")
            query.whereKey("name", equalTo: self.workouts[indexPath.row].name)
            query.findObjectsInBackground(block: { (objects, error) in
                for object in objects! {
                    object.deleteEventually()
                   self.workouts.remove(at: indexPath.row)
                   tableView.reloadData()
                }
            })
           
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        return [deleteAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WorkoutDetailViewController{
            
           vc.workout = workouts[selectedRow]
            
        }
    }
    
    
}
