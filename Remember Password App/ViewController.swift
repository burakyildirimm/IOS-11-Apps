//
//  ViewController.swift
//  Remember Password App
//
//  Created by burak on 16.12.2017.
//  Copyright © 2017 Burak Yıldırım. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var titles = [String]()
    var sortTitles = [String]()
    var selectedTitle = ""
    var key = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPosts()
        key = false
    }
    
    @objc func getPosts() {
        titles.removeAll(keepingCapacity: false)
        sortTitles.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let objects = try context.fetch(fetchRequest)
            
            if objects.count > 0 {
                
                for object in objects as! [NSManagedObject] {
                    
                    if let fetchTitle = object.value(forKey: "title") as? String {
                        
                        self.titles.append(fetchTitle)
                    }
                }
                for indexOfArray in 0..<titles.count {
                    sortTitles.append(titles[(titles.count-1) - indexOfArray])
                }
                self.tableView.reloadData()
            }
        } catch {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTitle = self.sortTitles[indexPath.row]
        key = true
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd" {
            let destination = segue.destination as! AddPassword
            destination.chosenTitle = selectedTitle
            destination.key = key
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = sortTitles[indexPath.row]
        
        return cell
    }

}

