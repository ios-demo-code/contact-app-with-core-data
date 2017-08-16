//
//  AddEditViewController.swift
//  CoreData-Contact-App-06-08-2017
//
//  Created by Soeng Saravit on 8/6/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit
import CoreData

class AddEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var contact:Contact?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        // Make image View to be rounded
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileImageView.clipsToBounds = true
        
        // Set Data to each Text Field if edit 
        if contact != nil {
            self.fullNameTextField.text = contact?.fullname
            self.phoneNumberTextField.text = contact?.phoneNumber
            self.emailTextField.text = contact?.email
            self.addressTextField.text = contact?.address
            self.profileImageView.image = UIImage(data: contact?.profileImage as! Data)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.profileImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func browsePhoto(_ sender:UITapGestureRecognizer){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func saveBarButtonAction(_ sender: Any) {
        
        let image = UIImageJPEGRepresentation(self.profileImageView.image!, 0.5)
        
        if self.contact != nil {
            let contactUpdate = getContact(id: (self.contact?.objectID)!)
            
            contactUpdate.fullname = self.fullNameTextField.text
            contactUpdate.phoneNumber = self.phoneNumberTextField.text
            contactUpdate.email = self.emailTextField.text
            contactUpdate.address = self.addressTextField.text
            contactUpdate.profileImage = image as NSData?
        }else {
            let contact = Contact(context: context)
            contact.fullname = self.fullNameTextField.text
            contact.phoneNumber = self.phoneNumberTextField.text
            contact.email = self.emailTextField.text
            contact.address = self.addressTextField.text
            contact.profileImage = image as NSData?
        }

        appDelegate.saveContext()
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func getContact(id:NSManagedObjectID) -> Contact {
        return context.object(with: id) as! Contact
    }
    
}
