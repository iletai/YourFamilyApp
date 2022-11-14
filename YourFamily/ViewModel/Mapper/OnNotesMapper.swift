//
//  OnNotesMapper.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/25/22.
//

import Firebase
import Foundation

final class OnNotesMapper {
    // swiftlint:disable force_cast
    // swiftlint:disable legacy_objc_type
    static func mapNotesToFirebase(_ note: CashInModel) -> [String: Any] {
        return NSDictionary(
            objects: [
                FUser.currentId(),
                note.title,
                note.isCashIn,
                note.cost,
                note.dayInWeek,
            ],
            forKeys: [
                ServerConstant.Param.noteId as NSCopying,
                ServerConstant.Param.noteTitle as NSCopying,
                ServerConstant.Param.noteCashIn as NSCopying,
                ServerConstant.Param.noteCost as NSCopying,
                ServerConstant.Param.noteDate as NSCopying,
            ]
        ) as! [String: Any]
    }

    static func onNoteFromDictionary(_ snapShot: QuerySnapshot) -> [CashInModel] {
        var notes: [CashInModel] = []
        for snapShot in snapShot.documents {
            if let timeStamp = snapShot[ServerConstant.Param.noteDate] as? Timestamp? {
                notes.append(
                    CashInModel(
                        id: snapShot[ServerConstant.Param.noteId] as? String ?? UUID().uuidString,
                        cost: snapShot[ServerConstant.Param.noteCost] as? Double ?? .zero,
                        isCashIn: snapShot[ServerConstant.Param.noteCashIn] as? Bool ?? false,
                        title: snapShot[ServerConstant.Param.noteTitle] as? String ?? .empty,
                        dayInWeek: timeStamp?.dateValue() as? Date ?? Date()
                    )
                )
            }
        }
        return notes
    }
}
