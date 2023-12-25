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
            ZStack {
                Image("launchImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(20)
                VStack {
                    Text("GluciCalc")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.red)
                        .padding(50)
                    Spacer()
                }
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
