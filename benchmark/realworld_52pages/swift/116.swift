import SwiftUI


struct CityListView: View {
    @State private var cities: [City] = [City()]//chambéry
    @State private var weathers: [City.ID: Weather] = [:]
    @State private var isPresentingModal = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Your Cities")) {
                    ForEach(cities) { city in
                        cityRow(city)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
            .navigationTitle("Weather")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
        }
        .task {
            await fetchAllWeather()
        }
    }


    @ViewBuilder
    private func cityRow(_ city: City) -> some View {
        NavigationLink(destination: CityWeatherView(city: city)) {
            HStack(alignment: .firstTextBaseline) {
                Text(city.name)
                    .lineLimit(nil)
                    .font(.title)
                Spacer()
                HStack {
                    if let weather = weathers[city.id] {
                        weather.current.icon.image
                            .foregroundColor(.gray)
                            .font(.title)
                        Text(weather.current.temperature.formattedTemperature)
                            .foregroundColor(.gray)
                            .font(.title)
                    } else {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 60, height: 24)
                    }
                }
            }
            .padding([.trailing, .top, .bottom])
        }
    }

    private var addButton: some View {
        Button {
            isPresentingModal = true
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.title)
        }
        .sheet(isPresented: $isPresentingModal) {
            NewCityView { city in
                cities.append(city)
                Task {
                    await fetchWeather(for: city)
                }
            }
        }
    }


    private func delete(at offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
    }

    private func move(from source: IndexSet, to destination: Int) {
        cities.move(fromOffsets: source, toOffset: destination)
    }


    private func fetchAllWeather() async {
        for city in cities {
            await fetchWeather(for: city)
        }
    }

    private func fetchWeather(for city: City) async {
        if let weather = await city.fetchWeather() {
            weathers[city.id] = weather
        }
    }
}


#Preview {
    CityListView()
}
