//
//  BarsTableViewController.swift
//  PodsApp
//
//

import UIKit
import MapKit

class BarsTableViewController: UITableViewController
{

    var mapRegion : MKCoordinateRegion?

    var bars = [MKMapItem]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let restVC = self.tabBarController?.viewControllers![1] as! BarsTableViewController
        restVC.mapRegion = self.mapRegion

        navigationItem.title = "Nearby Bars"
        findNearbyBars()
    }

    func findNearbyBars()
    {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "bars"
        if let region = mapRegion
        {
            request.region = region
        }

        let search = MKLocalSearch(request: request)
        search.start(completionHandler:
            { localSearchResponse, error in

                if error == nil
                {
                    self.bars = (localSearchResponse?.mapItems)!

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
        return bars.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "barCell", for: indexPath)

        // Configure the cell...
        let bar = bars[indexPath.row]

        cell.textLabel?.text = bar.name
        let placemarkParts = String(describing:bar.placemark).components(separatedBy: ",")
        cell.detailTextLabel?.text = placemarkParts[1]

        return cell
    }

}
