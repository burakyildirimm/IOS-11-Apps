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
    var selectedTitle = ""
    var key = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPosts()
    }
    
    @objc func getPosts() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let objects = try context.fetch(fetchRequest)
            
            if objects.count > 0 {
                
                titles.removeAll(keepingCapacity: false)
                
                for object in objects as! [NSManagedObject] {
                    
                    if let fetchTitle = object.value(forKey: "title") as? String {
                        
                        self.titles.append(fetchTitle)
                        
                    }
                    self.tableView.reloadData()
                }
                
            }
        } catch {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTitle = self.titles[indexPath.row]
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd" {
            let destination = segue.destination as! AddPassword
            destination.chosenTitle = selectedTitle
            key = false
            destination.key = key
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
    }

}

