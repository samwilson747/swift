//
//  ProfileEdit.swift
//  PodsApp
//
//

import UIKit

class ProfileEdit: UIViewController {
    var profileData : User!
    var name : String? = ""
    var age : String? = ""
    var bio : String? = ""
    var image : String? = ""

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var bioField: UITextField!

    override func viewDidLoad()
    {
        profileImage.image = UIImage(named: profileData.image)
        profileImage.isHidden = false
        nameField.placeholder = profileData.name
        ageField.placeholder = profileData.age
        bioField.placeholder = profileData.bio
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationVC = segue.destination as? MainProfileView {
            if nameField.text != "" {
                destinationVC.user.name = nameField.text!
            }
            if ageField.text != "" {
                destinationVC.user.age = ageField.text!
            }
            if bioField.text != "" {
                destinationVC.user.bio = bioField.text!
            }
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
