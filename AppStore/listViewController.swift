//
//  ViewController.swift
//  AppStore
//
//  Created by Admin on 3/21/19.
//  Copyright © 2019 mariamelnezamy. All rights reserved.
//

import UIKit
import CoreData

class listViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,NSFetchedResultsControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }
    
    var controller:NSFetchedResultsController<Items>!
    @IBOutlet var TableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    //    Edit Or Delete
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objc = controller.fetchedObjects {
            let item = objc[indexPath.row]
            performSegue(withIdentifier: "EditOrDelete", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditOrDelete" {
            if let destination = segue.destination as? AddItemViewController {
           //     let selectedRow = self.TableView.indexPathForSelectedRow
                if let item = segue as? Items {
                    destination.EditOrDeleteItem = item
                }
            }
        }
    }
    
    func loadItems() {
        let fetchRequest :NSFetchRequest<Items> = Items.fetchRequest()
        let data_addSort = NSSortDescriptor(key: "data_add", ascending: false)
        fetchRequest.sortDescriptors = [data_addSort]
        controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
                do{
                    try controller.performFetch()        
                }catch{
                    print("error")
                }
    }
    
    func configureCell(cell: TableViewCell , indexPath:NSIndexPath) {
        let singleitem = controller.object(at: indexPath as IndexPath)
        cell.setMyCell(item: singleitem)
    } 
    
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        TableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        TableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = indexPath{
                TableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath{
                TableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath{
                let cell = TableView.cellForRow(at: indexPath) as! TableViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move :
            if let indexPath = indexPath {
                TableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = indexPath {
                TableView.insertRows(at: [indexPath], with: .fade)
            }
        }
    }
}


