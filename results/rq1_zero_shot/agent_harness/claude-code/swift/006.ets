// Weather App - ArkTS conversion from SwiftUI
@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = "New York"
  @State temperature: string = "72°"
  @State condition: string = "Sunny"
  @State feelsLike: string = "74°"
  @State humidity: string = "45%"
  @State wind: string = "5 mph"

  private readonly primaryBlue: ResourceColor = "#2196F3"
  private readonly primaryGreen: ResourceColor = "#4CAF50"
  private readonly primaryOrange: ResourceColor = "#FF9800"
  private readonly backgroundColor: ResourceColor = "#F5F7FA"
  private readonly surfaceColor: ResourceColor = "#FFFFFF"
  private readonly surfaceVariant: ResourceColor = "#E8F5E8"
  private readonly textPrimary: ResourceColor = "#263238"
  private readonly textSecondary: ResourceColor = "rgba(38, 50, 56, 0.7)"

  private hourlyForecast: WeatherHour[] = [
    { hour: "Now", temp: "72°", condition: "Sunny", color: "#FF9800" },
    { hour: "1 PM", temp: "74°", condition: "Sunny", color: "#FF9800" },
    { hour: "2 PM", temp: "75°", condition: "Sunny", color: "#FF9800" },
    { hour: "3 PM", temp: "76°", condition: "Cloudy", color: "#2196F3" },
    { hour: "4 PM", temp: "74°", condition: "Cloudy", color: "#2196F3" },
    { hour: "5 PM", temp: "72°", condition: "Rain", color: "#4CAF50" },
    { hour: "6 PM", temp: "70°", condition: "Rain", color: "#4CAF50" }
  ]

  private weeklyForecast: WeatherDay[] = [
    { day: "Today", high: "76°", low: "62°", condition: "Sunny", color: "#FF9800" },
    { day: "Mon", high: "74°", low: "60°", condition: "Cloudy", color: "#2196F3" },
    { day: "Tue", high: "72°", low: "58°", condition: "Rain", color: "#4CAF50" },
    { day: "Wed", high: "70°", low: "56°", condition: "Rain", color: "#4CAF50" },
    { day: "Thu", high: "73°", low: "59°", condition: "Cloudy", color: "#2196F3" },
    { day: "Fri", high: "75°", low: "61°", condition: "Sunny", color: "#FF9800" },
    { day: "Sat", high: "77°", low: "63°", condition: "Sunny", color: "#FF9800" }
  ]

  build() {
    Stack() {
      // Main content column
      Column() {
        // Header
        Text("Weather")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .margin({ top: 44, bottom: 18 })

        // Scrollable content
        Scroll() {
          Column({ space: 18 }) {
            // Current Weather Card
            Column({ space: 10 }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimary)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textSecondary)

              Row() {
                this.WeatherInfoItem("Feels like", this.feelsLike)
                Blank()
                this.WeatherInfoItem("Humidity", this.humidity)
                Blank()
                this.WeatherInfoItem("Wind", this.wind)
              }
              .padding({ left: 20, right: 20 })
            }
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: "rgba(0, 0, 0, 0.12)", offsetY: 2 })

            // Hourly Forecast
            Column({ space: 10 }) {
              Text("Hourly Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)
                .width('100%')
                .textAlign(TextAlign.Start)

              Scroll() {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(hour.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.textPrimary)

                      Circle({ width: 20, height: 20 })
                        .fill(hour.color)

                      Text(hour.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: "rgba(0, 0, 0, 0.1)", offsetY: 1 })
                  }, (hour: WeatherHour) => hour.hour)
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)

            // 7-Day Forecast
            Column({ space: 10 }) {
              Text("7-Day Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)
                .width('100%')
                .textAlign(TextAlign.Start)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (day: WeatherDay) => {
                  Row() {
                    Text(day.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor(this.textPrimary)
                      .width(40)
                      .textAlign(TextAlign.Start)

                    Circle({ width: 16, height: 16 })
                      .fill(day.color)
                      .margin({ left: 4 })

                    Blank()

                    Row({ space: 6 }) {
                      Text(day.high)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)

                      Text(day.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textSecondary)
                    }
                  }
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: "rgba(0, 0, 0, 0.1)", offsetY: 1 })
                }, (day: WeatherDay) => day.day)
              }
            }
            .alignItems(HorizontalAlign.Start)

            // Additional Info Card
            Row() {
              this.WeatherInfoItem("UV Index", "Moderate")
              Blank()
              this.WeatherInfoItem("Sunset", "7:45 PM")
              Blank()
              this.WeatherInfoItem("Visibility", "10 mi")
            }
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: "rgba(0, 0, 0, 0.1)", offsetY: 1 })
          }
          .padding({ left: 14, right: 14, bottom: 100 })
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()

        Column() {
          Row() {
            Blank()
            this.LocationButton("NY", this.currentLocation === "New York")
            Blank()
            this.LocationButton("London", this.currentLocation === "London")
            Blank()
            this.LocationButton("Tokyo", this.currentLocation === "Tokyo")
            Blank()
          }
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(this.surfaceColor)
          .borderRadius({ topLeft: 14, topRight: 14 })
          .shadow({ radius: 5, color: "rgba(0, 0, 0, 0.12)", offsetY: -2 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }

  @Builder
  WeatherInfoItem(title: string, value: string) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor("rgba(38, 50, 56, 0.7)")
      Text(value)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.textPrimary)
    }
  }

  @Builder
  LocationButton(title: string, isSelected: boolean) {
    Text(title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? "#FFFFFF" : this.textPrimary)
      .width(80)
      .height(32)
      .textAlign(TextAlign.Center)
      .backgroundColor(isSelected ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        if (title === "NY") {
          this.currentLocation = "New York"
        } else {
          this.currentLocation = title
        }
      })
  }
}

interface WeatherHour {
  hour: string
  temp: string
  condition: string
  color: ResourceColor
}

interface WeatherDay {
  day: string
  high: string
  low: string
  condition: string
  color: ResourceColor
}
