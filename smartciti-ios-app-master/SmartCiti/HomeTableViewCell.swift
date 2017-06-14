//
//  HomeTableViewCell.swift
//  SmartCiti
//
//  Created by Sathish on 14/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var dislikeCountLabel: UILabel!
    @IBOutlet var dislikeButton: UIButton!
    @IBOutlet var likeCountLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var imageDisplay: UIImageView!
    @IBOutlet var dateAndDistanceView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonAction(_ sender: UIButton) {
        print("Like Action")
    }
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        print("Favorite Action")
    }
    @IBAction func dislikeButtonAction(_ sender: UIButton) {
        print("Dislike Action")
    }
}
