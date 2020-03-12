//
//  PodDetails.swift
//
//
//

import UIKit

class PodDetails: UIViewController {
    var dataFromTable : Pod!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mottoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = dataFromTable?.name
        locationLabel.text = dataFromTable?.location
        mottoLabel.text = dataFromTable?.motto
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
