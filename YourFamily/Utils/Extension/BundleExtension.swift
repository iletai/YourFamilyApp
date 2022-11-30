//
// Create in 2022 by iletai.
// Follow me at: @iletai
//

import Foundation

class BundleLocation {}
extension Bundle {
    static let resourceBundle = "YourFamilyBundle"
    static var Current: Bundle {
        let currentBundle = Bundle(for: BundleLocation.self)
        guard
            let bundleUrl = currentBundle.url(forResource: resourceBundle, withExtension: "bundle")
        else {
            fatalError("\(resourceBundle).bundle could not found!")
        }
        guard let resourceBundle = Bundle(url: bundleUrl) else {
            fatalError("Acess define for bundle \(resourceBundle)!")
        }
        return resourceBundle
    }

    func localizedString(forKey key: String) -> String {
        self.localizedString(forKey: key, value: nil, table: nil)
    }
}

enum BundleExtension {}
