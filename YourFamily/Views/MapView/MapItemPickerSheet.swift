import MapKit
import SwiftUI

@available(iOS 15.0, *)
struct MapItemPickerSheet<Content: View>: View {
    @Binding var isPresented: Bool

    @State private var pickerViewController: MapItemPickerViewController

    private var content: Content

    private var onDismiss: ((MKMapItem?) -> Void)?

    init(isPresented: Binding<Bool>, onDismiss: ((MKMapItem?) -> Void)?, content: Content) {
        let pickerViewController = MapItemPickerViewController()
        self.onDismiss = onDismiss
        self._pickerViewController = State(wrappedValue: pickerViewController)
        self._isPresented = isPresented
        self.content = content
        setupPickerViewController()
    }

    private func setupPickerViewController() {
        pickerViewController.onDismiss = { mapItem in
            onDismiss?(mapItem)
            isPresented = false
        }
    }

    var body: some View {
        content
            .onChange(of: pickerViewController.isBeingPresented) { presenting in
                isPresented = presenting
            }
            .onChange(of: isPresented) { presenting in
                if presenting && !pickerViewController.isBeingPresented {
                    UIApplication.shared
                        .topmostViewController?
                        .present(pickerViewController, animated: true)
                    pickerViewController
                        .present(
                            pickerViewController.searchNavigationController, animated: true
                        )
                } else {
                    pickerViewController
                        .presentingViewController?
                        .dismiss(animated: true)
                    pickerViewController = MapItemPickerViewController()
                    setupPickerViewController()
                }
            }
    }
}

extension UIApplication {
    // swiftlint:disable first_where
    var topmostViewController: UIViewController? {
        var viewController =
        connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .filter { $0.isKeyWindow }
            .first?
            .rootViewController
        while let presentedViewController = viewController?.presentedViewController {
            viewController = presentedViewController
        }
        return viewController
    }
}
