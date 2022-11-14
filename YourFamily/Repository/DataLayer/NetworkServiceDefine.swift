//
//  NetworkServiceDefine.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Foundation

// swiftlint:disable missing_docs
public typealias HTTPHeader = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPHeaderType: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case apiVersion = "apiVersion"
}

public enum HTTPHeaderData: String {
    case applicationJson = "application/json"
    case textHTML = "text/html"
}

public enum APIError: Error {
    case encodeFailed
    case decodeFailed
    case apiError
    case apiNotFound
    case dataNotCorrect
    case dataIsEmpty
}

// swiftlint:disable missing_docs
public struct RequestInfo {
    let urlInfo: URL
    let httpMethod: RequestMethod
    let headers: HTTPHeader?

    init(urlInfo: URL, httpMethod: RequestMethod, headers: HTTPHeader? = nil) {
        self.urlInfo = urlInfo
        self.httpMethod = httpMethod
        self.headers = headers
    }
}

public enum NetworkServiceError: Error {
    case serverError
    case noResponse
}

enum NetworkServiceDefine {}
