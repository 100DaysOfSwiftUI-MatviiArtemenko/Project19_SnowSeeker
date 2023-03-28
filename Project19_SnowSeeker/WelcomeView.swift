//
//  WelcomeView.swift
//  Project19_SnowSeeker
//
//  Created by admin on 18/03/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            Text("Please, select a resort from the left-hand menu.\nTo do that swipe from the left edge o show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
