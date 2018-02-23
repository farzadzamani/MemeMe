//
//  memeTableViewCell.swift
//  MemeMe
//
//  Created by Farzad on 9/25/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

class SentMemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var textOfImage: UILabel!
    
    @IBOutlet weak var textOfImage2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
