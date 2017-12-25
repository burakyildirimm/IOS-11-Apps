//
//  AddPassword.swift
//  Remember Password App
//
//  Created by burak on 16.12.2017.
//  Copyright © 2017 Burak Yıldırım. All rights reserved.
//

import UIKit
import CoreData

class AddPassword: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var chosenTitle = String()
    var key = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
    }
    
    func getData() {
        
        if chosenTitle != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
            fetch.returnsObjectsAsFaults = false
            fetch.predicate = NSPredicate(format: "title = %@", chosenTitle)
            
            do {
                let results = try context.fetch(fetch)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        titleText.text = self.chosenTitle
                        
                        if let username = result.value(forKey: "username") as? String {
                            usernameText.text = username
                        }
                        if let password = result.value(forKey: "password") as? String {
                            passwordText.text = password
                        }
                        
                    }
                    
                }
            } catch {}
            
        } else {
            titleText.text = ""
            usernameText.text = ""
            passwordText.text = ""
        }
        
    }
    
    @IBAction func showClicked(_ sender: Any) {
        passwordText.isSecureTextEntry = false
    }
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        let appDeleagate = UIApplication.shared.delegate as! AppDelegate
        let context = appDeleagate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        fetch.returnsObjectsAsFaults = false
        fetch.predicate = NSPredicate(format: "title = %@", chosenTitle)
        
        do {
            let results = try context.fetch(fetch)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
                try context.save()
                self.navigationController?.popViewController(animated: true)
            }
        } catch {}
        
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if key == true {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newPost = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: context)
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
            fetch.returnsObjectsAsFaults = false
            fetch.predicate = NSPredicate(format: "title = %@", chosenTitle)
            
            do {
                let results = try context.fetch(fetch)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        context.delete(result)
                    }
                    do {
                        try context.save()
                    } catch {}
                }
            } catch {}
            
            newPost.setValue(titleText.text, forKey: "title")
            newPost.setValue(usernameText.text, forKey: "username")
            newPost.setValue(passwordText.text, forKey: "password")
            
            do {
                try context.save()
            } catch {}
            
            self.navigationController?.popViewController(animated: true)
        } else {
           
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newPost = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: context)
            
            newPost.setValue(titleText.text, forKey: "title")
            newPost.setValue(usernameText.text, forKey: "username")
            newPost.setValue(passwordText.text, forKey: "password")
            
            
            
            do {
                try context.save()
                self.navigationController?.popViewController(animated: true)
            } catch {}
        }
        
    }
}
