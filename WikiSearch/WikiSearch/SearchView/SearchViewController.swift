//
//  SearchViewController.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 01/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!

	var viewModel: SearchViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		viewModel = SearchViewModel.initViewModel()
	}

}

extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else {return}
		viewModel.search(text: searchText)
	}
}
