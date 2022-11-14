//
//  FileStorage.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/12/22.
//

import FirebaseStorage
import Foundation
import UIKit

// swiftlint:disable legacy_objc_type
// swiftlint:disable object_literal
class FileStorage {
    static let shared = FileStorage()
    let storage = Storage.storage()

    // MARK: - Upload Image
    class func uploadImage(
        _ image: UIImage, directory: String, completion: @escaping (_ documentLink: String?) -> Void
    ) {
        let storageRef = FileStorage.shared.storage.reference(
            forURL: ServerConstant.BaseAPIURL.storageURL
        )
        .child(directory)
        let imageData = image.jpegData(compressionQuality: 0.6)
        var task: StorageUploadTask!
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        task = storageRef.putData(
            imageData!,
            metadata: metadata
        ) { _, error in
            task.removeAllObservers()
            if error != nil {
                print("error uploading image \(error!.localizedDescription)")
                return
            }
            storageRef.downloadURL { url, _ in
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
            }
        }
        task.observe(StorageTaskStatus.progress) { _ in
        }
    }

    // MARK: - Save Locally
    class func saveFileLocally(fileData: NSData, fileName: String) {
        let docUrl = FileUtils.getDocumentsURL().appendingPathComponent(
            fileName,
            isDirectory: false
        )
        fileData.write(to: docUrl, atomically: true)
    }

    class func downloadImage(imageUrl: String, completion: @escaping (_ image: UIImage?) -> Void) {
        let imageFileName = FileUtils.fileNameFrom(fileUrl: imageUrl)
        if FileUtils.fileExistsAtPath(path: imageFileName) {
            if let contentsOfFile = UIImage(
                contentsOfFile: FileUtils.fileInDocumentsDirectory(fileName: imageFileName)
            ) {
                completion(contentsOfFile)
            } else {
                print("couldnt convert local image")
                completion(UIImage(named: "avatar"))
            }
        } else {
            if imageUrl != .empty {
                let documentUrl = URL(string: imageUrl)
                let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
                downloadQueue.async {
                    let data = NSData(contentsOf: documentUrl!)
                    if data != nil {
                        FileStorage.saveFileLocally(fileData: data!, fileName: imageFileName)
                        DispatchQueue.main.async {
                            completion(UIImage(data: data! as Data))
                        }
                    } else {
                        print("no document in database")
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                }
            }
        }
    }

    class func saveUserLocally(userDictionary: NSDictionary) {
        UserDefaults.standard.set(userDictionary, forKey: ServerConstant.Param.currentUser)
        UserDefaults.standard.synchronize()
    }
}
