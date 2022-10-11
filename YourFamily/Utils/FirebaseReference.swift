//
//  FirebaseReference.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/5/22.
//

import FirebaseFirestore
import Foundation

enum FCollectionReference: String {
    case user
    case memory
}

class FStorage {
    static let shared = FStorage()

    func firebaseReference(_ collectionRef: FCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionRef.rawValue)
    }
}
