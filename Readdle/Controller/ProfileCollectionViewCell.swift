//
//  FruitCollectionViewCell.swift
//  CustomCollectionLayout
//
//  Created by Vladimir Drozdin on 24/05/20.
//  Copyright © 2020 Vladimir Drozdin. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: ProfileCollectionViewCell.self)
    static let nib = UINib(nibName: String(describing: ProfileCollectionViewCell.self), bundle: nil)
    
    @IBOutlet private weak var stackView: UIStackView!
    
    @IBOutlet weak var ibImageView: UIImageView!
    @IBOutlet weak var ibLabel: UILabel!
    var profileManager = ProfileManager()
    
    var statusView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        statusView.clipsToBounds = true
        statusView.layer.cornerRadius = 10
        statusView.layer.borderColor = UIColor.white.cgColor
        
        statusView.layer.borderWidth = 2
        self.ibImageView.clipsToBounds = true
        self.ibImageView.frame.size.width = 42
        self.ibImageView.frame.size.height = 42
        
        self.ibImageView.layer.cornerRadius = ibImageView.frame.size.height / 2
        
        statusView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addSubview(statusView)
        
        NSLayoutConstraint.activate([
               statusView.bottomAnchor.constraint(equalTo: ibImageView.bottomAnchor, constant: 2),
               statusView.trailingAnchor.constraint(equalTo: ibImageView.trailingAnchor,constant: 2),
               statusView.widthAnchor.constraint(equalToConstant: 20),
               statusView.heightAnchor.constraint(equalToConstant: 20)
        ])
       
        stackView.bringSubviewToFront(statusView)

        stackView.setNeedsLayout()
    }
    
    func loadStatus(with status: String) {
        if status == "online" {
            statusView.backgroundColor = .systemGreen
        } else {
            statusView.backgroundColor = .systemRed
        }
    }
    
    func loadGravatar(url : String) {
        
        var _ = profileManager.fetchGravatars(with: url) { (image, error) in
            if let image = image {
                DispatchQueue.main.async {
                    self.ibImageView.image = image
                }
            }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateContentStyle()
    }
    
    func update(title: String) {
        ibLabel.text = title
    }
    
    private func updateContentStyle() {
        let isHorizontalStyle = bounds.width > 2 * bounds.height
        let oldAxis = stackView.axis
        let newAxis: NSLayoutConstraint.Axis = isHorizontalStyle ? .horizontal : .vertical
        guard oldAxis != newAxis else { return }

        stackView.axis = newAxis
        stackView.spacing = isHorizontalStyle ? 16 : -30
        ibLabel.textAlignment = isHorizontalStyle ? .left : .center
        let fontTransform: CGAffineTransform = isHorizontalStyle ? .identity : CGAffineTransform(scaleX: 0, y: 0) 
        
        UIView.animate(withDuration: 0.3) {
            self.ibLabel.transform = fontTransform
            self.layoutIfNeeded()
        }
    }
}
