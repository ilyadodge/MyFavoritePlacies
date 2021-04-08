//
//  NewPlaceTableViewController.swift
//  MyFavoritePlacies
//
//  Created by Ilya Lezhnin on 05.04.2021.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
    var currentPlace: Place?
    var imageChaged = false
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeNameTextFields: UITextField!
    @IBOutlet weak var placeLacationTextFields: UITextField!
    @IBOutlet weak var placeTypeTextFields: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        placeNameTextFields.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
        
    }
    
    //MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")
        
        if indexPath.row == 0 {
            let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) {_ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            //camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAligment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) {_ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            //photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAligment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertSheet.addAction(camera)
            alertSheet.addAction(photo)
            alertSheet.addAction(cancel)
            
            present(alertSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func savePlace(){
        
       
        var image: UIImage?
        
        if imageChaged == true {
           image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        
        let imageData = image?.pngData()
        let newPlace = Place(name: placeNameTextFields.text!, location: placeLacationTextFields.text, type: placeTypeTextFields.text, imageData: imageData)
        if currentPlace != nil {
            currentPlace?.imageData = newPlace.imageData
            currentPlace?.location = newPlace.location
            currentPlace?.type = newPlace.type
            currentPlace?.name = newPlace.name
        } else {
            StorageManager.saveObject(newPlace)
        }
    }
    
    private func setupEditScreen() {
        
        if currentPlace != nil {
            setupNavigationBar()
            imageChaged = true
            guard let data = currentPlace?.imageData, let image = UIImage(data: data)  else { return }
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
            placeNameTextFields.text = currentPlace?.name
            placeLacationTextFields.text = currentPlace?.location
            placeTypeTextFields.text = currentPlace?.type
        }
    }
    
    private func setupNavigationBar() {
        let topItem = navigationController?.navigationBar.topItem
        topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}

//MARK: UITextFieldDelegate

extension NewPlaceTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if placeNameTextFields.text?.isEmpty == false {
            saveButton.isEnabled = true
        }else {
            saveButton.isEnabled = false
        }
    }
    
    
}

//MARK: Work with image

extension NewPlaceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker (source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        imageChaged = true
        dismiss(animated: true)
    }
}
