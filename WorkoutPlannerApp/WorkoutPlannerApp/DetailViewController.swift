//
//  DetailViewController.swift
//  WorkoutPlannerApp
//
//  Created by Studio on 4/23/25.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routine?.exercises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
            
            if let exercise = routine?.exercises[indexPath.row] {
                cell.textLabel?.text = "\(exercise.name) - \(exercise.sets)x\(exercise.reps) @ \(exercise.weight) lbs"
            }
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard var routine = routine else { return }

            var exercises = routine.exercises
            exercises.remove(at: indexPath.row)

            let updatedRoutine = Routine(
                name: routine.name,
                notes: routine.notes,
                lastUsed: routine.lastUsed,
                exercises: exercises
            )

            self.routine = updatedRoutine
            self.onUpdateRoutine?(updatedRoutine)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openExerciseEditor(at: indexPath.row)
    }
    
    @objc func addExercise() {
        openExerciseEditor(at: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notesLabel: UILabel!
    
    
    var routine: Routine?
    var onUpdateRoutine: ((Routine) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = routine?.name
        notesLabel.text = routine?.notes ?? "No notes"

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editRoutine))
        
        let footerButton = UIButton(type: .system)
        footerButton.setTitle("+ Add Exercise", for: .normal)
        footerButton.setTitleColor(.systemBlue, for: .normal)
        footerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        footerButton.addTarget(self, action: #selector(addExercise), for: .touchUpInside)

        // Make the button fill the width and have some height
        footerButton.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60)

        // Assign it as the table view's footer
        tableView.tableFooterView = footerButton
        
    }
    
    @objc func editRoutine() {
        performSegue(withIdentifier: "EditRoutineSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditRoutineSegue" {
            if let createVC = segue.destination as? CreateRoutineViewController,
               let routine = routine {
                createVC.routineToEdit = routine
                createVC.onComposeRoutine = { [weak self] updatedRoutine in
                    self?.routine = updatedRoutine
                    self?.navigationItem.title = updatedRoutine.name
                    self?.notesLabel.text = updatedRoutine.notes ?? "No notes"
                    // Re-render anything else if needed
                }
            }
        }
    }
    
    func openExerciseEditor(at index: Int?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseDetailViewController") as? ExerciseDetailViewController {

            if let i = index, let exercise = routine?.exercises[i] {
                vc.exercise = exercise
            }

            vc.onSave = { [weak self] updatedExercise in
                guard var routine = self?.routine else { return }

                var exercises = routine.exercises

                if let i = index {
                    exercises[i] = updatedExercise // edit
                } else {
                    exercises.append(updatedExercise) // add
                }

                let updatedRoutine = Routine(
                    name: routine.name,
                    notes: routine.notes,
                    lastUsed: routine.lastUsed,
                    exercises: exercises
                )

                self?.routine = updatedRoutine
                self?.onUpdateRoutine?(updatedRoutine)
                self?.tableView.reloadData()
            }

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
