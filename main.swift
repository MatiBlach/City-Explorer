import Foundation

//Extend data model
struct Location {
    let id: Int
    let type: String 
    let name: String
    let rating: Int 
}

//Data model
struct City {
    let id: Int
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    let keywords: [String]
    var locations: [Location]?
}

var cities: [City] = [
    City(id: 1, name: "Gdansk", description: "The Port City", latitude: 54.3520, longitude: 18.6466, keywords: ["seaside", "history", "culture"]),
    City(id: 2, name: "Warsaw", description: "The Capital of Poland", latitude: 52.2297, longitude: 21.0122, keywords: ["history", "culture", "urban"]),
    City(id: 3, name: "Chicago", description: "The Windy City", latitude: 41.8781, longitude: -87.6298, keywords: ["urban", "culture", "architecture"]),
    City(id: 4, name: "San Francisco", description: "The Golden Gate City", latitude: 37.7749, longitude: -122.4194, keywords: ["urban", "tech", "nature"]),
    City(id: 5, name: "London", description: "The UK Capital", latitude: 51.5074, longitude: -0.1278, keywords: ["urban", "culture", "history"]),
    City(id: 6, name: "Paris", description: "The City of Light", latitude: 48.8566, longitude: 2.3522, keywords: ["urban", "culture", "romance"]),
    City(id: 7, name: "Tokyo", description: "The Capital of Japan", latitude: 35.6895, longitude: 139.6917, keywords: ["urban", "tech", "culture"]),
    City(id: 8, name: "Sydney", description: "The Harbour City", latitude: -33.8688, longitude: 151.2093, keywords: ["urban", "beach", "culture"]),
    City(id: 9, name: "Rio de Janeiro", description: "The Marvelous City", latitude: -22.9068, longitude: -43.1729, keywords: ["urban", "beach", "culture"]),
    City(id: 10, name: "Cape Town", description: "The Mother City", latitude: -33.9249, longitude: 18.4241, keywords: ["urban", "beach", "nature"]),
    City(id: 11, name: "Barcelona", description: "The Gaudi City", latitude: 41.3851, longitude: 2.1734, keywords: ["urban", "culture", "beach"]),
    City(id: 12, name: "Dubai", description: "The City of Gold", latitude: 25.276987, longitude: 55.296249, keywords: ["urban", "luxury", "desert"]),
    City(id: 13, name: "Rome", description: "The Eternal City", latitude: 41.9028, longitude: 12.4964, keywords: ["urban", "culture", "history"]),
    City(id: 14, name: "Moscow", description: "The Capital of Russia", latitude: 55.7558, longitude: 37.6176, keywords: ["urban", "culture", "history"]),
    City(id: 15, name: "Hong Kong", description: "The Pearl of the Orient", latitude: 22.3193, longitude: 114.1694, keywords: ["urban", "culture", "finance"]),
    City(id: 16, name: "Singapore", description: "The Lion City", latitude: 1.3521, longitude: 103.8198, keywords: ["urban", "culture", "tech"]),
    City(id: 17, name: "Istanbul", description: "The Bridge Between East and West", latitude: 41.0082, longitude: 28.9784, keywords: ["urban", "culture", "history"]),
    City(id: 18, name: "Berlin", description: "The Capital of Germany", latitude: 52.5200, longitude: 13.4050, keywords: ["urban", "culture", "history"]),
    City(id: 19, name: "Mexico City", description: "The Capital of Mexico", latitude: 19.4326, longitude: -99.1332, keywords: ["urban", "culture", "history"]),
    City(id: 20, name: "Toronto", description: "The Capital of Ontario", latitude: 43.6532, longitude: -79.3832, keywords: ["urban", "culture", "diversity"])
]


//Search
func searchCity(byName name: String, in cities: [City]) -> [City] {
    return cities.filter { $0.name.lowercased() == name.lowercased() }
}

func searchCity(byKeyword keyword: String, in cities: [City]) -> [City] {
    return cities.filter { $0.keywords.contains { $0.lowercased() == keyword.lowercased() } }
}

let citiesWithName = searchCity(byName: "New York", in: cities)
print("Cities with the name 'New York': \(citiesWithName)")

let citiesWithKeyword = searchCity(byKeyword: "diversity", in: cities)
print("Cities with the keyword 'diversity': \(citiesWithKeyword)")

//Distance
func calculateDistance(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
    let radiusOfEarth = 6371.0 // Earth's radius in kilometers
    
    let lat1 = latitude1 * Double.pi / 180.0
    let lon1 = longitude1 * Double.pi / 180.0
    let lat2 = latitude2 * Double.pi / 180.0
    let lon2 = longitude2 * Double.pi / 180.0
    
    let dLat = lat2 - lat1
    let dLon = lon2 - lon1
    
    let a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2)
    let c = 2 * atan2(sqrt(a), sqrt(1 - a))
    
    let distance = radiusOfEarth * c
    return distance
}

// Find the closest and farthest cities from a given user coordinate
func findClosestAndFarthestCity(userLatitude: Double, userLongitude: Double, in cities: [City]) -> (closest: City, farthest: City) {
    var closestCity = cities.first!
    var farthestCity = cities.first!
    var minDistance = Double.infinity
    var maxDistance: Double = 0.0
    
    for city in cities {
        let distance = calculateDistance(latitude1: userLatitude, longitude1: userLongitude, latitude2: city.latitude, longitude2: city.longitude)
        if distance < minDistance {
            minDistance = distance
            closestCity = city
        }
        if distance > maxDistance {
            maxDistance = distance
            farthestCity = city
        }
    }
    return (closestCity, farthestCity)
}

// Find two farthest cities from the array
func findFarthestCities(in cities: [City]) -> (City, City) {
    var farthestCity1 = cities.first!
    var farthestCity2 = cities.first!
    var maxDistance: Double = 0.0
    
    for i in 0..<cities.count {
        for j in i+1..<cities.count {
            let distance = calculateDistance(latitude1: cities[i].latitude, longitude1: cities[i].longitude, latitude2: cities[j].latitude, longitude2: cities[j].longitude)
            if distance > maxDistance {
                maxDistance = distance
                farthestCity1 = cities[i]
                farthestCity2 = cities[j]
            }
        }
    }
    return (farthestCity1, farthestCity2)
}

// Example usage
let gdansk = cities[0]
let warsaw = cities[1]

let ourLatitude = 40.7128
let ourLongitude = -74.0060


let distanceGDAtoWWA = calculateDistance(latitude1: gdansk.latitude, longitude1: gdansk.longitude, latitude2: warsaw.latitude, longitude2: warsaw.longitude)
print("Distance between Gdansk and Warsaw: \(distanceGDAtoWWA) km")

let (closestCity, farthestCity) = findClosestAndFarthestCity(userLatitude: ourLatitude, userLongitude: ourLongitude, in: cities)
print("Closest city to the user: \(closestCity.name)")
print("Farthest city from the user: \(farthestCity.name)")

let (farthestCity1, farthestCity2) = findFarthestCities(in: cities)
print("Two farthest cities from the array: \(farthestCity1.name) and \(farthestCity2.name)")

//Extend data model
let gdanskLocations: [Location] = [
    Location(id: 1, type: "Restaurant", name: "Slaska 19", rating: 5),
    Location(id: 2, type: "Old Town", name: "Wrzeszcz Walejduty", rating: 5),
    Location(id: 3, type: "View Point", name: "Pacholek", rating: 4),
]

let warsawLocations: [Location] = [
    Location(id: 1, type: "Museum", name: "the Neon Museum", rating: 5),
    Location(id: 2, type: "Old Town", name: "Royal Baths", rating: 4),
    Location(id: 3, type: "Restaurant", name: "The Cool Cat", rating: 4),
]

let chicagoLocations: [Location] = [
    Location(id: 1, type: "View Point", name: "360 CHICAGO", rating: 4),
    Location(id: 2, type: "Park", name: "Millennium Park", rating: 3),
    Location(id: 3, type: "Restaurant", name: "Girl and The Goat", rating: 4),
]

var citiesWithLocations = cities
cities[0].locations = gdanskLocations
cities[1].locations = warsawLocations
cities[2].locations = chicagoLocations

//Adcance search
func findCitiesWithFiveStarRestaurants(cities: [City]) -> [City] {
    var citiesWithFiveStarRestaurants = [City]()
    for city in cities {
        if let locations = city.locations {
            let hasFiveStarRestaurant = locations.contains { location in
                location.type == "Restaurant" && location.rating == 5
            }
            if hasFiveStarRestaurant {
                citiesWithFiveStarRestaurants.append(city)
            }
        }
    }
    return citiesWithFiveStarRestaurants
}

func locationsInCitySortedByRating(city: City) -> [Location] {
    guard let locations = city.locations else {
        return []
    }
    return locations.sorted { $0.rating > $1.rating }
}

func displayCitiesWithFiveStarLocations(cities: [City]) {
    for city in cities {
        // Check if the city has locations and if there are any 5-star locations
        guard let locations = city.locations, !locations.isEmpty else {
            continue // Skip the city if it has no locations
        }
        
        let fiveStarLocations = locations.filter { $0.rating == 5 }
        if !fiveStarLocations.isEmpty {
            print("\(city.name) has \(fiveStarLocations.count) locations with 5-star rating:")
            for location in fiveStarLocations {
                print("- \(location.name) (\(location.type))")
            }
        }
    }
}

let citiesWithFiveStarRestaurants = findCitiesWithFiveStarRestaurants(cities: cities)
print("Cities with restaurants with 5-star rating:")
for city in citiesWithFiveStarRestaurants {
    print("- \(city.name)")
}

let city = cities[0] // Assume Gdansk is the first city in the array
let relatedLocations = locationsInCitySortedByRating(city: city)
print("Related locations in \(city.name) sorted by rating:")
for location in relatedLocations {
    print("- \(location.name) (\(location.type)), Rating: \(location.rating)")
}

print("Cities with locations with 5-star rating:")
displayCitiesWithFiveStarLocations(cities: cities)




