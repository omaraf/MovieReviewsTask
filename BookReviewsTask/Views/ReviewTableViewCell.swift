//
//  ReviewTableViewCell.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/16/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import UIKit
import Kingfisher

class ReviewTableViewCell: UITableViewCell {
    
    var bookReview : BookReview?

    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayData(bookReview : BookReview) {
        self.bookReview = bookReview
        titleLabel.text = bookReview.title
        headlineLabel.text = bookReview.headline
        releaseDateLabel.text = bookReview.publicationDate
        
        if let url = URL(string: bookReview.multimedia.src) {
            reviewImageView.kf.setImage(with: url)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
