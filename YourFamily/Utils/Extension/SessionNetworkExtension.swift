//
//  SessionNetworkExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/7/22.
//

import Alamofire
import Foundation

extension Session {
    enum SessionType {
        case alamofire
        case defaultsession
    }

    static func defaultSession(_ sessionType: SessionType = .alamofire) -> Session {
        var config = URLSessionConfiguration.default
        switch sessionType {
        case .alamofire:
            config = URLSessionConfiguration.af.default
        case .defaultsession:
            config = URLSessionConfiguration.default
        }
        config.timeoutIntervalForRequest = 60

        let session = Session(configuration: config)
        return session
    }
}

enum SessionNetworkExtension {}
