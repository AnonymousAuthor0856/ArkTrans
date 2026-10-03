@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = "New York"
  @State temperature: string = "72°"
  @State condition: string = "Sunny"
  @State feelsLike: string = "74°"
  @State humidity: string = "45%"
  @State wind: string = "5 mph"

  private readonly primaryBlue: string = "#2196F3"
  private readonly primaryGreen: string = "#4CAF50"
  private readonly primaryOrange: string = "#FF9800"
  private readonly backgroundColor: string = "#F5F7FA"
  private readonly surfaceColor: string = "#FFFFFF"
  private readonly surfaceVariant: string = "#E8F5E8"
  private readonly textPrimary: string = "#263238"
  private readonly textSecondary: string = "#B0B6B8"

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
      Column() {
        Text("Weather")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .margin({ top: 44, bottom: 18 })

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
                WeatherInfoItem({ title: "Feels like", value: this.feelsLike, textPrimary: this.textPrimary })
                Blank()
                WeatherInfoItem({ title: "Humidity", value: this.humidity, textPrimary: this.textPrimary })
                Blank()
                WeatherInfoItem({ title: "Wind", value: this.wind, textPrimary: this.textPrimary })
              }
              .padding({ left: 20, right: 20 })
            }
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: "rgba(0,0,0,0.12)", offsetX: 0, offsetY: 2 })

            // Hourly Forecast
            Column({ space: 10 }) {
              Text("Hourly Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)
                .width("100%")
                .textAlign(TextAlign.Start)

              Scroll(this.scroller)
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .width("100%") {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (item: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(item.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.textPrimary)

                      Circle({ color: item.color, size: 20 })

                      Text(item.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: "rgba(0,0,0,0.1)", offsetX: 0, offsetY: 1 })
                  }, (item: WeatherHour) => item.hour)
                }
              }
            }
            .width("100%")
            .alignItems(HorizontalAlign.Start)

            // 7-Day Forecast
            Column({ space: 10 }) {
              Text("7-Day Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)
                .width("100%")
                .textAlign(TextAlign.Start)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (item: WeatherDay) => {
                  Row() {
                    Text(item.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor(this.textPrimary)
                      .width(40)
                      .textAlign(TextAlign.Start)

                    Circle({ color: item.color, size: 16 })
                      .margin({ left: 8 })

                    Blank()

                    Row({ space: 6 }) {
                      Text(item.high)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)

                      Text(item.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textSecondary)
                    }
                  }
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: "rgba(0,0,0,0.1)", offsetX: 0, offsetY: 1 })
                }, (item: WeatherDay) => item.day)
              }
              .width("100%")
            }
            .width("100%")
            .alignItems(HorizontalAlign.Start)

            // Additional Info Card
            Row() {
              WeatherInfoItem({ title: "UV Index", value: "Moderate", textPrimary: this.textPrimary })
              Blank()
              WeatherInfoItem({ title: "Sunset", value: "7:45 PM", textPrimary: this.textPrimary })
              Blank()
              WeatherInfoItem({ title: "Visibility", value: "10 mi", textPrimary: this.textPrimary })
            }
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: "rgba(0,0,0,0.1)", offsetX: 0, offsetY: 1 })
          }
          .padding({ left: 14, right: 14 })
          .width("100%")
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width("100%")
      .height("100%")

      // Bottom Bar
      Column() {
        Blank()

        Column() {
          Row() {
            Blank()

            LocationButton({
              title: "NY",
              isSelected: this.currentLocation === "New York",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              onClick: () => { this.currentLocation = "New York" }
            })

            Blank()

            LocationButton({
              title: "London",
              isSelected: this.currentLocation === "London",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              onClick: () => { this.currentLocation = "London" }
            })

            Blank()

            LocationButton({
              title: "Tokyo",
              isSelected: this.currentLocation === "Tokyo",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              onClick: () => { this.currentLocation = "Tokyo" }
            })

            Blank()
          }
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(this.surfaceColor)
          .borderRadius({ topLeft: 14, topRight: 14 })
          .shadow({ radius: 5, color: "rgba(0,0,0,0.12)", offsetX: 0, offsetY: -2 })
        }
      }
      .width("100%")
      .height("100%")
    }
    .width("100%")
    .height("100%")
    .backgroundColor(this.backgroundColor)
  }

  private scroller: Scroller = new Scroller()
}

@Component
struct WeatherInfoItem {
  title: string = ""
  value: string = ""
  textPrimary: string = "#263238"

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor("rgba(38,50,56,0.7)")

      Text(this.value)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.textPrimary)
    }
  }
}

@Component
struct LocationButton {
  title: string = ""
  isSelected: boolean = false
  textPrimary: string = "#263238"
  primaryBlue: string = "#2196F3"
  surfaceVariant: string = "#E8F5E8"
  onClick: () => void = () => {}

  build() {
    Button(this.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? "#FFFFFF" : this.textPrimary)
      .width(80)
      .height(32)
      .backgroundColor(this.isSelected ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        this.onClick()
      })
  }
}

@Component
struct Circle {
  color: string = "#FF9800"
  size: number = 20

  build() {
    Stack() {
    }
    .width(this.size)
    .height(this.size)
    .backgroundColor(this.color)
    .borderRadius(this.size / 2)
  }
}

interface WeatherHour {
  hour: string
  temp: string
  condition: string
  color: string
}

interface WeatherDay {
  day: string
  high: string
  low: string
  condition: string
  color: string
}
