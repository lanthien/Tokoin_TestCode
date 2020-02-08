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
        self.lblTitle.text = new.title
        self.lblContent.text = new.description
        self.lblAuthor.text = new.author ?? new.source.name
        self.lblTime.text = new.publishedAt
            .convertToDate()
            .convertToString()
        
        guard let imageLink = new.urlToImage else { return }
        let url = URL(string: imageLink)
        self.imvThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image-available"), options: .continueInBackground) { [weak self](image, error, _, _) in
            guard let _ = image else { return }
            DispatchQueue.main.async {
                self?.imvThumbnail.contentMode = .scaleAspectFill
            }
        }
    }
    
}
