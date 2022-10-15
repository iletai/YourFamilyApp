//
//  OnThisDateMapper.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/13/22.
//

import Firebase
import Foundation

final class OnThisDateMapper {
    // swiftlint:disable force_cast
    static func mapMemoryToFirebase(_ memory: OnThisDayModel) -> [String: Any] {
        return NSDictionary(
            objects: [
                memory.id,
                memory.title,
                memory.imageLink,
                memory.location,
                memory.time,
            ],
            forKeys: [
                ServerConstant.Param.memoryId as NSCopying,
                ServerConstant.Param.memoryTitle as NSCopying,
                ServerConstant.Param.memoryImageLink as NSCopying,
                ServerConstant.Param.memoryLocation as NSCopying,
                ServerConstant.Param.memoryTime as NSCopying,
            ]) as! [String: Any]
    }

    static func onThisDateFromDictionary(_ snapShot: QuerySnapshot) -> [OnThisDayModel] {
        var memorys: [OnThisDayModel] = []
        for snapShot in snapShot.documents {
            if let timeStamp = snapShot[ServerConstant.Param.memoryTime] as? Timestamp? {
                memorys.append(
                    OnThisDayModel(
                        id: snapShot[ServerConstant.Param.memoryId] as? String ?? UUID().uuidString,
                        title: snapShot[ServerConstant.Param.memoryTitle] as? String ?? .empty,
                        location: snapShot[ServerConstant.Param.memoryLocation] as? String ?? .empty,
                        time: timeStamp?.dateValue() as? Date ?? Date(),
                        imageLink: snapShot[ServerConstant.Param.memoryImageLink] as? String ?? .empty
                    )
                )
            }
        }
        return memorys
    }
}
