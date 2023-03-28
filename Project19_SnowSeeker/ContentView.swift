//
//  ContentView.swift
//  Project19_SnowSeeker
//
//  Created by admin on 18/03/2023.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @StateObject var favorites = Favorites()
    private var filters = ["alphabetic", "country", "default"]
    @State private var seacrhText = ""
    @State private var filter = ""
    var body: some View {
        NavigationView {
            List(showResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.pink)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $seacrhText.animation(), prompt: "Search for resort: ")
            .toolbar {
                ToolbarItem {
                    Picker(selection: $filter.animation()) {
                        ForEach(filters, id: \.self) { filter in
                            Text(filter)
                        }
                    } label: {
                        Image(systemName: "text.magnifyingglass")
                            .foregroundColor(.secondary)
                    }
                }
            }
            WelcomeView()
        }
        .environmentObject(favorites)
    }

    var showResorts: [Resort] {
        if seacrhText.isEmpty {
            return filter(resorts)
        } else {
            return filter(resorts).filter { $0.name.localizedCaseInsensitiveContains(seacrhText) }
        }
    }

    // MARK: Challenge #3

    func filter(_ resorts: [Resort]) -> [Resort] {
        switch filter {
        case "alphabetic":
            return resorts.sorted { $0.name < $1.name }
        case "country":
            return resorts.sorted { $0.country < $1.country }
        default:
            return resorts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
