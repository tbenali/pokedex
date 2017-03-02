//
//  ViewController.swift
//  Pokedex
//
//  Created by Thomas Benali on 28/02/2017.
//  Copyright © 2017 Thomas Benali. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK: - Vars
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var languageButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var languages = [Language]()
    var pokemon = [Pokemon]()
    var AllPokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    var language = "en"
    var langID = 9

    //MARK: - Init Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageButton.setTitle("English", for: .normal)
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.showsCancelButton = false
        
        parseLanguageCSV()
        langID = getLanguageID(currentLanguage: language)
        
        parsePokemonCSV()
        pokemon = AllPokemon
        pokemon = filterByLanguage(pokemons: AllPokemon, currentLanguage: langID)
        initAudio()
        
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.pause()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //MARK: - Parsing

    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon_species_names", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let localLang = Int(row["local_language_id"]!)!
                let pokeID = Int(row["pokemon_species_id"]!)!
                let name = row["name"]!
                
                let poke = Pokemon(pokedexID: pokeID, localLang: localLang, name: name)
                
                AllPokemon.append(poke)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parseLanguageCSV() {
        let path = Bundle.main.path(forResource: "languages", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let lang = Language(id: id, name: name)
                
                languages.append(lang)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //MARK: - Language Funcs
    
    func getLanguageID(currentLanguage: String) -> Int {
        var usedLanguageID = 0
        
        for lang in languages {
            if currentLanguage == lang.name {
                usedLanguageID = lang.id
            }
        }
        
        return usedLanguageID
    }
    
    func filterByLanguage(pokemons: [Pokemon], currentLanguage: Int) -> [Pokemon]{
        
        var pokemonsFiltered = [Pokemon]()
        
        for poke in pokemons {
            if poke.localLang == currentLanguage {
                pokemonsFiltered.append(poke)
            }
        }
        
        return pokemonsFiltered
    }
    
    //MARK: - Collection

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    //MARK: - Buttons
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    @IBAction func languageButtonPressed(_ sender: UIButton) {
        
        pokemon = filterByLanguage(pokemons: AllPokemon, currentLanguage: langID)
        
        if language == "en" {
            languageButton.setTitle("Français", for: .normal)
            language = "fr"
            langID = 5
        } else {
            languageButton.setTitle("English", for: .normal)
            language = "en"
            langID = 9
        }
        
        collection.reloadData()
    }
    
    //MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "") {
            view.endEditing(true)
            inSearchMode = false
            searchBar.showsCancelButton = false
            collection.reloadData()
            
        } else {
            inSearchMode = true
            searchBar.showsCancelButton = true
            let lower = searchBar.text!
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        inSearchMode = false
        view.endEditing(true)
        searchBar.showsCancelButton = false
        collection.reloadData()
    }
    
    
    //MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
}

