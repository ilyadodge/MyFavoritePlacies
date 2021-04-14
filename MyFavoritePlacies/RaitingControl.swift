//
//  RaitingControl.swift
//  MyFavoritePlacies
//
//  Created by Ilya Lezhnin on 12.04.2021.
//

import UIKit

class RaitingControl: UIStackView {
    
    //MARK: Property
    
    private var raitingButtonArray = [UIButton]()
    var raiting = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
            }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
            }
    }
   //MARK: Initialnzation
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc func raitingButtonTapped(button: UIButton){
        guard let index = raitingButtonArray.firstIndex(of: button) else { return }
        
        //calculate the raiting of the selected button
        
        let selectedRaiting = index + 1
        if selectedRaiting == raiting {
            raiting = 0
        } else {
            raiting = selectedRaiting
        }
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        
        for button in raitingButtonArray {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        raitingButtonArray.removeAll()
        
        //load button image
        let bundle = Bundle(for: (type(of: self)))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
        
            //Create Buttons
            let button = UIButton()
            
            //setup button image
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
                
            //setup the button action
                
            button.addTarget(self, action: #selector(raitingButtonTapped(button:)), for: .touchUpInside)
                
            //ADD the button ti the stack
                
            addArrangedSubview(button)
            
            //add buttons in array buttons
            
            raitingButtonArray.append(button)
        }
        updateButtonSelectionState()
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in raitingButtonArray.enumerated() {
            if raiting > index {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}
