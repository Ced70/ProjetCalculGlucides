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
//                Image("launchImage")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .cornerRadius(20)
                VStack {
                    Text("GluciCalc")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.red)
                        .padding(50)
                    Text("Cette application est conçue pour offrir une assistance dans le calcul des doses d'insuline et vise à compléter, et non à remplacer, les directives et conseils fournis par les professionnels de santé. Elle ne doit pas être utilisée comme unique outil de décision pour la gestion de votre traitement du diabète. Veuillez toujours consulter un médecin ou un professionnel de santé qualifié pour des conseils médicaux personnalisés. L'utilisation de cette application se fait sous votre propre responsabilité et ne saurait engager notre responsabilité en cas de problèmes de santé ou d'autres complications.")
                        .font(.title2)
                        .foregroundStyle(.red)
                        .padding(.horizontal, 5)
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
