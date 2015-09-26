//
//  ViewController.swift
//  popOverSearch
//
//  Created by Tim Even on 26-09-15.
//  Copyright © 2015 evenwerk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var toolbarConstraint: NSLayoutConstraint!
    var searchBar:UISearchBar!
    @IBOutlet weak var SearchPlaceholder: UIBarButtonItem!
    var searchResultsController = SearchResultsViewController()
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchBar" {
            let popoverViewController = segue.destinationViewController
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            performSegueWithIdentifier("SearchBar", sender: self)
            searchResultsController.searchForItemsWithString(searchText)
        }
        else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        if searchBar.text != "" {
            
            performSegueWithIdentifier("SearchBar", sender: self)
            searchResultsController.searchForItemsWithString(searchBar.text!)
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

