//
//  FUserMapper.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/10/22.
//

import Foundation
import Firebase

final class FUserMapper {
    // swiftlint:disable force_cast
    static func mapUserToFireStorage(_ fUser: FUser) -> [String: Any] {
        return NSDictionary(
            objects: [
                fUser.id,
                fUser.emailAdress,
                fUser.phoneNumber,
                fUser.onBoarding,
                fUser.avatarImage,
                fUser.bithday,
                fUser.nickname
            ],
            forKeys: [
                ServerConstant.Param.currentUser as NSCopying,
                ServerConstant.Param.email as NSCopying,
                ServerConstant.Param.phoneNumber as NSCopying,
                ServerConstant.Param.onBoard as NSCopying,
                ServerConstant.Param.avatarImage as NSCopying,
                ServerConstant.Param.birthday as NSCopying,
                ServerConstant.Param.nickname as NSCopying
            ]) as! [String: Any]
    }
}
