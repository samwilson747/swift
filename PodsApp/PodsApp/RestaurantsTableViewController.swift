//
//  PlacesTableViewController.swift
//  PodsApp
//
//

import UIKit
import MapKit

class RestaurantsTableViewController: UITableViewController
{

    var mapRegion : MKCoordinateRegion?

    var restaurants = [MKMapItem]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "Nearby Restaurants"
        findNearbyRestaurants()
    }

    func findNearbyRestaurants()
    {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "restaurants"

        if let region = mapRegion
        {
            request.region = region
        }

        let search = MKLocalSearch(request: request)
        search.start(completionHandler:
            { localSearchResponse, error in

                if error == nil
                {
                    self.restaurants = (localSearchResponse?.mapItems)!

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
        return restaurants.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath)

        // Configure the cell...
        let restaurant = restaurants[indexPath.row]

        cell.textLabel?.text = restaurant.name
        let placemarkParts = String(describing:restaurant.placemark).components(separatedBy: ",")
        cell.detailTextLabel?.text = placemarkParts[1]

        return cell
    }

}
