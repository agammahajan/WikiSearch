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
		viewModel.delegate = self
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let count = viewModel.fetchedhResultController.sections?.first?.numberOfObjects {
			return count
		}
		return 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
		if let page = viewModel.fetchedhResultController.object(at: indexPath) as? PageHistory {
			cell.populateData(data: page)
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		if let page = viewModel.fetchedhResultController.object(at: indexPath) as? PageHistory,
			let pageId = Int(exactly: page.pageId) {
			guard let detailVC = DetailWebViewController.initController(withPageId: pageId) else {return}
			self.navigationController?.pushViewController(detailVC, animated: true)
		}
	}
}

extension HistoryViewController: HistoryViewModelDelegate {

	func deleteRows(index: IndexPath) {
		self.tableView.deleteRows(at: [index], with: .automatic)
	}
	func insertRows(index: IndexPath) {
		self.tableView.insertRows(at: [index], with: .automatic)
	}
	func beginUpdates() {
		self.tableView.beginUpdates()
	}
	func endUpdates() {
		self.tableView.endUpdates()
	}
}
