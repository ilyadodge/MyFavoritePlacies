//
//  PlaceModel.swift
//  MyFavoritePlacies
//
//  Created by Ilya Lezhnin on 25.03.2021.
//

import RealmSwift
import Foundation
import UIKit

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location : String?
    @objc dynamic var type : String?
    @objc dynamic var imageData : Data?

    convenience init(name: String, location: String?, type: String?, imageData: Data?){
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
    
}
