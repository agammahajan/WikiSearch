//
//  DetailWebViewController.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 01/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class DetailWebViewController: UIViewController {
	@IBOutlet weak var webView: UIWebView!

	var pageId : Int!

	class func initController(withPageId pageId: Int?) -> DetailWebViewController? {
		guard let id = pageId else {return nil}
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let detailScreenVC = storyBoard.instantiateViewController(withIdentifier: "DetailWebViewController")  as? DetailWebViewController
		detailScreenVC?.pageId = id
		return detailScreenVC
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupData()
	}

	func setupData() {
		webView.delegate = self
		self.openLink()
	}

	func openLink() {
		let urlString = String(format: "https://en.m.wikipedia.org/?curid=%d", self.pageId)
		let url = URL(string: urlString)
		guard let requestURL = url else {return}
		var request = URLRequest(url: requestURL)
		request.cachePolicy = .returnCacheDataElseLoad
		webView.loadRequest(request)
	}

}

extension DetailWebViewController: UIWebViewDelegate {

	func webViewDidStartLoad(_ webView: UIWebView) {
		print("start1")
	}

	func webViewDidFinishLoad(_ webView: UIWebView) {
		print("end1")
	}
}
