//
//  BarcodeScanerView.swift
//  YourFamily
//
//  Created by Lê Quang Trọng Tài on 9/29/22.
//

import BarcodeScanner
import SwiftUI

struct BarcodeScanerView: View {
    var body: some View {
        BarcodeScaner()
    }
}

struct BarcodeScaner: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<BarcodeScaner>)
        -> BarcodeScanner.BarcodeScannerViewController
    {
        let barcode = BarcodeScannerViewController()
        barcode.codeDelegate = context.coordinator
        barcode.dismissalDelegate = context.coordinator
        barcode.errorDelegate = context.coordinator
        return barcode
    }

    func makeCoordinator() -> BarcodeCoordinator {
        BarcodeCoordinator()
    }

    func updateUIViewController(
        _ uiViewController: BarcodeScannerViewController,
        context: UIViewControllerRepresentableContext<BarcodeScaner>
    ) {
        uiViewController.reset(animated: false)
    }
}

final class BarcodeCoordinator: NSObject,
    BarcodeScannerCodeDelegate,
    BarcodeScannerErrorDelegate,
    BarcodeScannerDismissalDelegate {
    func scanner(
        _ controller: BarcodeScanner.BarcodeScannerViewController, didReceiveError error: Error
    ) {
        controller.resetWithError(message: "Error message")
    }

    func scannerDidDismiss(_ controller: BarcodeScanner.BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func scanner(
        _ controller: BarcodeScanner.BarcodeScannerViewController, didCaptureCode code: String,
        type: String
    ) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
        }
    }
}

struct BarcodeScanerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScanerView()
    }
}
