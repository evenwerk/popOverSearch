//
//  SearchResultsViewController.swift
//  popOverSearch
//
//  Created by Tim Even on 26-09-15.
//  Copyright © 2015 evenwerk. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, SearchResultsDelegate {

    let contentArray = ["lorem", "ipsum", "dolor", "sit", "amet"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noItemsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchForItemsWithString(searchQuery:String) {
        
//        if contentArray.count != 0 {
//            tableView.hidden = false
//            noItemsLabel.hidden = true
//
//        }
//        else {
//            tableView.hidden = true
//            noItemsLabel.hidden = false
//        }
        
    }

}
