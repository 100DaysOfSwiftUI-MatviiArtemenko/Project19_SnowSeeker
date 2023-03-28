//
//  ResortView.swift
//  Project19_SnowSeeker
//
//  Created by admin on 18/03/2023.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort

    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize

    @EnvironmentObject var favorites: Favorites

    @State private var selectedFacility: Facitity?
    @State private var showingFacility = false

    private let timer = Timer.publish(every: 1.3, on: .main, in: .default).autoconnect()
    @State private var isConnected = false
    @State private var counter = 0.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFit()
                        .scaleEffect(2)
                        .offset(x: 0, y: -30)
                        .blur(radius: 70)
                    VStack {
                        Image(decorative: resort.id)
                            .resizable()
                            .scaledToFit()

                            // MARK: Challenge #1

                            .overlay(alignment: .bottomTrailing) {
                                HStack {
                                    Text("📷\(resort.imageCredit)")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)

                                    Spacer()

                                    Button {
                                        withAnimation(.spring()) {
                                            if favorites.contains(resort) {
                                                favorites.remove(resort)
                                            } else {
                                                favorites.add(resort)
                                            }
                                        }
                                    } label: {
                                        Image(systemName: favorites.contains(resort) ? "heart.fill" : "heart")
                                            .font(.largeTitle)
                                            .foregroundColor(favorites.contains(resort) ? colorChange : .secondary)
                                            .shadow(
                                                color: isConnected
                                                    ?
                                                    colorChange
                                                    :
                                                    .secondary,
                                                radius: isConnected ? 25 : 2
                                            )
                                    }
                                    .padding()

                                    .onReceive(timer) { _ in
                                        withAnimation(.easeInOut(duration: 1.2)) {
                                            if counter < 1 {
                                                counter += 0.01
                                            } else {
                                                counter = 0.01
                                            }
                                        }
                                    }
                                }
                            }
                        HStack {
                            if sizeClass == .compact && typeSize > .large {
                                VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                                VStack(spacing: 10) { ResortDetailsView(resort: resort) }

                            } else {
                                SkiDetailsView(resort: resort)
                                ResortDetailsView(resort: resort)
                            }
                        }
                        .padding(.vertical)
                        .background(.ultraThinMaterial)
                        // if we want to limit the range of Dynamic Type sizes supported by a particular view -->
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    }
                    .onLongPressGesture(minimumDuration: 1) {
                        isConnected.toggle()
                    }
                }

                Group {
                    Text(resort.description)

                    VStack(spacing: 10) {
                        Text("Resort Facilities.")
                            .font(.headline)

                        HStack {
                            ForEach(resort.facilityType) { facility in
                                Button {
                                    selectedFacility = facility
                                    showingFacility = true
                                } label: {
                                    facility.icon
                                        .font(.title)
                                }
                            }
                        }

                        //                        Enoter way for layout:
                        //                        Text(resort.facilities, format: .list(type: .and))
                        //                            .padding(.vertical)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))

                .padding(.horizontal)
            }
            .navigationTitle("\(resort.name), \(resort.country)")
            .navigationBarTitleDisplayMode(.inline)
            .alert(
                selectedFacility?.name ?? "More information",
                isPresented: $showingFacility,
                presenting: selectedFacility
            ) { _ in
            } message: { facility in
                Text(facility.message)
            }
        }
    }

    var colorChange: Color {
        if isConnected {
            return Color(hue: Double(counter), saturation: 1, brightness: 1)
        } else {
            timer.upstream.connect().cancel()
            return .red
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResortView(resort: Resort.example)
        }
        .environmentObject(Favorites())
    }
}
