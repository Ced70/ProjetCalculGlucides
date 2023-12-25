//
//  BarcodeReaderView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI
import AVFoundation

struct BarcodeReaderView: View {
    
    @Binding var scannedCode : String
    @State var lampIsActivated = false
    
    var body: some View {
        ZStack {
            BarcodeReaderCell(scannedCode: $scannedCode)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        lampIsActivated = !lampIsActivated
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        toggleTorch(on: lampIsActivated)
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
    }
}

#Preview {
    BarcodeReaderView(scannedCode: .constant(""))
}
