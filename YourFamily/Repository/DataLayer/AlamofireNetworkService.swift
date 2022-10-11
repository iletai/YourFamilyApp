//
//  AlarmofireNetworkServicec.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Alamofire
import Combine
import Foundation

class AlamofireNetworkService {
    private let sessionManager: Session

    init(with sessionManager: Session = Session.defaultSession()) {
        self.sessionManager = sessionManager
    }
}

extension AlamofireNetworkService: NetworkServiceProtocol {
    func makeRequest<T: Codable>(info: RequestInfo, params: T) -> AnyPublisher<
        Data, NetworkServiceError
    > {
        let httpMethod = getRequestMethod(info.httpMethod)
        let jsonEndcoder = JSONEncoder()
        jsonEndcoder.keyEncodingStrategy = .convertToSnakeCase
        var paramsEncoder: Alamofire.ParameterEncoder = JSONParameterEncoder(encoder: jsonEndcoder)
        if httpMethod == .get {
            paramsEncoder = Alamofire.URLEncodedFormParameterEncoder.default
        }

        let alamorfireHeaders = convertHeaderRequest(info.headers)

        let session = sessionManager.request(
            info.urlInfo,
            method: httpMethod,
            parameters: params,
            encoder: paramsEncoder,
            headers: alamorfireHeaders
        )
        .responseString { response in
            if let httpResponse = response.response {
                print(httpResponse)
            }
        }
        .validate(statusCode: 200..<300)
        .validate(contentType: [
            HTTPHeaderData.applicationJson.rawValue, HTTPHeaderData.textHTML.rawValue
        ])
        .publishData()
        .value()
        .mapError { afError -> NetworkServiceError in
            print(afError)
            return NetworkServiceError.noResponse
        }

        return session.eraseToAnyPublisher()
    }
}

extension AlamofireNetworkService {
    func getRequestMethod(_ method: RequestMethod) -> Alamofire.HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }

    func convertHeaderRequest(_ headers: HTTPHeader?) -> Alamofire.HTTPHeaders? {
        guard let headers = headers else {
            return nil
        }
        return Alamofire.HTTPHeaders(headers)
    }
}
