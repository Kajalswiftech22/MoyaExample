//
//  ComicsTableViewCell.swift
//  MoyaExample
//
//  Created by intern on 6/6/23.
//

import UIKit

class ComicsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var comicsTitleLabel: UILabel!
    @IBOutlet weak var comicsDescLabel: UILabel!
    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var imageSecond: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
