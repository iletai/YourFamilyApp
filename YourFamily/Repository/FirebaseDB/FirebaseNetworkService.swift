//
//  FirebaseNetworkService.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Alamofire
import Combine
import Foundation

class FirebaseNetworkService {
    internal let sessionManager: Session
    var cancellables = [AnyCancellable]()

    init(with sessionManager: Session = Session.defaultSession(.defaultsession)) {
        self.sessionManager = sessionManager
    }
}

extension FirebaseNetworkService: NetworkServiceProtocol {
    // TODO: - Handle Later
    func makeRequest<T: Codable>(info: RequestInfo, params: T) -> AnyPublisher<
        Data, NetworkServiceError
    > {
        guard let api = ServerConstant.FirebasePathAPI(rawValue: info.urlInfo.path) else {
            return Fail(error: NetworkServiceError.noResponse).eraseToAnyPublisher()
        }

        switch api {
        case .login:
            break
        default:
            break
        }
        return Fail(error: NetworkServiceError.noResponse).eraseToAnyPublisher()
    }
}
