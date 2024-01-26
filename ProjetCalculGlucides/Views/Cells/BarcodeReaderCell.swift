//
//  BarcodeReaderView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI
import VisionKit

struct BarcodeReaderCell: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let scannerViewController = DataScannerViewController(
            recognizedDataTypes : [.barcode()],
            qualityLevel: .balanced,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if !uiViewController.isScanning {
            try? uiViewController.startScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: BarcodeReaderCell
        
        init(_ parent: BarcodeReaderCell) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            print(addedItems)
            switch addedItems[0] {
            case .barcode(let barcode):
                parent.scannedCode = barcode.payloadStringValue ?? "Inconnu"
            default:
                break
            }
        }
    }
}

#Preview {
    BarcodeReaderCell(scannedCode: .constant(""))
}
