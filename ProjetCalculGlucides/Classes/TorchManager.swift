//
//  TorchManager.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 27/12/2023.
//

import AVFoundation
import SwiftUI

class TorchManager {
    func toggleTorch(on: Bool) {
        
        guard let device = AVCaptureDevice.userPreferredCamera,
              device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if on && device.torchMode == .off {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
            } else if !on && device.torchMode == .on {
                device.torchMode = .off
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Erreur lors de l'activation de la lampe torche : \(error)")
        }
    }
}
