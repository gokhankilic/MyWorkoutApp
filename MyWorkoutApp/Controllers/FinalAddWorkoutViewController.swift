//
//  FinalAddWorkoutViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 27.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class FinalAddWorkoutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var workoutCycle: UITextField!
    @IBOutlet weak var workoutDescription: UITextField!
    @IBOutlet weak var workoutName: UITextField!
    var exercises:[String] = []
    var reps:[Int:String] = [:]
    var exercisePhotos:[PFFile] = []
    var repsArray:[String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = (tableView.dequeueReusableCell(withIdentifier: "addRepsCell", for: indexPath) as! FinalAddWorkoutTableViewCell)
        
        cell.exerciseReps.tag = indexPath.row
        cell.exerciseReps.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
        if let exercise = exercises[indexPath.row] as? String{
            
            cell.exerciseName.text = exercise
            
        }
        
        return cell
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutCycle.delegate = self
        workoutName.delegate = self
        workoutDescription.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addWorkout(_ sender: Any) {
        
        for i in 0...exercises.count{
            
            if let rep = reps[i]{
              repsArray.append(rep)
            }
        }
        
        
        var newWorkout = PFObject(className: "Workouts")
        newWorkout["name"] = workoutName.text!
        newWorkout["description"] = workoutDescription.text!
        newWorkout["cycleCount"] = workoutCycle.text!
        newWorkout["exerciseNames"] = exercises
        newWorkout["exercisesSets"] = repsArray
        newWorkout["exercisePhotos"] = exercisePhotos
        
        
        newWorkout.saveInBackground { (succes, error) in
            if error != nil{
                
                print(error)
                
            }else{
                print("WORKOUT HAS BEEN SUCCESSFULLY SAVED")
                
               
                self.dismiss(animated: false, completion: nil)
               
            }
        }
        
        
    }
    
    
    
    
    
    @objc private func textFieldDidChange(_ textField: UITextField){
        
        reps[textField.tag] = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
