//
//

import Foundation
import MapKit
import FirebaseDatabase

class Home : NSObject, Codable, MKAnnotation
{
    var type : String?
    var address : String?
    var price : Int?
    var rooms : Int?
    var sqFt : Int?
    var latitude : Double?
    var longitude : Double?
    var image : String?
    var cityStateZip : String

    var coordinate: CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }

    var title: String?
    {
        return address
    }

    var subtitle: String?
    {
        return type
    }

    init(type: String, address: String, price: Int, rooms: Int, sqFt: Int, latitude: Double, longitude: Double, image: String, cityStateZip: String)
    {
        self.type = type
        self.address = address
        self.price = price
        self.rooms = rooms
        self.sqFt = sqFt
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.cityStateZip = cityStateZip
    }

    init(snapshot: DataSnapshot)
    {
        let snapvalues = snapshot.value as! [String : AnyObject]

        type = snapvalues["type"] as? String ?? "N/A"
        address = snapvalues["address"] as? String ?? "N/A"
        price = snapvalues["price"] as? Int ?? 0
        latitude = snapvalues["latitude"] as? Double ?? 0.0
        longitude = snapvalues["longitude"] as? Double ?? 0.0
        sqFt = snapvalues["sqFt"] as? Int ?? 0
        rooms = snapvalues["rooms"] as? Int ?? 0
        image = snapvalues["image"] as? String ?? "question.png"
        cityStateZip = snapvalues["cityStateZip"] as? String ?? "N/A"

        super.init()
    }

    init(key: String, snapshot: DataSnapshot)
    {
        let snaptemp = snapshot.value as! [String : AnyObject]
        let snapvalues = snaptemp[key] as! [String : AnyObject]

        type = snapvalues["type"] as? String ?? "N/A"
        address = snapvalues["address"] as? String ?? "N/A"
        price = snapvalues["price"] as? Int ?? 0
        latitude = snapvalues["latitude"] as? Double ?? 0.0
        longitude = snapvalues["longitude"] as? Double ?? 0.0
        sqFt = snapvalues["sqFt"] as? Int ?? 0
        rooms = snapvalues["rooms"] as? Int ?? 0
        image = snapvalues["image"] as? String ?? "question.png"
        cityStateZip = snapvalues["cityStateZip"] as? String ?? "N/A"

        super.init()
    }
}
