// WeatherHour.ets
class WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: ResourceColor;

  constructor(hour: string, temp: string, condition: string, color: ResourceColor) {
    this.hour = hour;
    this.temp = temp;
    this.condition = condition;
    this.color = color;
  }
}

// WeatherDay.ets
class WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: ResourceColor;

  constructor(day: string, high: string, low: string, condition: string, color: ResourceColor) {
    this.day = day;
    this.high = high;
    this.low = low;
    this.condition = condition;
    this.color = color;
  }
}

// WeatherInfoItem.ets
@Component
struct WeatherInfoItem {
  @Prop title: string;
  @Prop value: string;
  @Prop textPrimary: ResourceColor;

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textPrimary)
        .opacity(0.7)
      Text(this.value)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.textPrimary)
    }
  }
}

// LocationButton.ets
@Component
struct LocationButton {
  @Prop title: string;
  @Prop isSelected: boolean;
  @Prop textPrimary: ResourceColor;
  @Prop primaryBlue: ResourceColor;
  @Prop surfaceVariant: ResourceColor;
  onAction: () => void;

  build() {
    Button(this.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? Color.White : this.textPrimary)
      .width(80)
      .height(32)
      .backgroundColor(this.isSelected ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        this.onAction();
      })
  }
}

// ContentView.ets
@Entry
@Component
struct ContentView {
  @State currentLocation: string = "New York";
  @State temperature: string = "72°";
  @State condition: string = "Sunny";
  @State feelsLike: string = "74°";
  @State humidity: string = "45%";
  @State wind: string = "5 mph";

  // Define color constants to match design
  private primaryBlue: ResourceColor = "#2196F3";
  private primaryGreen: ResourceColor = "#4CAF50";
  private primaryOrange: ResourceColor = "#FF9800";
  private backgroundColor: ResourceColor = "#F5F7FA";
  private surfaceColor: ResourceColor = "#FFFFFF";
  private surfaceVariant: ResourceColor = "#E8F5E8";
  private textPrimary: ResourceColor = "#263238";

  private hourlyForecast: WeatherHour[] = [
    new WeatherHour("Now", "72°", "Sunny", "#FF9800"),
    new WeatherHour("1 PM", "74°", "Sunny", "#FF9800"),
    new WeatherHour("2 PM", "75°", "Sunny", "#FF9800"),
    new WeatherHour("3 PM", "76°", "Cloudy", "#2196F3"),
    new WeatherHour("4 PM", "74°", "Cloudy", "#2196F3"),
    new WeatherHour("5 PM", "72°", "Rain", "#4CAF50"),
    new WeatherHour("6 PM", "70°", "Rain", "#4CAF50")
  ];

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay("Today", "76°", "62°", "Sunny", "#FF9800"),
    new WeatherDay("Mon", "74°", "60°", "Cloudy", "#2196F3"),
    new WeatherDay("Tue", "72°", "58°", "Rain", "#4CAF50"),
    new WeatherDay("Wed", "70°", "56°", "Rain", "#4CAF50"),
    new WeatherDay("Thu", "73°", "59°", "Cloudy", "#2196F3"),
    new WeatherDay("Fri", "75°", "61°", "Sunny", "#FF9800"),
    new WeatherDay("Sat", "77°", "63°", "Sunny", "#FF9800")
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.backgroundColor)

      // Main Content
      Column({ space: 0 }) {
        // Header
        Text("Weather")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .padding({ top: 44, bottom: 18 })

        // Scrollable Content
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
                .fontColor(this.textPrimary)
                .opacity(0.7)

              Row() {
                WeatherInfoItem({ title: "Feels like", value: this.feelsLike, textPrimary: this.textPrimary })
                Blank()
                WeatherInfoItem({ title: "Humidity", value: this.humidity, textPrimary: this.textPrimary })
                Blank()
                WeatherInfoItem({ title: "Wind", value: this.wind, textPrimary: this.textPrimary })
              }
              .width('100%')
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: 2 })

            // Hourly Forecast
            Column({ space: 10 }) {
              Text("Hourly Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Scroll() {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (item: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(item.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.textPrimary)

                      Circle({ width: 20, height: 20 })
                        .fill(item.color)

                      Text(item.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                  })
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            // 7-Day Forecast
            Column({ space: 10 }) {
              Text("7-Day Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (item: WeatherDay) => {
                  Row() {
                    Text(item.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor(this.textPrimary)
                      .width(40)
                      .textAlign(TextAlign.Start)

                    Circle({ width: 16, height: 16 })
                      .fill(item.color)

                    Blank()

                    Row({ space: 6 }) {
                      Text(item.high)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)

                      Text(item.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)
                        .opacity(0.7)
                    }
                  }
                  .width('100%')
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                })
              }
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')

            // Additional Info Card
            Row() {
              WeatherInfoItem({ title: "UV Index", value: "Moderate", textPrimary: this.textPrimary })
              Blank()
              WeatherInfoItem({ title: "Sunset", value: "7:45 PM", textPrimary: this.textPrimary })
              Blank()
              WeatherInfoItem({ title: "Visibility", value: "10 mi", textPrimary: this.textPrimary })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          }
          .padding({ left: 14, right: 14, bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .height('100%')

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
              onAction: () => { this.currentLocation = "New York" }
            })

            Blank()

            LocationButton({
              title: "London",
              isSelected: this.currentLocation === "London",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              onAction: () => { this.currentLocation = "London" }
            })

            Blank()

            LocationButton({
              title: "Tokyo",
              isSelected: this.currentLocation === "Tokyo",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              onAction: () => { this.currentLocation = "Tokyo" }
            })

            Blank()
          }
          .width('100%')
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(this.surfaceColor)
          .borderRadius({ topLeft: 14, topRight: 14 })
          .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
        }
      }
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}