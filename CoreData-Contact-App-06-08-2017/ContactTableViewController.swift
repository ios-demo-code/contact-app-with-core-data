//
//  ContactTableViewController.swift
//  CoreData-Contact-App-06-08-2017
//
//  Created by Soeng Saravit on 8/6/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var contacts:[Contact]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        getContacts()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (contacts?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        // Configure the cell...
        let contact = contacts?[indexPath.row]
        cell.configureCell(contact: contact!)

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts?[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetail", sender: contact)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            let contact = self.contacts?[indexPath.row]
            self.performSegue(withIdentifier: "ShowEdit", sender: contact)
        }
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
           
            let contact = self.contacts?[indexPath.row]
            
            self.context.delete(contact!)
            
            self.appDelegate.saveContext()
            
            self.getContacts()
            self.tableView.reloadData()
        }
        
        return [edit, delete]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let dest = segue.destination as! DetailContactTableViewController
            dest.contact = sender as? Contact
        }
        if segue.identifier == "ShowEdit" {
            let dest = segue.destination as! AddEditViewController
            dest.contact = sender as? Contact
        }
    }
    
    func getContacts(){
        self.contacts = try? context.fetch(Contact.fetchRequest())
    }

}
