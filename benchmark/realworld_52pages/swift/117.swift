import SwiftUI


struct NewCityView: View {
    var onAdd: (City) -> Void//

    @State private var search = ""
    @State private var predictions: [Prediction] = []
    @State private var isValidating = false
    @State private var searchTask: Task<Void, Never>?

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Search City", text: $search)
                        .onChange(of: search) { newValue in
                            searchTask?.cancel()
                            guard !newValue.isEmpty else {
                                predictions = []
                                return
                            }
                            searchTask = Task {
                                await searchCity(newValue)
                            }
                        }
                }

                Section {
                    ForEach(predictions) { prediction in
                        Button {
                            addCity(from: prediction)
                        } label: {
                            Text(prediction.description)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .disabled(isValidating)
            .navigationTitle("Add City")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
            .listStyle(.grouped)
        }
    }

    private static let googleMapsKey = "" // Enter your Google Maps API key here

    private func searchCity(_ query: String) async {
        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(query)&types=(cities)&key=\(Self.googleMapsKey)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(AutocompleteResult.self, from: data)
            await MainActor.run { predictions = result.predictions }
        } catch {
            if !(error is CancellationError) {
                print(error.localizedDescription)
            }
        }
    }

    private func addCity(from prediction: Prediction) {
        isValidating = true

        Task {
            let city = await fetchCityDetails(placeID: prediction.id)
            await MainActor.run {
                isValidating = false
                if let city = city {
                    onAdd(city)
                    dismiss()
                }
            }
        }
    }

    private func fetchCityDetails(placeID: String) async -> City? {
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeID)&key=\(Self.googleMapsKey)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(PlaceDetailsResult.self, from: data)
            let d = result.result
            return City(name: d.name, longitude: d.geometry.location.lng, latitude: d.geometry.location.lat)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }


    struct Prediction: Codable, Identifiable {
        var id: String
        var description: String

        enum CodingKeys: String, CodingKey {
            case id = "place_id"
            case description = "description"
        }
    }

    struct AutocompleteResult: Codable {
        var predictions: [Prediction]
    }

    struct PlaceDetailsResult: Codable {
        var result: PlaceDetail

        struct PlaceDetail: Codable {
            var name: String
            var geometry: Geometry

            struct Geometry: Codable {
                var location: Location

                struct Location: Codable {
                    var lng: Double
                    var lat: Double
                }
            }
        }
    }
}


#Preview {
    NewCityView { _ in }
}
