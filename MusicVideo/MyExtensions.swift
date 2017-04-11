//
//  MyExtensions.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 11/4/17.
//  Copyright © 2017 Rex Jason Alobba. All rights reserved.
//

import UIKit

extension MusicVideoTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.text!.lowercased()
        filterSearch(searchText: searchController.searchBar.text!)
    }
}
