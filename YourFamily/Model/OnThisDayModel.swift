//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/12/22.
//

import Foundation

class OnThisDayModel: Identifiable {
    let id: String
    let title: String
    let location: String
    let time: Date
    var imageLink: String

    init(id: String, title: String, location: String, time: Date, imageLink: String) {
        self.id = id
        self.title = title
        self.location = location
        self.time = time
        self.imageLink = imageLink
    }

    static func empty() -> OnThisDayModel {
        return OnThisDayModel(id: String.empty, title: .empty, location: .empty, time: Date(), imageLink: .empty)
    }
}
