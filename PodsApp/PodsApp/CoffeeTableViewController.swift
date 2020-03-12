//
//  CoffeeTableViewController.swift
//  PodsApp
//
//

import UIKit
import MapKit

class CoffeeTableViewController: UITableViewController
{

    var mapRegion : MKCoordinateRegion?

    var coffee = [MKMapItem]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let restVC = self.tabBarController?.viewControllers![2] as! CoffeeTableViewController
        restVC.mapRegion = self.mapRegion

        navigationItem.title = "Nearby Coffee Shops"
        findNearbyCoffee()
    }

    func findNearbyCoffee()
    {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "coffee"
        if let region = mapRegion
        {
            request.region = region
        }

        let search = MKLocalSearch(request: request)
        search.start(completionHandler:
            { localSearchResponse, error in

                if error == nil
                {
                    self.coffee = (localSearchResponse?.mapItems)!

                    DispatchQueue.main.async
                        {
                            self.tableView.reloadData()
                    }
                }
        })
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return coffee.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell", for: indexPath)

        // Configure the cell...
        let coffeeShop = coffee[indexPath.row]

        cell.textLabel?.text = coffeeShop.name
        let placemarkParts = String(describing:coffeeShop.placemark).components(separatedBy: ",")
        cell.detailTextLabel?.text = placemarkParts[1]

        return cell
    }

}
