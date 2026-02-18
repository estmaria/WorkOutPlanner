//
//  ViewController.swift
//  WorkoutPlannerApp
//
//  Created by Studio on 4/23/25.
//

import UIKit

let routinesKey = "savedRoutines"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var routines: [Routine] = []
    
    func saveRoutinesToUserDefaults() {
        do {
            let data = try JSONEncoder().encode(routines)
            UserDefaults.standard.set(data, forKey: routinesKey)
        } catch {
            print("Error saving routines: \(error)")
        }
    }

    func loadRoutinesFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: routinesKey) {
            do {
                routines = try JSONDecoder().decode([Routine].self, from: data)
            } catch {
                print("Error loading routines: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath) as! RoutineCell
        let routine = routines[indexPath.row]
        cell.titleLabel.text = routine.name
        cell.notesLabel.text = routine.notes ?? "No notes"
            
            if let date = routine.lastUsed {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                cell.lastUsedLabel.text = "Last used: \(formatter.string(from: date))"
            } else {
                cell.lastUsedLabel.text = "Never used"
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                let routineName = routines[indexPath.row].name
                let alert = UIAlertController(
                    title: "Delete Routine?",
                    message: "Are you sure you want to delete \"\(routineName)\"?",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                    self?.routines.remove(at: indexPath.row)
                    self?.saveRoutinesToUserDefaults()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }))
                present(alert, animated: true)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CreateRoutineSegue" {
            // this is the new segue for creating a routine
            if let createVC = segue.destination as? CreateRoutineViewController {
                createVC.onComposeRoutine = { [weak self] newRoutine in
                    self?.routines.append(newRoutine)
                    self?.saveRoutinesToUserDefaults()
                    self?.tableView.reloadData()
                }
            }
            
        } else {
            // this handles your existing segue to DetailViewController
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let selectedRoutine = routines[indexPath.row]

            guard let destinationVC = segue.destination as? DetailViewController else { return }
            destinationVC.routine = selectedRoutine
            
            destinationVC.onUpdateRoutine = { [weak self] updatedRoutine in
                self?.routines[indexPath.row] = updatedRoutine
                self?.saveRoutinesToUserDefaults() 
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        loadRoutinesFromUserDefaults()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    
    @objc func didTapAddButton() {
        performSegue(withIdentifier: "CreateRoutineSegue", sender: nil)
    }
}



