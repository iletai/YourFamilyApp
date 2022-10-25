//
//  File.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/17/22.
//

import Foundation

final class YourNoteViewModel: ObservableObject {
    @Published var dataInput: [CashInModel] = []
    @Published var noteInform = NoteInform(message: .empty, title: .empty)
    @Published var isShowToast = false
    @Published var isShowActionSheet = false

    init() {
        fetchNoteFromFirebase()
    }
}

// MARK: - Enum
extension YourNoteViewModel {

}

// MARK: - Struct
extension YourNoteViewModel {
    struct NoteInform {
        let message: String
        let title: String
    }
}

// MARK: - Function
extension YourNoteViewModel {
    func fetchNoteFromFirebase() {
        FStorage.shared.firebaseReference(.note)
            .whereField(ServerConstant.Param.noteId, isEqualTo: FUser.currentId())
            .getDocuments { snap, error in
                guard let snap = snap else { return }
                if !snap.isEmpty {
                    self.dataInput = OnNotesMapper.onNoteFromDictionary(snap)
                }
                if error != nil {
                    self.isShowToast = true
                    self.noteInform = NoteInform(
                        message: error?.localizedDescription ?? .empty, title: "Error!")
                }
            }
    }

    func updateListNote(item: CashInModel) {
        dataInput.append(item)
        updateFirebaseCollectionNote(item: item)
        isShowActionSheet = false
    }

    private func updateFirebaseCollectionNote(item: CashInModel) {
        FStorage.shared.firebaseReference(.note)
            .document(item.id)
            .setData(
                OnNotesMapper.mapNotesToFirebase(item)
            ) { error in
                guard let error = error else {
                    self.noteInform = NoteInform(
                        message: "Add Cash Notes Sucessfully!", title: "Inform!")
                    return
                }
                self.noteInform = NoteInform(message: error.localizedDescription, title: "Error!")
                self.isShowToast = true
            }
    }
}
