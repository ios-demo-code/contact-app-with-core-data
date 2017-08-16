//
//  DetailContactTableViewController.swift
//  CoreData-Contact-App-06-08-2017
//
//  Created by Soeng Saravit on 8/6/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class DetailContactTableViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var contact:Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileImageView.clipsToBounds = true
        
        self.fullNameLabel.text = contact?.fullname
        self.phoneNumberLabel.text = contact?.phoneNumber
        self.emailLabel.text = contact?.email
        self.addressLabel.text = contact?.address
        self.profileImageView.image = UIImage(data: contact?.profileImage as! Data)
    }

    
}
