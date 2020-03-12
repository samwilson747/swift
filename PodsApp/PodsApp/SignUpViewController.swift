//
//  SignUpViewController.swift
//  PodsApp
//
//

import UIKit
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate
{
    var accountRef : DatabaseReference?

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!

    let usernameAlert = UIAlertController(title: "Unsuccessful Sign Up", message: "Please enter a username.", preferredStyle: .alert)
    let passwordAlert = UIAlertController(title: "Unsuccessful Sign Up", message: "Please enter a password.", preferredStyle: .alert)
    let usedAlert = UIAlertController(title: "Unsuccessful Sign Up", message: "This username is already in use.", preferredStyle: .alert)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        accountRef = Database.database().reference().child("Accounts")

        NotificationCenter.default.addObserver(self, selector: #selector(LogInView.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInView.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        self.usernameAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.passwordAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.usedAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func signUp(_ sender: Any)
    {
        var existingName : String?
        var count = 1
        var accountDict : NSDictionary?
        var logInfoDict : NSDictionary?

        if ((usernameText.text) == "")
        {
            self.present(self.usernameAlert, animated: true, completion: nil)
            return
        }
        else if ((passwordText.text) == "")
        {
            self.present(self.passwordAlert, animated: true, completion: nil)
            return
        }
        else
        {
            accountRef?.observeSingleEvent(of: .value, with:
            {
                (snapshot) in

                count = Int(snapshot.childrenCount) + 1
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot]
                {
                    for account in snapshots
                    {
                        accountDict = account.value as? NSDictionary
                        logInfoDict = (accountDict!["LogInfo"] as! NSDictionary)
                        existingName = (logInfoDict?["username"] as! String)

                        if (self.usernameText.text! == existingName)
                        {
                            self.present(self.usedAlert, animated: true, completion: nil)
                            return
                        }
                    }
                    let key = "Account" + String(count)
                    self.accountRef = self.accountRef?.child(key)
                    self.accountRef?.child("LogInfo").child("username").setValue(self.usernameText.text)
                    self.accountRef?.child("LogInfo").child("password").setValue(self.passwordText.text)
                    self.performSegue(withIdentifier: "signUpSuccess", sender: nil)
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // add conditional
        if segue.identifier == "signUpSuccess"
        {
            let destVC = segue.destination as! NewMember
            destVC.accountRef = self.accountRef
        }
    }

    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            if self.view.frame.origin.y == 0
            {
                self.view.frame.origin.y -= keyboardSize.height - 50
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            if self.view.frame.origin.y != 0
            {
                self.view.frame.origin.y += keyboardSize.height - 50
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
