//
//  DetailViewController.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/16/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UITableViewController {

    var detailItem: BookReview?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        configureView()
    }
    
    func configureView() {
        if let detail = detailItem {
            titleLabel.text = detail.title
            headlineLabel.text = detail.headline
            authorLabel.text = detail.author
            summaryLabel.text = detail.summary
            releaseDateLabel.text = detail.publicationDate
            
            if let url = URL(string: detail.multimedia.src) {
                thumbnailImageView.kf.setImage(with: url)
            }
        }
    }
    
    @IBAction func selWebLink(_ sender: Any) {
        performSegue(withIdentifier: "ReviewWebDetail", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviewWebDetail" {
            if let vc = segue.destination as? ReviewWebViewController {
                vc.reviewUrl = detailItem?.link.url
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
}
