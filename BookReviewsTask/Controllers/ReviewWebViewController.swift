//
//  ReviewWebViewController.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/18/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import UIKit
import WebKit

class ReviewWebViewController: UIViewController {
    
    @IBOutlet weak var reviewWebView: WKWebView!
    var reviewUrl : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let reviewUrl = reviewUrl else {
            dismiss(animated: true, completion: nil)
            return
        }

        let myURL = URL(string:reviewUrl)
        let myRequest = URLRequest(url: myURL!)
        reviewWebView.load(myRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
