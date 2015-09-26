//
//  SearchResultsViewController.swift
//  popOverSearch
//
//  Created by Tim Even on 26-09-15.
//  Copyright © 2015 evenwerk. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {

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
        
        if contentArray.count != 0 {
            tableView.hidden = false
            noItemsLabel.hidden = true

        }
        else {
            tableView.hidden = true
            noItemsLabel.hidden = false
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
