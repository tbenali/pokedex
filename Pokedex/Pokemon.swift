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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
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
