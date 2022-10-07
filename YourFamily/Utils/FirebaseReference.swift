//
//  FirebaseReference.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/5/22.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Memory
}

func FirebaseReference(_ collectionRef: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionRef.rawValue)
}
