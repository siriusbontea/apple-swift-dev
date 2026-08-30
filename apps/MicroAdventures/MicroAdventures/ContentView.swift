//
//  ContentView.swift
//  MicroAdventures
//
//  Created by Zathras on 8/30/26.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var adventures = Adventure.samples
    @State private var currentID: Adventure.ID?
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var selectedCategories = Set(Adventure.Category.allCases)
    @State private var selectedEffortLevels = Set(Adventure.EffortLevel.allCases)

    private var filteredAdventures: [Adventure] {
        adventures.filter { adventure in
            selectedCategories.contains(adventure.category)
                && selectedEffortLevels.contains(adventure.effortLevel)
        }
    }

    private var currentAdventure: Adventure? {
        if let currentID,
           let match = filteredAdventures.first(where: { $0.id == currentID }) {
            return match
        }
        return filteredAdventures.first
    }

    var body: some View {
        NavigationStack {
            ZStack {
                mapLayer

                VStack(spacing: 16) {
                    if let adventure = currentAdventure {
                        adventureCard(adventure)
                    } else {
                        emptyFilterCard
                    }

                    Spacer()

                    nextAdventureButton
                }
                .padding()
            }
            .navigationTitle("Micro Adventures")
            .navigationBarTitleDisplayMode(.large)
            .toolbar { filterToolbar }
            .onAppear(perform: showCurrentAdventureOnMap)
            .onChange(of: currentAdventure?.id) { _, _ in
                showCurrentAdventureOnMap()
            }
        }
    }

    private var mapLayer: some View {
        Map(position: $cameraPosition) {
            if let adventure = currentAdventure {
                Marker(adventure.locationName, coordinate: adventure.coordinate)
            }
        }
        .mapStyle(.standard)
        .ignoresSafeArea()
    }

    private var filterToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Section("Categories") {
                    Button("Select all") {
                        selectedCategories = Set(Adventure.Category.allCases)
                    }
                    ForEach(Adventure.Category.allCases) { category in
                        Toggle(category.rawValue, isOn: categoryBinding(category))
                    }
                }

                Section("Effort") {
                    Button("Select all") {
                        selectedEffortLevels = Set(Adventure.EffortLevel.allCases)
                    }
                    ForEach(Adventure.EffortLevel.allCases) { level in
                        Toggle(level.rawValue, isOn: effortBinding(level))
                    }
                }
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
            }
            .accessibilityIdentifier("filterButton")
        }
    }

    private func adventureCard(_ adventure: Adventure) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                pill(adventure.category.rawValue)
                pill(adventure.effortLevel.rawValue)
                Spacer(minLength: 0)
            }

            Text(adventure.title)
                .font(.title2.bold())

            Text(adventure.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Text(adventure.locationName)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                Spacer()
                statusButton(for: adventure)
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 12, y: 4)
    }

    private var emptyFilterCard: some View {
        Text("No adventures match the current filters. Choose Select all in the filter menu to see every micro adventure.")
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }

    private var nextAdventureButton: some View {
        Button(action: showNextAdventure) {
            Text("Next Adventure")
                .font(.headline)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .disabled(filteredAdventures.count < 2)
        .shadow(color: .black.opacity(0.18), radius: 10, y: 3)
    }

    private func pill(_ title: String) -> some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.thinMaterial, in: Capsule())
    }

    private func statusButton(for adventure: Adventure) -> some View {
        Button {
            toggleCompleted(adventure)
        } label: {
            Label(
                adventure.isCompleted ? "Completed" : "Mark complete",
                systemImage: adventure.isCompleted ? "checkmark.circle.fill" : "circle"
            )
            .font(.subheadline.weight(.semibold))
        }
        .buttonStyle(.bordered)
        .tint(adventure.isCompleted ? .green : .accentColor)
    }

    private func categoryBinding(_ category: Adventure.Category) -> Binding<Bool> {
        Binding(
            get: { selectedCategories.contains(category) },
            set: { isOn in
                if isOn {
                    selectedCategories.insert(category)
                } else {
                    selectedCategories.remove(category)
                }
            }
        )
    }

    private func effortBinding(_ level: Adventure.EffortLevel) -> Binding<Bool> {
        Binding(
            get: { selectedEffortLevels.contains(level) },
            set: { isOn in
                if isOn {
                    selectedEffortLevels.insert(level)
                } else {
                    selectedEffortLevels.remove(level)
                }
            }
        )
    }

    private func showNextAdventure() {
        let visible = filteredAdventures
        guard !visible.isEmpty else { return }

        if let currentID,
           let index = visible.firstIndex(where: { $0.id == currentID }) {
            self.currentID = visible[(index + 1) % visible.count].id
        } else {
            currentID = visible[0].id
        }
    }

    private func toggleCompleted(_ adventure: Adventure) {
        guard let index = adventures.firstIndex(where: { $0.id == adventure.id }) else { return }
        adventures[index].isCompleted.toggle()
    }

    private func showCurrentAdventureOnMap() {
        guard let adventure = currentAdventure else { return }
        if currentID == nil {
            currentID = adventure.id
        }
        cameraPosition = .region(
            MKCoordinateRegion(
                center: adventure.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
            )
        )
    }
}

#Preview {
    ContentView()
}
