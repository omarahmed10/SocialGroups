//
//  MenuTableViewCell.swift
//  IslamAcademy
//
//  Created by Hosam Elsafty on 9/27/18.
//  Copyright © 2018 Hosam Elsafty. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(model : String,image : UIImage){
        logo.image = image
        title.text = model
    }

}
