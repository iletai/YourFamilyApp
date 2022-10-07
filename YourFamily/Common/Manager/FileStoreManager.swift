//
//  FileStoreManager.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/4/22.
//

import Firebase
import FirebaseStorage
import Foundation
import SwiftUI

class FileStoreManager: ObservableObject {
    let storage = Storage.storage()
    let kContentType = "image/jpg"

    func uploadFirebaseImage(_ image: UIImage) {
        let storageRef = storage.reference().child("images/image.jpg")
        let resizeImage = image.aspectFittedToHeight(200)
        let data = resizeImage.jpegData(compressionQuality: 0.2)

        let metadata = StorageMetadata()
        metadata.contentType = kContentType
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }

                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }

    func getListStorage() -> UIImage {
        var image = UIImage()
        let pathReference = storage.reference(withPath: "images/image.jpg")
        let gsReference = storage.reference(forURL: "gs://yourfamily-562e9.appspot.com/images/stars.jpg")
        let ref = Storage.storage().reference().child("images/image.jpg")
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                image = UIImage(data: data!)!
            }
        }
        return image
    }
}
