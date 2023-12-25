//
//  ContentView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State var timeIsElapsed = false
    
    var body: some View {
        if timeIsElapsed {
            MainView()
        }
        else {
            VStack {
                Text("Page de lancement")
            }
            .padding()
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        timeIsElapsed = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
