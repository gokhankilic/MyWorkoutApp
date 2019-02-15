//
//  AddExerciseViewController.swift
//  MyWorkoutApp
//
//  Created by Gokhan Kilic on 16.11.2018.
//  Copyright © 2018 Gokhan Kilic. All rights reserved.
//

import UIKit
import Parse
class AddExerciseViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var exerciseNameText: UITextField!
    @IBOutlet weak var difficultyText: UITextField!
    @IBOutlet weak var exercisePhotoImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        exercisePhotoImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addExercise(_ sender: Any) {
        
        if exerciseNameText.text != nil && descriptionText.text != nil && difficultyText.text != nil {
            if let exerciseName = exerciseNameText.text{
                if let description = descriptionText.text {
                    if let difficulty = difficultyText.text{
                        if let imageData = self.exercisePhotoImageView.image?.pngData(){
                            if let imageFile = PFFile(name: "exercise.png", data: imageData){
                                
                                let exercise = Exercise(ExerciseName: exerciseName, ExercisePhoto: imageFile, Description: description, Diffuculty: difficulty, CreatedBy: (PFUser.current()?.objectId)!)
                                
                                var newExercise = PFObject(className: "Exercise")
                                newExercise["name"] = exercise.exerciseName
                                newExercise["photo"] = exercise.exercisePhoto
                                newExercise["description"] = exercise.description
                                newExercise["difficulty"] = exercise.difficulty
                                newExercise["createdBy"] = exercise.createdBy
                                
                                newExercise.saveInBackground { (success, error) in
                                    if success {
                                        
                                        let alert = UIAlertController.init(title: "Info", message: "Exercise was saved successfuly", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                            self.dismiss(animated: true, completion: nil)
                                        }))
                                       
                                        
                                        self.performSegue(withIdentifier: "toExercisesPage", sender: self)
                                        
                                    }else{
                                        
                                        let alert = UIAlertController.init(title: "Error", message: "Error", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                            self.dismiss(animated: true, completion: nil)
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
                
                
            }
            
            
        }else{
            
            let alert = UIAlertController.init(title: "Form", message: "Please fill all the blanks", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
