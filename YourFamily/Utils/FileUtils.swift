//
//  FileUtils.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/12/22.
//

import Foundation
import UIKit

struct FileUtils {
    static func fileNameFrom(fileUrl: String) -> String {
        return ((fileUrl.components(separatedBy: "_").last)!.components(separatedBy: "?").first!)
            .components(separatedBy: ".").first!
    }


    //Helpers
    static func fileInDocumentsDirectory(fileName: String) -> String {
        return getDocumentsURL().appendingPathComponent(fileName).path
    }

    static func getDocumentsURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }

    static func fileExistsAtPath(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: fileInDocumentsDirectory(fileName: path))
    }

}
