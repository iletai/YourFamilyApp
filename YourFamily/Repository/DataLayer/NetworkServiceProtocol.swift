//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Combine
import Foundation

// swiftlint:disable missing_docs
public protocol NetworkServiceProtocol {
    func makeRequest<T: Codable>(info: RequestInfo, params: T) -> AnyPublisher<
        Data, NetworkServiceError
    >
}
