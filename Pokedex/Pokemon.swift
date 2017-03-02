//
//  Pokemon.swift
//  Pokedex
//
//  Created by Thomas Benali on 28/02/2017.
//  Copyright © 2017 Thomas Benali. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _localLang: Int!
    private var _name: String!
    private var _pokedexID: Int!
    
    var localLang: Int {
        return _localLang
    }
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(pokedexID: Int, localLang: Int, name: String) {
        self._localLang = localLang
        self._name = name
        self._pokedexID = pokedexID
        
    }
}
