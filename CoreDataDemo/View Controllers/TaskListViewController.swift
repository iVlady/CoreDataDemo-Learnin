//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by iVlady on 05.07.2021.
//

import CoreData
import UIKit

import CoreData
import UIKit

final class TaskListViewController: UITableViewController {
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private static let cellId = "cell"
    private var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Self.cellId)
        tableView.dataSource = self
        setupNavigationBar()
//        fetchRequest()
//        tableView.reloadData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchRequest()
        tableView.reloadData()
    }

    private func setupNavigationBar() {
        title = "Task List"

        navigationController?.navigationBar.prefersLargeTitles = true

        // Navigation bar appeareance
        let navBarAppereance = UINavigationBarAppearance()
        navBarAppereance.configureWithOpaqueBackground()

        navBarAppereance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppereance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navBarAppereance.backgroundColor = UIColor(
            red: 21 / 255,
            green: 101 / 255,
            blue: 192 / 255,
            alpha: 194 / 255
        )

        navigationController?.navigationBar.standardAppearance = navBarAppereance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppereance

        // Add button to nav bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask)
        )

        navigationController?.navigationBar.tintColor = .white
    }

    @objc private func addNewTask() {
        let newTaskVC = NewTaskViewController()
        newTaskVC.modalPresentationStyle = .fullScreen
        present(newTaskVC, animated: true)
    }

    private func fetchRequest() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()

        do {
            tasks = try viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }
}

extension TaskListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId,
                                                 for: indexPath)
        let task = tasks[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = task.title

        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let singleTask = tasks[indexPath.row]
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            DataManager.shared.deleteData(singleTask: singleTask)
            
        }
    }
}
