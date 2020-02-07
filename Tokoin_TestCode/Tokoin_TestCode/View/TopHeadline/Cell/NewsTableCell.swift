//
//  NewsTableCell.swift
//  Tokoin_TestCode
//
//  Created by Nexle-LanDT on 2/8/20.
//  Copyright © 2020 LanThien. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableCell: UITableViewCell {
    @IBOutlet private weak var imvThumbnail: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblContent: UILabel!
    @IBOutlet private weak var lblAuthor: UILabel!
    @IBOutlet private weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(new: New) {
        self.lblTime.text = new.title
        self.lblAuthor.text = new.description
        self.lblAuthor.text = new.author ?? new.source.name
        self.lblTime.text = new.publishedAt
            .convertToDate()
            .convertToString()
        
        guard var imageLink = new.urlToImage else { return }
        var parts = imageLink.split(separator: "?")
        parts.removeLast()
        imageLink = parts.joined()
        let url = URL(string: imageLink)
        self.imageView?.sd_setImage(with: url, completed: nil)
    }
    
}
