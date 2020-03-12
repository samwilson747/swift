//
//  NewMember.swift
//  PodsApp
//
//

import UIKit
import FirebaseDatabase

class NewMember: UIViewController {

    var accountRef : DatabaseReference?

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var imageLabel: UIImageView!

    override func viewDidLoad() {
        imageLabel.image = UIImage(named: "question.png")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destVC = segue.destination as? LogInView {
            //destVC.newUser = init(user)
            //add firebase account creation
            if nameField.text != "" {
            }
            if ageField.text != "" {
            }
            if bioField.text != "" {
            }
        }

    }
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
