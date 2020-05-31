//
//  InfoViewController.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 25/05/20.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var image = UIImage()
    var name = ""
    var status = "online"
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.image = image
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        nameLabel.text = name
        statusLabel.text = status
        emailLabel.text = email
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }


}
