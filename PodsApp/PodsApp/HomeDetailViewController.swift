//
//  HomeDetailViewController.swift
//  PodsApp
//
//

import UIKit
import MapKit

class HomeDetailViewController: UIViewController
{
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!

    var home : Home?
    var mapRegion : MKCoordinateRegion?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        typeLabel.text = home!.type
        addressLabel.text = (home?.address)! + " - " + (home?.cityStateZip)!
        priceLabel.text = "$" + String(home!.price!) + " monthly"
        sizeLabel.text = String(home!.rooms!) + " rooms, " + String(home!.sqFt!) + " sq. ft"

        if (home!.image! == "question.png")
        {
            homeImage.image = UIImage(named: (home!.image!))
        }
        else
        {
            DispatchQueue.global(qos: .userInitiated).async
                {
                    let url = URL(string: self.home!.image!)
                    let responseData = try? Data(contentsOf: url!)
                    let downloadedImage = UIImage(data: responseData!)

                    DispatchQueue.main.async
                        {
                            self.homeImage.image = downloadedImage
                    }
            }
            self.homeImage.isHidden = false
        }
        homeImage.isHidden = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // add conditional
        if segue.identifier == "showPlaces"
        {
            let destVC = segue.destination as! PlacesTabBarController
            destVC.mapRegion = self.mapRegion
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveHome(_ sender: UIButton)
    {

    }

    @IBAction func unwindToDetail(segue: UIStoryboardSegue)
    {

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
