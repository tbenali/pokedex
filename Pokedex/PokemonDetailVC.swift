//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Thomas Benali on 01/03/2017.
//  Copyright © 2017 Thomas Benali. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    //MARK: - Vars
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UIStackView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name

    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
