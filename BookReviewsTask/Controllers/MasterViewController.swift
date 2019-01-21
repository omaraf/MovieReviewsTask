//
//  MasterViewController.swift
//  BookReviewsTask
//
//  Created by Omar Aguilar on 1/16/19.
//  Copyright © 2019 Omar Aguilar. All rights reserved.
//

import UIKit
import Kingfisher

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    private var objects = [BookReview]()
    private let reviewsService = ReviewsService()
    private var isFetchInProgress = false


    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        tableView.register(UINib.init(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        tableView.estimatedRowHeight = 100.0
        tableView.prefetchDataSource = self
        
        fetchReviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let review = objects[indexPath.row]
                if let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController {
                    controller.detailItem = review
                    controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        let object = objects[indexPath.row]
        cell.displayData(bookReview: object)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func fetchReviews(_ offset: Int? = 0) {
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        reviewsService.fetchReviews(offset: offset, completion: { [weak self] reviews in
            if let reviews = reviews {
                self?.objects.append(contentsOf: reviews)
                self?.tableView.reloadData()
                self?.isFetchInProgress = false
            }
        })
    }
}

extension MasterViewController : UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { indexPath in indexPath.row >= (objects.count - 1) }) {
            fetchReviews(objects.count)
        }
    }
}

