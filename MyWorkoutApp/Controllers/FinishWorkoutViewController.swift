//
//  FinishWorkoutViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 28.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class FinishWorkoutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var reps:[Int:String] = [:]
    var workout:Workout? = nil
    var repsArray = [String]()
    
    @IBOutlet weak var cycleCount: UITextField!
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var addButton:UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (workout?.exerciseNames.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! FinishWorkoutTableViewCell)
        
        print(indexPath.row)
        
        cell.exerciseRep.tag = indexPath.row
        cell.exerciseRep.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        
        if let exercise = workout?.exerciseNames[indexPath.row]{
            
            cell.exerciseName.text = exercise
            
        }
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        workoutName.text = workout?.name
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField){
        
        reps[textField.tag] = textField.text
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func finishWorkout(_ sender: Any) {
        
        
        for i in 0...(workout?.exerciseNames.count)!{
            
            if let rep = reps[i]{
                repsArray.append(rep)
            }
        }
        if cycleCount.text != nil {
            if repsArray.count > 0 {
                if (workout?.exerciseNames.count)! > 0 {
                    let finishedWorkout = PFObject(className: "WorkedWorkouts")
                    finishedWorkout["name"] = workout?.name
                    finishedWorkout["cycleCount"] = cycleCount.text
                    finishedWorkout["exerciseNames"] = workout?.exerciseNames
                    finishedWorkout["exercisesSets"] = repsArray
                    
                    
                    
                    
                    finishedWorkout.saveInBackground { (succes, error) in
                        if error != nil{
                            
                            print(error)
                            
                        }else{
                            print("WORKOUT HAS BEEN SUCCESSFULLY FINISHED")
                            
                            
                            self.dismiss(animated: false, completion: nil)
                            
                        }
                    }
                    
                }
            }
        }
        
        
    
    
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
}


    
    
}

