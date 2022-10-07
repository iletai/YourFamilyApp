//
//  NetworkService.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Combine
import Foundation

struct NetworkService {
    public enum NetworkServiceType {
        case Alamofire
        case URLSession
    }

    private let pNetworkService: NetworkServiceProtocol

    init(_ pNetworkService: NetworkServiceProtocol = AlamofireNetworkService()) {
        if pNetworkService.self is FirebaseNetworkService {
            self.pNetworkService = FirebaseNetworkService()
        } else if pNetworkService.self is AlamofireNetworkService {
            self.pNetworkService = AlamofireNetworkService()
        } else {
            self.pNetworkService = AlamofireNetworkService()
        }
    }
}

extension NetworkService: NetworkServiceProtocol {
    func makeRequest<T: Codable>(info: RequestInfo, params: T) -> AnyPublisher<Data, NetworkServiceError> {
        return pNetworkService.makeRequest(info: info, params: params)
    }

}
