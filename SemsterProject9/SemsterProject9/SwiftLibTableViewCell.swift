//
//  SwiftLibTableViewCell.swift
//  SemsterProject9
//
//  Created by Keegan Black on 5/6/19.
//  Copyright © 2019 SemesterProject9. All rights reserved.
//

import UIKit

class SwiftLibTableViewCell: UITableViewCell {

    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var authorOutlet: UILabel!
    @IBOutlet weak var scoreOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
