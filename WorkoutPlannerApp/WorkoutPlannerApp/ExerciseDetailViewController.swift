//
//  ExerciseDetailViewController.swift
//  WorkoutPlannerApp
//
//  Created by Studio on 6/28/25.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var setsTextField: UITextField!
    
    @IBOutlet weak var repsTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    // MARK: - Data Passed In
        var exercise: Exercise? = nil
        var onSave: ((Exercise) -> Void)? = nil

        override func viewDidLoad() {
            super.viewDidLoad()
            title = exercise == nil ? "New Exercise" : "Edit Exercise"
            setupFields()

            // Add Save button to nav bar
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveExercise))
        }

        private func setupFields() {
            guard let exercise = exercise else { return }
            nameTextField.text = exercise.name
            setsTextField.text = String(exercise.sets)
            repsTextField.text = String(exercise.reps)
            weightTextField.text = String(exercise.weight)
        }

        @objc private func saveExercise() {
            guard
                let name = nameTextField.text, !name.isEmpty,
                let setsText = setsTextField.text, let sets = Int(setsText),
                let repsText = repsTextField.text, let reps = Int(repsText),
                let weightText = weightTextField.text, let weight = Double(weightText)
            else {
                presentAlert()
                return
            }

            let updatedExercise = Exercise(name: name, sets: sets, reps: reps, weight: weight)
            onSave?(updatedExercise)
            navigationController?.popViewController(animated: true)
        }

        private func presentAlert() {
            let alert = UIAlertController(title: "Invalid Input", message: "Please fill out all fields correctly.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
