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
    
    
    @IBAction func addNewExercise(_ sender: Any) {
    }
    
    
}
