//
//  ContentView.swift
//  ProjetCalculGlucides
//
//  Created by Cédric Gillot on 25/12/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State var buttonIsPressed = false
    
    var body: some View {
        if buttonIsPressed {
            MainView()
        } else {
            VStack {
                Text("GluciCalc")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.red)
                    .padding(.bottom, 50)
                Text("Cette application est conçue pour offrir une assistance dans le calcul des doses d'insuline et vise à compléter, et non à remplacer, les directives et conseils fournis par les professionnels de santé. Elle ne doit pas être utilisée comme unique outil de décision pour la gestion de votre traitement du diabète. Veuillez toujours consulter un médecin ou un professionnel de santé qualifié pour des conseils médicaux personnalisés. L'utilisation de cette application se fait sous votre propre responsabilité et ne saurait engager notre responsabilité en cas de problèmes de santé ou d'autres complications.")
                    .font(.title2)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 5)
                Spacer()
                Button(action: {
                    buttonIsPressed = true
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: 200, height: 60)
                            .foregroundColor(.green)
                        Text("J'ai compris")
                            .font(.title2)
                            .foregroundStyle(.primary)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    LaunchScreenView()
}
