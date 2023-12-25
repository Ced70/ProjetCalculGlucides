//
//  BarcodeReaderView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI
import AVFoundation

struct BarcodeReaderView: View {
    
    let torchManager = TorchManager()
    
    @Binding var scannedCode : String
    @State var lampIsActivated = false

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BarcodeReaderCell(scannedCode: $scannedCode)
            Rectangle()
                .stroke(lineWidth: 3)
                .frame(height: 150)
                .padding(20)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        lampIsActivated = !lampIsActivated
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        torchManager.toggleTorch(on: lampIsActivated)
                    }, label: {
                        Image(systemName: lampIsActivated ? "flashlight.on.circle.fill" : "flashlight.on.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.primary)
                    })
                    .frame(width: 50, height: 50)
                }
                .padding(.horizontal, 40)
            }
        }
        .onChange(of: scannedCode, {
            dismiss()
        })
    }
}

#Preview {
    BarcodeReaderView(scannedCode: .constant(""))
}
