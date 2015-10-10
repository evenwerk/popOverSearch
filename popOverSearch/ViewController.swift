//
//  ViewController.swift
//  popOverSearch
//
//  Created by Tim Even on 26-09-15.
//  Copyright © 2015 evenwerk. All rights reserved.
//

import UIKit

protocol SearchResultsDelegate {
    func searchForItemsWithString(searchQuery:String)
}

class ViewController: UIViewController, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var toolbarConstraint: NSLayoutConstraint!
    var searchBar:UISearchBar!
    @IBOutlet weak var SearchPlaceholder: UIBarButtonItem!
    var searchResultsController = SearchResultsViewController()
    var popover:UIPopoverPresentationController!
    
    var searchDelegate:SearchResultsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create the searchbar
        searchBar = UISearchBar(frame: CGRectMake(0, 0, 230, 44))
        searchBar.tintColor = UIColor(red:0, green:0, blue:0, alpha:1)
        searchBar.delegate = self
        SearchPlaceholder.customView = searchBar
        
        //add the keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //keyboard notifications
    func keyboardWillShow(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }
    
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
        let animationCurve = UIViewAnimationOptions.init(rawValue: UInt(rawAnimationCurve))
        
        toolbarConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState.union(animationCurve), animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    //Searchbar delegate
    
    func createPopover() {
        if popover == nil {
            let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchResults") as! UINavigationController
            navigationController.modalPresentationStyle = .Popover
            popover = navigationController.popoverPresentationController
            navigationController.preferredContentSize = CGSizeMake(320.0, 480.0)
            popover.delegate = self
            popover.sourceView = searchBar
            popover.sourceRect = CGRectMake(0, 6, searchBar.bounds.width, searchBar.bounds.height)
            popover.passthroughViews = [searchBar]
            
            self.presentViewController(navigationController, animated: true, completion: nil)
            
            searchResultsController = navigationController.topViewController as! SearchResultsViewController
            searchDelegate = searchResultsController
        }
    }
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        self.view.endEditing(true)
        popover = nil
        return true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            createPopover()
            searchDelegate?.searchForItemsWithString(searchText)
        }
        else {
            self.dismissViewControllerAnimated(true, completion: nil)
            popover = nil
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        if searchBar.text != "" {
            createPopover()
            searchDelegate?.searchForItemsWithString(searchBar.text!)
        }
        
        return true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

