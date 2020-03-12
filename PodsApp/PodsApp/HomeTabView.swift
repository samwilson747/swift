//
//  HomeTabView.swift
//  Pods
//
//  Created by Abe Mowad on 5/17/18.
//  Copyright © 2018 Abe Mowad. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeTabView : UIViewController
{
    var accountRef : DatabaseReference?
    
    @IBOutlet weak var savedHomesSeg: UIView!
    @IBOutlet weak var searchHomesSeg: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // add conditional
        if segue.identifier == "searchingHomes"
        {
            let destVC = segue.destination as! SearchHomeViewController
            destVC.accountRef = self.accountRef
        }
        else if segue.identifier == "savedHomesPods"
        {
            let destVC = segue.destination as! SavedHomePodsTableViewController
            destVC.accountRef = self.accountRef
        }
    }
    
    @IBAction func showComponent(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            UIView.animate(withDuration: 0.5, animations:
            {
                self.savedHomesSeg.alpha = 1
                self.searchHomesSeg.alpha = 0
            })
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations:
            {
                self.savedHomesSeg.alpha = 0
                self.searchHomesSeg.alpha = 1
            })
        }
    }
}
