import SwiftUI


struct CityWeatherView: View {
    let city: City//chambéry
    @State private var weather: Weather?
    @State private var isLoading = true

    var body: some View {
        List {
            Section(header: Text("Now")) {
                if isLoading {
                    skeletonHeader
                } else if let current = weather?.current {
                    currentHeader(current)
                }
            }

            Section(header: Text("Hourly")) {
                if isLoading {
                    skeletonHourly
                } else if let hours = weather?.hours.list {
                    hourlyScroll(hours)
                }
            }

            Section(header: Text("This week")) {
                if isLoading {
                    ForEach(0..<7, id: \.self) { _ in
                        skeletonDailyRow
                    }
                } else if let days = weather?.week.list {
                    ForEach(days) { day in
                        dailyRow(day)
                    }
                }
            }
        }
        .navigationTitle(city.name)
        .task {
            weather = await city.fetchWeather()
            isLoading = false
        }
    }


    @ViewBuilder
    private func currentHeader(_ current: HourlyWeather) -> some View {
        HStack {
            Spacer()
            HStack(spacing: 16) {
                current.icon.image
                    .font(.largeTitle)
                Text(current.temperature.formattedTemperature)
                    .font(.largeTitle)
            }
            Spacer()
        }
        .frame(height: 110)
    }


    @ViewBuilder
    private func hourlyScroll(_ hours: [HourlyWeather]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(hours) { hour in
                    VStack(spacing: 16) {
                        Text(hour.time.formattedHour)
                            .font(.footnote)
                        hour.icon.image
                            .font(.body)
                        Text(hour.temperature.formattedTemperature)
                            .font(.headline)
                    }
                }
            }
            .padding([.leading, .trailing])
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding([.top, .bottom])
    }


    @ViewBuilder
    private func dailyRow(_ day: DailyWeather) -> some View {
        ZStack {
            HStack {
                Text(day.time.formattedDay)
                Spacer()
                HStack(spacing: 16) {
                    VStack(alignment: .trailing) {
                        Text("min")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(day.minTemperature.formattedTemperature)
                            .font(.headline)
                    }
                    VStack(alignment: .trailing) {
                        Text("max")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(day.maxTemperature.formattedTemperature)
                            .font(.headline)
                    }
                }
            }
            HStack {
                Spacer()
                day.icon.image
                    .font(.body)
                Spacer()
            }
        }
    }


    private var skeletonHeader: some View {
        HStack {
            Spacer()
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 40, height: 40)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 40)
            }
            Spacer()
        }
        .frame(height: 110)
    }

    private var skeletonHourly: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<8, id: \.self) { _ in
                    VStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 40, height: 12)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 24, height: 24)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 36, height: 16)
                    }
                }
            }
            .padding([.leading, .trailing])
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding([.top, .bottom])
    }

    private var skeletonDailyRow: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 80, height: 16)
            Spacer()
            HStack(spacing: 16) {
                VStack(alignment: .trailing, spacing: 4) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 30, height: 10)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 36, height: 14)
                }
                VStack(alignment: .trailing, spacing: 4) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 30, height: 10)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 36, height: 14)
                }
            }
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    NavigationView {
        CityWeatherView(city: .mock)
    }
}

private extension City {
    static let mock = City()
}
