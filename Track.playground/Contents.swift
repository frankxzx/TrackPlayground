//: Please build the scheme 'TrackPlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import UIKit
import Track
import CoreLocation


 class User: NSObject, NSCoding {
    
    var name: String
    var id: Int
    var location: CLLocationCoordinate2D
    
    init(name: String, id: Int, location: CLLocationCoordinate2D) {
        
        self.name = name
        self.id = id
        self.location = location
    }
    
     convenience required init?(coder aDecoder: NSCoder) {
        
      guard
            let name = aDecoder.decodeObjectForKey("name") as? String
            else { return nil }
        
        self.init(name: name,
                 id: aDecoder.decodeIntegerForKey("id"),
                 location : CLLocationCoordinate2D(latitude: aDecoder.decodeDoubleForKey("latitude"),
                                                   longitude: aDecoder.decodeDoubleForKey("longitude")))
    }

     func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger((self.id), forKey: "id")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeDouble(self.location.latitude, forKey: "latitude")
        aCoder.encodeDouble(self.location.longitude, forKey: "longitude")
    }
}

class Book: NSObject, NSCoding {
    var title: String
    var author: String
    var pageCount: Int
    var categories: [String]
    var available: Bool
    
    // Memberwise initializer
    init(title: String, author: String, pageCount: Int, categories: [String], available: Bool) {
        self.title = title
        self.author = author
        self.pageCount = pageCount
        self.categories = categories
        self.available = available
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObjectForKey("title") as? String,
            let author = decoder.decodeObjectForKey("author") as? String,
            let categories = decoder.decodeObjectForKey("categories") as? [String]
            else { return nil }
        
        self.init(
            title: title,
            author: author,
            pageCount: decoder.decodeIntegerForKey("pageCount"),
            categories: categories,
            available: decoder.decodeBoolForKey("available")
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeObject(self.author, forKey: "author")
        coder.encodeInt(Int32(self.pageCount), forKey: "pageCount")
        coder.encodeObject(self.categories, forKey: "categories")
        coder.encodeBool(self.available, forKey: "available")
    }
}

    let userCahe = Cache(name: "User")
    let user = User(name: "Frank", id: 100092348, location: CLLocationCoordinate2D(latitude: 110, longitude: 110))
    userCahe?.set(object: user, forKey: "curUser")
    let output =  userCahe?["curUser"] as? User
        output?.name

let cache = Cache(name: "Book")
let book = Book.init(title: "harry port", author: "JK. rollin", pageCount: 3000, categories: ["fiction"], available: true)
cache?["book"] = book




