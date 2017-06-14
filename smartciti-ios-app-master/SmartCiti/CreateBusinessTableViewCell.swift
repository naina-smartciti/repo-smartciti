//
//  CreateBusinessTableViewCell.swift
//  SmartCiti
//
//  Created by Sathish on 21/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import UIKit

class CreateBusinessTableViewCell: UITableViewCell {

    @IBOutlet var createBusinessImage: UIImageView!
    @IBOutlet var businessName: UILabel!
    @IBOutlet var businessWebsiteLabel: UILabel!
    @IBOutlet var businessLocaitonLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var dislikeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func dislikeButtonAciton(_ sender: UIButton) {
    }
}
