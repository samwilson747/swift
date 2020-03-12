//
//  SearchHomeViewController.swift
//  PodsApp
//
//

import UIKit
import Firebase
import GeoFire

class SearchHomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!

    var searchRef : DatabaseReference?
    var accountRef : DatabaseReference?
    var geoFire : GeoFire?
    var regionQuery : GFRegionQuery?
    var searchHomes = [Home]()

    let center = CLLocationCoordinate2D(latitude: 35.2945, longitude: -120.5451)

    override func viewDidLoad()
    {
        var count = 0

        super.viewDidLoad()

        centerMap(at: center, withZoom: 0.55)

        searchRef = Database.database().reference().child("Homes")
        geoFire = GeoFire(firebaseRef: Database.database().reference().child("GeoFire"))

        searchRef?.observe(.childAdded, with:
        {
            (snapshot) in

            count = count + 1
            let newHome = Home(snapshot: snapshot)
            self.searchHomes.append(newHome)
            self.geoFire?.setLocation(CLLocation(latitude:newHome.latitude!,longitude:newHome.longitude!), forKey: "Home" + String(count))
        })
    }

    func centerMap(at newCenter: CLLocationCoordinate2D, withZoom zoom: Double = 0.1)
    {

        let span = MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
        let newRegion = MKCoordinateRegion(center: newCenter, span: span)
        mapView.setRegion(newRegion, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool)
    {
        mapView.removeAnnotations(mapView.annotations)

        updateRegionQuery()
    }

    func updateRegionQuery()
    {
        if let oldQuery = regionQuery
        {
            oldQuery.removeAllObservers()
        }

        regionQuery = geoFire?.query(with: mapView.region)

        regionQuery?.observe(.keyEntered, with:
            {
                (key, location) in
                self.searchRef?.queryOrderedByKey().queryEqual(toValue: key).observe(.value, with:
                    {
                        snapshot in

                        let newHome = Home(key: key, snapshot: snapshot)
                        self.addHome(newHome)
                })
        })
    }

    func addHome(_ home : Home)
    {
        DispatchQueue.main.async
        {
                self.mapView.addAnnotation(home)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {

        if annotation is Home
        {
            let annotationView = MKPinAnnotationView()
            annotationView.pinTintColor = .red
            annotationView.annotation = annotation
            annotationView.canShowCallout = true
            annotationView.animatesDrop = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn

            return annotationView
        }

        return nil
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        performSegue(withIdentifier: "searchHome", sender: view.annotation!)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // add conditional
        if segue.identifier == "searchHome"
        {
            if let selectedHome = sender as? Home
            {
                let destVC = segue.destination as! HomeDetailViewController

                destVC.home = selectedHome
                destVC.mapRegion = mapView.region
                destVC.accountRef = self.accountRef

            }
        }
    }

    @IBAction func unwindToMap(segue: UIStoryboardSegue)
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
