//
//  ViewController.swift
//  Pods
//
//

import UIKit
import FirebaseDatabase

/* To Do */
// 1) move up screen to enter user/pass
// 2) be able to create new accounts
// 3) pass account data

class LogInView: UIViewController
{
    var accountsRef : DatabaseReference?
    @IBOutlet weak var owlsArt: UIImageView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var newUser : User?

    let usernameAlert = UIAlertController(title: "Unsuccessful Log In", message: "Username does not exist.", preferredStyle: .alert)
    let passwordAlert = UIAlertController(title: "Unsuccessful Log In", message: "Password is invalid.", preferredStyle: .alert)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        owlsArt.image = UIImage(named: "owls.png")
        owlsArt.isHidden = false
        usernameText.placeholder = "username"
        passwordText.placeholder = "password"

        accountsRef = Database.database().reference().child("Accounts")

        self.usernameAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.passwordAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
    }

    @IBAction func logInPressed(_ sender: Any)
    {
        var username : String?
        var password : String?
        var count : Int = 0

        var validName = false

        accountsRef?.observe(.value, with: {
            snapshot in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]
            {
                for account in snapshots
                {
                    count += 1
                    username = (account.childSnapshot(forPath: "LogInfo").childSnapshot(forPath: "username").value as! String)
                    password = (account.childSnapshot(forPath: "LogInfo").childSnapshot(forPath: "password").value as! String)
                    if (self.usernameText.text == username)
                    {
                        validName = true
                        if (self.passwordText.text == password)
                        {
                            self.performSegue(withIdentifier: "logSuccess", sender: nil)
                        }
                        else
                        {
                            self.present(self.passwordAlert, animated: true, completion: nil)
                        }
                    }
                }
                if (!validName)
                {
                    self.present(self.usernameAlert, animated: true, completion: nil)
                }
            }
        })
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func createNewAccount(segue: UIStoryboardSegue){
        //add new account to the data base
    }
    @IBAction func unwindToLogIn(segue: UIStoryboardSegue)
    {

    }

}
