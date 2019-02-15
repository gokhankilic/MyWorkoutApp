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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    
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
    
    
   
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
