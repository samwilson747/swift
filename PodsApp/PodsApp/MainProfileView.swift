//
//  ProfileView.swift
//  PodsApp
//
//
import UIKit

class MainProfileView : UIViewController {
    var user = User(name: "Lilja", age: "19",bio: "California grown; love to cook and all things clean. Younger sibling at heart.", image: "profile.jpg")


    @IBOutlet weak var ageLabel: UILabel!

    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imageView.image = UIImage(named: (user.image))
        imageView.isHidden = false

        nameLabel.text = user.name
        ageLabel.text = user.age
        bioLabel.text = user.bio
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToMainProfile(segue: UIStoryboardSegue)
    {

    }
    @IBAction func saveChanges(_ segue: UIStoryboardSegue) {
        //let profileEditor = segue.source as! editProfile
        //self.user = profileEditor.newData!
        nameLabel.text = user.name
        ageLabel.text = user.age
        bioLabel.text = user.bio

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "profileEdit" {
            let destVC = segue.destination as! ProfileEdit
            destVC.profileData = user
        }
    }


}
