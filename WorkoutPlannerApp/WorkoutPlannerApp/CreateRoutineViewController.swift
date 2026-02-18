//
//  CreateRoutineViewController.swift
//  WorkoutPlannerApp
//
//  Created by Studio on 6/13/25.
//

import UIKit

class CreateRoutineViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    var onComposeRoutine: ((Routine) -> Void)? = nil
    
    var routineToEdit: Routine?
    var routineIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Routine"
        
        if let routine = routineToEdit {
            title = "Edit Routine"
            titleTextField.text = routine.name
            notesTextField.text = routine.notes
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else {
                    presentAlert(title: "Missing Title", message: "Please enter a routine name.")
                    return
                }
                let notes = notesTextField.text

                let newRoutine = Routine(name: title, notes: notes, lastUsed: nil, exercises: [])
                onComposeRoutine?(newRoutine)
                dismiss(animated: true)
        
        let updatedRoutine = Routine(
            name: title,
            notes: notes,
            lastUsed: routineToEdit?.lastUsed,
            exercises: routineToEdit?.exercises ?? []
        )
        onComposeRoutine?(updatedRoutine)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)    }
    
    private func presentAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
}
