//
//  OnThisDateMapper.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/13/22.
//

import Foundation
import Firebase

final class OnThisDateMapper {
    // swiftlint:disable force_cast
    static func mapMemoryToFirebase(_ memory: OnThisDayModel) -> [String: Any] {
        return NSDictionary(
            objects: [
                memory.id,
                memory.title,
                memory.imageLink,
                memory.location,
                memory.time
            ],
            forKeys: [
                ServerConstant.Param.memoryId as NSCopying,
                ServerConstant.Param.memoryTitle as NSCopying,
                ServerConstant.Param.memoryImageLink as NSCopying,
                ServerConstant.Param.memoryLocation as NSCopying,
                ServerConstant.Param.memoryTime as NSCopying
            ]) as! [String: Any]
    }
}
