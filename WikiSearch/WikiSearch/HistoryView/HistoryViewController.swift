//
//  HistoryViewController.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 02/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UITableViewController {

	var viewModel: HistoryViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		setupData()
	}

	func setupData() {
		viewModel = HistoryViewModel.initViewModel()
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.dataSource.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
		cell.populateData(data: viewModel.dataSource[indexPath.row])
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		guard let detailVC = DetailWebViewController.initController(withPageId: self.viewModel.dataSource[indexPath.row].pageId) else {return}
		self.navigationController?.pushViewController(detailVC, animated: true)
	}
}
