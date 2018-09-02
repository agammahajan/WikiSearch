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
		setupData()
	}

	func setupData() {
		viewModel = SearchViewModel.initViewModel()
		viewModel.delegate = self
		tableView.delegate = self
		tableView.dataSource = self
		let historyButton: UIBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(historyButtonTapped(sender:)))
		navigationItem.rightBarButtonItem = historyButton
	}

	@objc func historyButtonTapped(sender: AnyObject) {
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let historyVC = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController")  as! HistoryViewController
		self.navigationController?.pushViewController(historyVC, animated: true)
	}
}

extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text else {return}
		viewModel.search(text: searchText)
		self.view.endEditing(true)
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard let searchText = searchBar.text else {return}
		viewModel.search(text: searchText)
	}
}

extension SearchViewController: SearchViewModelDelegate {
	func dataFetched() {
		// reload tableView
		tableView.reloadData()
	}
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.dataSource.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
		cell.populateData(data: viewModel.dataSource[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		let page = self.viewModel.dataSource[indexPath.row]
		SearchedData.sharedInstance.saveInCoreDataWith(page: page)
		guard let detailVC = DetailWebViewController.initController(withPageId: page.pageId) else {return}
		self.navigationController?.pushViewController(detailVC, animated: true)
	}
}
