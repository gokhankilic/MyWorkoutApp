//
//  WorkedWorkoutDetailViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 29.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class WorkedWorkoutDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var exerciseNames:[String]?
    var exerciseReps:[String]?
    var finishedWorkoutDate:String = ""
    var workedWorkoutName:String = ""
    var workedCycle:String = ""
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var cycleCount: UILabel!
    @IBOutlet weak var finishedDate: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numbOfExerciseNames = exerciseNames?.count {
            return numbOfExerciseNames
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! WorkedWorkoutDetailTableViewCell
        
        if (exerciseNames?.count)! > indexPath.row && (exerciseReps?.count)! > indexPath.row {
            cell.exerciseName.text = exerciseNames?[indexPath.row]
            cell.repCount.text = exerciseReps?[indexPath.row]
            return cell
        }else {
            return UITableViewCell()
        }
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let query = PFQuery(className: "WorkedWorkouts")
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
                print(error)
                
            }else{
                
                if let  workedWorkouts = objects{
                    
                    if workedWorkouts.count>0{
                        
                        for workout in workedWorkouts as [PFObject] {
                            
                            if workout != nil {
                                
                                if workout.createdAt?.description == self.finishedWorkoutDate {
                                    
                                    
                                    
                                    if let exerciseNames = workout["exerciseNames"] as? [String]{
                                        
                                        
                                        
                                        if let exerciseReps = workout["exercisesSets"] as? [String]{
                                            
                                            
                                            
                                            if let workedWorkoutName = workout["name"] as? String{
                                                
                                                
                                                
                                                if let workedCycle = workout["cycleCount"] as? String {
                                                    
                                                    
                                                    
                                                    self.exerciseNames = exerciseNames
                                                    self.exerciseReps = exerciseReps
                                                    self.workedWorkoutName = workedWorkoutName
                                                    self.workedCycle = workedCycle
                                                    
                                                    
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                    self.tableView.reloadData()
                    self.workoutName.text = self.workedWorkoutName
                    self.cycleCount.text = "Worked cycle is \(self.workedCycle)"
                    
                    var date = self.finishedWorkoutDate.components(separatedBy: "+")
                    self.finishedDate.text = "Finished at \(date[0])"
                    
                }
                
            }
        }
    
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
