//
//  ContactTableViewCell.swift
//  CoreData-Contact-App-06-08-2017
//
//  Created by Soeng Saravit on 8/6/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(contact:Contact){
        self.fullNameLabel.text = contact.fullname
        self.phoneNumberLabel.text = contact.phoneNumber
        self.profileImageView.image = UIImage(data: contact.profileImage as! Data)
    }
}
