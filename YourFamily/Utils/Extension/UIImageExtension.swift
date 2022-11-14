//
//  UIImageExtension.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 10/4/22.
//

import Foundation
import UIKit

extension UIImage {
    /// Given a required height, returns a (rasterised) copy
    /// of the image, aspect-fitted to that height.
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

enum UIImageExtension {}
