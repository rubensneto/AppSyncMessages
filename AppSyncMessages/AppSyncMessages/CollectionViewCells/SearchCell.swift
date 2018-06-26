//
//  SearchCell.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class SearchCell: T101Cell {
    let conversationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        searchBar.setBarTextField(color: .reconDarkBackground)
        searchBar.setBarTextField(cornerRadius: 18)
        searchBar.setBarTextField(textColor: .white)
        return searchBar
    }()
    
    override func setupCellView() {
        addSubview(conversationSearchBar)
        addConstraintsWith(format: "H:|-2-[v0]-2-|", views: conversationSearchBar)
        addConstraintsWith(format: "V:|-10-[v0(36)]-10-|", views: conversationSearchBar)
    }
}
