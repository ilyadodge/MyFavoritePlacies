//
//  MainTableViewController.swift
//  MyFavoritePlacies
//
//  Created by Ilya Lezhnin on 24.03.2021.
//

import UIKit
import RealmSwift


class MainTableViewController: UITableViewController {
    
    var places: Results<Place>!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.isEmpty ? 0 : places.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrentTableViewCell
        
        let place = places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
            
        
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        return cell
    }
    
    
    @IBAction func unwidSegue(_ segue:UIStoryboardSegue){
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.saveNewPlace()
        tableView.reloadData()
    }
    

}
