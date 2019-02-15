//
//  ProfileViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 15.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    
    var workedWorkouts:[String] = []
    var workedDates:[String] = []
    var indexPath:Int = 0
    var menuShowing = false
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workedWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "workedWorkout")
        
        if workedWorkouts.count>0 && workedDates.count>0{
            cell.textLabel?.font = cell.textLabel?.font.withSize(13)
            var date = workedDates[indexPath.row].components(separatedBy: "+")
            cell.textLabel?.text = workedWorkouts[indexPath.row] + "\t \(date[0])"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath.row
        performSegue(withIdentifier: "toWorkedDetail", sender: self)
    }
    
    
    
    
    @IBAction func openMenu(_ sender: Any) {
        if menuShowing{
            self.leadingConstraint.constant = -200
             UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        else{
            
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
            }
        }
        
        menuShowing = !menuShowing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        if let  user = PFUser.current() {
            var currentUser = user
            if let userName = currentUser.username{
                nameLabel.text = userName
            }
        }
    }
    
    
    
    
    
    @IBAction func logout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                
                print("Error")
                
            }else {
                
                print("Successfully logout")
                
                self.performSegue(withIdentifier: "logoutToMainScreen", sender: self)
                
            }
        }
    }
    
    
    
    @IBAction func uploadPhoto(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImageView.image = image
        self.dismiss(animated: true, completion: nil)
        
        let query = PFUser.query()
        
        if let userID = PFUser.current()?.objectId {
            query?.getObjectInBackground(withId: userID, block: { (object, error) in
                if error != nil {
                    print("ERROR")
                    
                }
                else {
                    
                    if let user = object as? PFUser{
                        print("USER IS HERE" + (user.email)!)
                        
                        if let imageData = self.profileImageView.image!.pngData() {
                            print("IMAGE IS READY")
                            if let imageFile = PFFile(name: "image.png", data: imageData){
                                print("FILE IS READY")
                                
                                user["profilePhoto"] = imageFile
                                user.saveInBackground()
                                
                            }
                        }
                    }
                }
            })
        }
    }
    
    
    
    @IBAction func toExercisePageMenuButton(_ sender: Any) {
        self.leadingConstraint.constant = -200
        menuShowing = !menuShowing
        performSegue(withIdentifier: "toExercisePage", sender: self)
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        workedDates.removeAll()
        workedWorkouts.removeAll()
        
        navigationController?.toolbar.isHidden = true
        if PFUser.current() != nil {
            
            if let user = PFUser.current(){
                if let userPhoto = user["profilePhoto"] as? PFFile{
                    userPhoto.getDataInBackground { (data, error) in
                        if let imageData = data {
                            
                            if let imageToDisplay = UIImage(data: imageData) {
                                
                                self.profileImageView.image = imageToDisplay
                            }
                        }
                    }
                }
          }
        }
        
        let query = PFQuery(className: "WorkedWorkouts")
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
                print(error)
                
            }else{
                
                if let  workedWorkouts = objects{
                    
                    if workedWorkouts.count>0{
      
                        for workout in workedWorkouts as [PFObject] {
                            
                            if workout != nil {
                                
                                if let workoutName = workout["name"] as? String{
                                   
                                    let workoutDate = (workout.createdAt?.description)!
                                   
                                    self.workedWorkouts.append(workoutName)
                                    self.workedDates.append(workoutDate)
                                    
                                }
                                
                            }
                        }
                         self.tableView.reloadData()
                    }
                    
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WorkedWorkoutDetailViewController{
            
           vc.finishedWorkoutDate = self.workedDates[indexPath]
            
        }
    }
    
    
    
    @IBAction func workoutsPageTabbed(_ sender: Any) {
        self.leadingConstraint.constant = -200
        menuShowing = !menuShowing
        performSegue(withIdentifier: "toWorkoutsPage", sender: self)
        
    }
    
    
}
