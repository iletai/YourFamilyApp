//
//  ImagePicker.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/28/22.
//

import SwiftUI

struct ImagePicker: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ImagePickerViewController(presentationMode: presentationMode, image: $userData.image)
    }
}

final class UserData: ObservableObject {
    @Published var image: UIImage?
}

struct ImagePickerViewController: UIViewControllerRepresentable {
    @Binding var presentationMode: PresentationMode
    @Binding var image: UIImage?

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ImagePickerViewController>
    ) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<ImagePickerViewController>
    ) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePickerViewController

        init(_ parent: ImagePickerViewController) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            let imagePicked = info[.originalImage] as? UIImage
            parent.image = imagePicked
            parent.presentationMode.dismiss()
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.dismiss()
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var userData = UserData()
    static var previews: some View {
        ImagePicker()
            .environmentObject(self.userData)
    }
}
