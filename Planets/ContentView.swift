//
//  ContentView.swift
//  Planets
//
//  Created by Cognizant on 18/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Text("Earth")
                .font(.system(size: 40))
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.leading)
                .padding()
            HStack {
                Text("Climate:")
                Text("Avrid")
            }
            HStack {
                Text("Gravity:")
                Text("1")
            }
            HStack {
                Text("Population:")
                Text("1000")
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
