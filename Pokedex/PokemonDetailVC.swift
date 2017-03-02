//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Thomas Benali on 01/03/2017.
//  Copyright © 2017 Thomas Benali. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name

    }

}
