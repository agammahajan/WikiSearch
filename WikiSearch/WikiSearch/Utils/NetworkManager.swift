//
//  NetworkManager.swift
//  WikiSearch
//
//  Created by Agam Mahajan on 01/09/18.
//  Copyright © 2018 Agam Mahajan. All rights reserved.
//

import Foundation

enum RequestType: String {
	case get = "GET"
	case post = "POST"
	case delete = "DELETE"
}

class NetworkManager {

	static let sharedInstance: NetworkManager = NetworkManager()

	func getDefaultHttpHeaders() -> Dictionary<String, String> {
		var defaultHeaders: [String: String] = [:]
		defaultHeaders["Content-Type"] = "application/json"
		defaultHeaders["Accept"] = "application/json"

		return defaultHeaders
	}

	@discardableResult
	func get(urlString: String, params: [String: String]? = nil, headers: [String: String]? = nil, body: [String: Any]? = nil, success: ((HTTPURLResponse, Dictionary<AnyHashable, Any>?)->Void)? = nil, failure:((HTTPURLResponse?, Dictionary<AnyHashable, Any>?, Error?)->Void)? = nil) -> URLSessionTask? {
		return request(urlString: urlString, requestType: .get, params: params, headers: headers, body: body, success: success, failure: failure)
	}

	@discardableResult
	func post(urlString: String, params: [String: String]? = nil, headers: [String: String]? = nil, body: [String: Any]? = nil, success: ((HTTPURLResponse, Dictionary<AnyHashable, Any>?)->Void)? = nil, failure:((HTTPURLResponse?, Dictionary<AnyHashable, Any>?, Error?)->Void)? = nil) -> URLSessionTask? {
		return request(urlString: urlString, requestType: .post, params: params, headers: headers, body: body, success: success, failure: failure)
	}

	@discardableResult
	func delete(urlString: String, params: [String: String]? = nil, headers: [String: String]? = nil, body: [String: Any]? = nil, success: ((HTTPURLResponse, Dictionary<AnyHashable, Any>?)->Void)? = nil, failure:((HTTPURLResponse?, Dictionary<AnyHashable, Any>?, Error?)->Void)? = nil) -> URLSessionTask? {
		return request(urlString: urlString, requestType: .delete, params: params, headers: headers, body: body, success: success, failure: failure)
	}

	private func request(urlString: String, requestType: RequestType, params: [String: String]? = nil, headers: [String: String]? = nil, body: [String: Any]? = nil, success: ((HTTPURLResponse, Dictionary<AnyHashable, Any>?)->Void)? = nil, failure:((HTTPURLResponse?, Dictionary<AnyHashable, Any>?, Error?)->Void)? = nil) -> URLSessionTask? {
		let requestUrl = urlString

		guard let url = URL(string: requestUrl) else {
			if let failureBlock = failure {
				// TODO: indicate url creation failure
				DispatchQueue.main.async {
					failureBlock(nil, nil, nil)
				}

			}
			return nil
		}

		let session = URLSession.shared
		var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
		request.httpMethod = requestType.rawValue

		// Headers
		var httpHeaders: Dictionary<String, String>
		if let headersSent = headers {
			httpHeaders = headersSent
		} else {
			httpHeaders = getDefaultHttpHeaders()
		}
		request.allHTTPHeaderFields = httpHeaders

		// Body
		if let httpBody: [String:Any] = body {
			var bodyData: Data?
			do {
				bodyData = try JSONSerialization.data(withJSONObject: httpBody, options: JSONSerialization.WritingOptions.prettyPrinted)
			} catch {
				print("Error creating http body")
			}
			request.httpBody = bodyData
		}

		let task = session.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async {
				guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
					if let failureBlock = failure {
						failureBlock(nil, nil, nil)
					}
					return
				}
				var dict: [AnyHashable: Any] = [:]
				do {
					dict = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable: Any]
				} catch {
					print("Error parsing data")
				}

				if let successBlock = success, httpResponse.statusCode == 200 {
					// Success
					successBlock(httpResponse, dict)
				} else {
					if let failureBlock = failure {
						failureBlock(httpResponse, dict, error)
					}
				}
			}
		}
		task.resume()
		return task
	}
}
