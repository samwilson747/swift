//
//  PodCreate.swift
//  PodsApp
//
//

import UIKit

class PodCreate: UIViewController {
    var newPod : Pod?
    var Members : [User] = []

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var imageLabel: UITextField!
    @IBOutlet weak var mottoLabel: UITextField!

    var name = "John Doe"
    var location = "Denver, CO"
    var image = "person.jpg"
    var motto = "Work Hard, Play Hard"

    override func viewDidLoad() {
        nameField.placeholder = name
        locationField.placeholder = location
        imageLabel.placeholder = image
        mottoLabel.placeholder = motto
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(nameField.text != "") {
            name = nameField.text!
        }
        if(locationField.text != "") {
            location = locationField.text!
        }
        if(imageLabel.text != "") {
            image = imageLabel.text!
        }
        if(mottoLabel.text != "") {
            motto = mottoLabel.text!
        }
        self.newPod = Pod(name: name,location: location, members: Members, image: image, motto: motto)
    }


}
