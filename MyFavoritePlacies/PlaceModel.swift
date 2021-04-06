//
//  PlaceModel.swift
//  MyFavoritePlacies
//
//  Created by Ilya Lezhnin on 25.03.2021.
//

import UIKit

 struct Places {
    
    var name : String
    var location : String?
    var type : String?
    var restorantImage : String?
    var image : UIImage?


static let restaurantNames = [
    "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
    "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
    "Speak Easy", "Morris Pub", "Вкусные истории",
    "Классик", "Love&Life", "Шок", "Бочка"
]

static func fillTheArray() -> [Places] {
    
    var places = [Places]()
    for place in restaurantNames {
        places.append(Places(name: place, location: "Томск", type: "Бар", restorantImage: place, image: nil))
    }
    
    return places
    }
}
