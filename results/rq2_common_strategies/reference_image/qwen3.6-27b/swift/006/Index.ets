import { BusinessError } from '@kit.BasicServicesKit';

// Data Models
interface WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: string;
}

interface WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: string;
}

@Entry
@Component
struct ContentView {
  @State currentLocation: string = "New York";
  @State temperature: string = "72°";
  @State condition: string = "Sunny";
  @State feelsLike: string = "74°";
  @State humidity: string = "45%";
  @State wind: string = "5 mph";

  // Color Constants
  private primaryBlue: string = '#2196F3';
  private primaryGreen: string = '#4CAF50';
  private primaryOrange: string = '#FF9800';
  private backgroundColor: string = '#F5F7FA';
  private surfaceColor: string = '#FFFFFF';
  private surfaceVariant: string = '#E8F5E8';
  private textPrimary: string = '#263238';
  private textSecondary: string = '#607D8B'; // Approximated opacity of textPrimary

  private hourlyForecast: WeatherHour[] = [
    { hour: "Now", temp: "72°", condition: "Sunny", color: this.primaryOrange },
    { hour: "1 PM", temp: "74°", condition: "Sunny", color: this.primaryOrange },
    { hour: "2 PM", temp: "75°", condition: "Sunny", color: this.primaryOrange },
    { hour: "3 PM", temp: "76°", condition: "Cloudy", color: this.primaryBlue },
    { hour: "4 PM", temp: "74°", condition: "Cloudy", color: this.primaryBlue },
    { hour: "5 PM", temp: "72°", condition: "Rain", color: this.primaryGreen },
    { hour: "6 PM", temp: "70°", condition: "Rain", color: this.primaryGreen }
  ];

  private weeklyForecast: WeatherDay[] = [
    { day: "Today", high: "76°", low: "62°", condition: "Sunny", color: this.primaryOrange },
    { day: "Mon", high: "74°", low: "60°", condition: "Cloudy", color: this.primaryBlue },
    { day: "Tue", high: "72°", low: "58°", condition: "Rain", color: this.primaryGreen },
    { day: "Wed", high: "70°", low: "56°", condition: "Rain", color: this.primaryGreen },
    { day: "Thu", high: "73°", low: "59°", condition: "Cloudy", color: this.primaryBlue },
    { day: "Fri", high: "75°", low: "61°", condition: "Sunny", color: this.primaryOrange },
    { day: "Sat", high: "77°", low: "63°", condition: "Sunny", color: this.primaryOrange }
  ];

  build() {
    Column() {
      // Header
      Text("Weather")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textPrimary)
        .padding({ top: 44, bottom: 18 })
        .width('100%')
        .textAlign(TextAlign.Center)

      // Main Content Scrollable Area
      Scroll() {
        Column({ space: 18 }) {
          // Current Weather Card
          this.CurrentWeatherCard()

          // Hourly Forecast
          this.HourlyForecastSection()

          // 7-Day Forecast
          this.WeeklyForecastSection()

          // Additional Info Card
          this.AdditionalInfoCard()
          
          // Bottom padding for scroll view to not hide content behind bottom bar
          Blank().height(80)
        }
        .padding({ left: 14, right: 14 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
    .statusBarMode(StatusBarMode.Custom)
    .statusBarColor(this.backgroundColor)
  }

  @Builder
  CurrentWeatherCard() {
    Column({ space: 10 }) {
      Text(this.currentLocation)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
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
        this.WeatherInfoItem(title: "Feels like", value: this.feelsLike)
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          this.WeatherInfoItem(title: "Humidity", value: this.humidity)
        }
        this.WeatherInfoItem(title: "Wind", value: this.wind)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 20, right: 20 })
    }
    .padding(18)
    .backgroundColor(this.surfaceColor)
    .borderRadius(14)
    .shadow({ radius: 5, color: 'rgba(0, 0, 0, 0.12)', offsetX: 0, offsetY: 2 })
  }

  @Builder
  WeatherInfoItem({ title: string, value: string }) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textSecondary)
      Text(value)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.textPrimary)
    }
  }

  @Builder
  HourlyForecastSection() {
    Column({ space: 10 }) {
      Text("Hourly Forecast")
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.textPrimary)
        .alignSelf(ItemAlign.Start)

      Scroll() {
        Row({ space: 6 }) {
          ForEach(this.hourlyForecast, (item: WeatherHour) => {
            Column({ space: 6 }) {
              Text(item.hour)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Circle()
                .fill(item.color)
                .width(20)
                .height(20)

              Text(item.temp)
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
                .fontColor(this.textPrimary)
            }
            .width(70)
            .padding(6)
            .backgroundColor(this.surfaceColor)
            .borderRadius(10)
            .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: 1 })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
  }

  @Builder
  WeeklyForecastSection() {
    Column({ space: 10 }) {
      Text("7-Day Forecast")
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.textPrimary)
        .alignSelf(ItemAlign.Start)

      Column({ space: 6 }) {
        ForEach(this.weeklyForecast, (item: WeatherDay) => {
          Row() {
            Text(item.day)
              .fontSize(12)
              .fontWeight(FontWeight.Regular)
              .fontColor(this.textPrimary)
              .width(40)
              .textAlign(TextAlign.Start)

            Circle()
              .fill(item.color)
              .width(16)
              .height(16)

            Flex({ justifyContent: FlexAlign.End }) {
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
          }
          .padding(14)
          .backgroundColor(this.surfaceColor)
          .borderRadius(6)
          .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: 1 })
        })
      }
    }
  }

  @Builder
  AdditionalInfoCard() {
    Row() {
      this.WeatherInfoItem(title: "UV Index", value: "Moderate")
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        this.WeatherInfoItem(title: "Sunset", value: "7:45 PM")
      }
      this.WeatherInfoItem(title: "Visibility", value: "10 mi")
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(18)
    .backgroundColor(this.surfaceVariant)
    .borderRadius(10)
    .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomBar() {
    Column() {
      Row() {
        Flex({ justifyContent: FlexAlign.SpaceAround }) {
          Button("NY")
            .type(ButtonType.Normal)
            .backgroundColor(this.currentLocation === "New York" ? this.primaryBlue : this.surfaceVariant)
            .fontColor(this.currentLocation === "New York" ? '#FFFFFF' : this.textPrimary)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .width(80)
            .height(32)
            .borderRadius(10)
            .onClick(() => {
              this.currentLocation = "New York";
            })

          Button("London")
            .type(ButtonType.Normal)
            .backgroundColor(this.currentLocation === "London" ? this.primaryBlue : this.surfaceVariant)
            .fontColor(this.currentLocation === "London" ? '#FFFFFF' : this.textPrimary)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .width(80)
            .height(32)
            .borderRadius(10)
            .onClick(() => {
              this.currentLocation = "London";
            })

          Button("Tokyo")
            .type(ButtonType.Normal)
            .backgroundColor(this.currentLocation === "Tokyo" ? this.primaryBlue : this.surfaceVariant)
            .fontColor(this.currentLocation === "Tokyo" ? '#FFFFFF' : this.textPrimary)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .width(80)
            .height(32)
            .borderRadius(10)
            .onClick(() => {
              this.currentLocation = "Tokyo";
            })
        }
      }
      .padding({ top: 14, bottom: 14 })
      .backgroundColor(this.surfaceColor)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: 'rgba(0, 0, 0, 0.12)', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
  }
}