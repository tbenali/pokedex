//
//  Pokemon.swift
//  Pokedex
//
//  Created by Thomas Benali on 28/02/2017.
//  Copyright © 2017 Thomas Benali. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String {
        
        return _name
    }
    
    var pokedexID: Int {
        
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
    }
}
