//
//  Adventure.swift
//  MicroAdventures
//
//  Created by Zathras on 8/30/26.
//

import CoreLocation
import Foundation

struct Adventure: Identifiable, Hashable {
    let id: UUID
    var title: String
    var description: String
    var category: Category
    var effortLevel: EffortLevel
    var locationName: String
    var latitude: Double
    var longitude: Double
    var isCompleted: Bool

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        category: Category,
        effortLevel: EffortLevel,
        locationName: String,
        latitude: Double,
        longitude: Double,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.effortLevel = effortLevel
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.isCompleted = isCompleted
    }
}

extension Adventure {
    enum Category: String, CaseIterable, Identifiable {
        case nature = "Nature"
        case food = "Food"
        case culture = "Culture"
        case urban = "Urban"

        var id: String { rawValue }
    }

    enum EffortLevel: String, CaseIterable, Identifiable {
        case easy = "Easy"
        case moderate = "Moderate"
        case energetic = "Energetic"

        var id: String { rawValue }
    }
}

extension Adventure {
    static let samples: [Adventure] = [
        Adventure(
            title: "Golden Gate Overlook Walk",
            description: "Stroll the Battery Spencer trail for a windy, close-up view of the Golden Gate Bridge and the bay.",
            category: .nature,
            effortLevel: .easy,
            locationName: "Battery Spencer, Sausalito",
            latitude: 37.8324,
            longitude: -122.4796
        ),
        Adventure(
            title: "Central Park Ramble Picnic",
            description: "Wander the Ramble, pick a quiet rock by the lake, and have a short picnic under the trees.",
            category: .nature,
            effortLevel: .easy,
            locationName: "The Ramble, Central Park",
            latitude: 40.7829,
            longitude: -73.9654
        ),
        Adventure(
            title: "Pike Place Market Tasting",
            description: "Weave through Pike Place for coffee, fruit, and a seafood snack. Watch the fish toss if the stall is open.",
            category: .food,
            effortLevel: .moderate,
            locationName: "Pike Place Market, Seattle",
            latitude: 47.6097,
            longitude: -122.3425
        ),
        Adventure(
            title: "Griffith Observatory Sunset",
            description: "Ride or hike up to Griffith Observatory, then catch the city lights and a peek through the public telescopes.",
            category: .culture,
            effortLevel: .moderate,
            locationName: "Griffith Observatory, Los Angeles",
            latitude: 34.1184,
            longitude: -118.3004
        ),
        Adventure(
            title: "Chicago Riverwalk Circuit",
            description: "Walk the Riverwalk from Michigan Avenue to Lake Street. Duck into a riverside cafe if the wind picks up.",
            category: .urban,
            effortLevel: .easy,
            locationName: "Chicago Riverwalk",
            latitude: 41.8881,
            longitude: -87.6233
        ),
        Adventure(
            title: "Barton Springs Cool-Off",
            description: "Take a short dip in the spring-fed pool, then dry off on the lawn. A classic Austin micro adventure on a hot day.",
            category: .nature,
            effortLevel: .energetic,
            locationName: "Barton Springs Pool, Austin",
            latitude: 30.2640,
            longitude: -97.7713
        ),
        Adventure(
            title: "Freedom Trail First Mile",
            description: "Follow the red brick line from Boston Common to Faneuil Hall. Read a plaque or two and grab a treat at Quincy Market.",
            category: .culture,
            effortLevel: .moderate,
            locationName: "Boston Common",
            latitude: 42.3554,
            longitude: -71.0656
        ),
        Adventure(
            title: "Brooklyn Bridge Sunrise Crossing",
            description: "Walk the wooden boards toward Brooklyn at first light, then loop back with a coffee in DUMBO.",
            category: .urban,
            effortLevel: .energetic,
            locationName: "Brooklyn Bridge",
            latitude: 40.7061,
            longitude: -73.9969
        )
    ]
}
