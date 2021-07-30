//
//  Data Manager.swift
//  CoreDataDemo
//
//  Created by Vlad Vinogrotskiy on 30.07.2021.
//

import Foundation
import CoreData
import UIKit

class DataManager {

    static let shared = DataManager()
    private init() {}
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData() {
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteData(singleTask: Task) {

        viewContext.delete(singleTask)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch
                let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
//    func fetchRequest() {
//        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
//
//        do {
//            tasks = try viewContext.fetch(fetchRequest)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
    
}
