//
//  FirebaseReference.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/5/22.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case user
    case memory
}

func firebaseReference(_ collectionRef: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionRef.rawValue)
}
