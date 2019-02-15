//
//  WorkoutDetailViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 27.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var cycleCount: UILabel!
    var workout:Workout? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (workout?.exerciseNames.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = (tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! WorkoutDetailTableViewCell)
        
       cell.exerciseName.text = workout?.exerciseNames[indexPath.row]
       cell.exerciseRep.text = workout?.exerciseSets[indexPath.row]
       workout?.exercisePhotos[indexPath.row].getDataInBackground { (data, error) in
            if let imageData = data {
                
                if let imageToDisplay = UIImage(data: imageData) {
                    
                  cell.exerciseImage.image = imageToDisplay
                    
                }
                
            }
        }
        
       return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        workoutName.text = workout?.name
        cycleCount.text = workout?.cycleCount
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func startWorkout(_ sender: Any) {
        
        performSegue(withIdentifier: "startWorkout", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FinishWorkoutViewController{
            
            vc.workout = self.workout
            
        }
    }

}
