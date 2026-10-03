import { Scroller } from '@kit.ArkUI'

@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = "New York"
  @State temperature: string = "72°"
  @State condition: string = "Sunny"
  @State feelsLike: string = "74°"
  @State humidity: string = "45%"
  @State wind: string = "5 mph"

  // Color Constants
  private readonly primaryBlue: string = '#2196F3'
  private readonly primaryGreen: string = '#4CAF50'
  private readonly primaryOrange: string = '#FF9800'
  private readonly backgroundColor: string = '#F5F7FA'
  private readonly surfaceColor: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#E8F5E8'
  private readonly textPrimary: string = '#263238'
  private readonly textSecondary: string = 'rgba(38, 50, 56, 0.7)'

  // Data Models
  interface HourlyForecastItem {
    hour: string
    temp: string
    color: string
  }

  interface WeeklyForecastItem {
    day: string
    high: string
    low: string
    color: string
  }

  // Data Arrays
  private readonly hourlyForecast: HourlyForecastItem[] = [
    { hour: "Now", temp: "72°", color: this.primaryOrange },
    { hour: "1 PM", temp: "74°", color: this.primaryOrange },
    { hour: "2 PM", temp: "75°", color: this.primaryOrange },
    { hour: "3 PM", temp: "76°", color: this.primaryBlue },
    { hour: "4 PM", temp: "74°", color: this.primaryBlue },
    { hour: "5 PM", temp: "72°", color: this.primaryGreen },
    { hour: "6 PM", temp: "70°", color: this.primaryGreen }
  ]

  private readonly weeklyForecast: WeeklyForecastItem[] = [
    { day: "Today", high: "76°", low: "62°", color: this.primaryOrange },
    { day: "Mon", high: "74°", low: "60°", color: this.primaryBlue },
    { day: "Tue", high: "72°", low: "58°", color: this.primaryGreen },
    { day: "Wed", high: "70°", low: "56°", color: this.primaryGreen },
    { day: "Thu", high: "73°", low: "59°", color: this.primaryBlue },
    { day: "Fri", high: "75°", low: "61°", color: this.primaryOrange },
    { day: "Sat", high: "77°", low: "63°", color: this.primaryOrange }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Main Content Column ===
      Column() {
        // Header
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 44, bottom: 18 })

        // Scrollable Area
        Scroll(new Scroller()) {
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
              }.padding({ left: 20, right: 20 })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: 2 })

            // Hourly Forecast Section
            Column({ space: 10 }) {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Scroll(new Scroller(), { scrollBar: BarState.Off }) {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (item: HourlyForecastItem) => {
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
                    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
                  }, (item: HourlyForecastItem) => item.hour)
                }
              }
            }

            // 7-Day Forecast Section
            Column({ space: 10 }) {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (item: WeeklyForecastItem) => {
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
                  .width('100%')
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
                }, (item: WeeklyForecastItem) => item.day)
              }
            }

            // Additional Info Card
            Row() {
              this.WeatherInfoItem("UV Index", "Moderate")
              Blank()
              this.WeatherInfoItem("Sunset", "7:45 PM")
              Blank()
              this.WeatherInfoItem("Visibility", "10 mi")
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
          }
          .padding({ left: 14, right: 14, bottom: 80 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundColor)

      // === Bottom Bar ===
      Column() {
        Divider().color(Color.Transparent).height(1)
        
        Row() {
          Blank()
          
          Button() {
            Text('NY')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentLocation === "New York" ? '#FFF' : this.textPrimary)
          }
          .width(80)
          .height(32)
          .backgroundColor(this.currentLocation === "New York" ? this.primaryBlue : this.surfaceVariant)
          .borderRadius(10)
          .onClick(() => { this.currentLocation = "New York" })

          Blank()

          Button() {
            Text('London')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentLocation === "London" ? '#FFF' : this.textPrimary)
          }
          .width(80)
          .height(32)
          .backgroundColor(this.currentLocation === "London" ? this.primaryBlue : this.surfaceVariant)
          .borderRadius(10)
          .onClick(() => { this.currentLocation = "London" })

          Blank()

          Button() {
            Text('Tokyo')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentLocation === "Tokyo" ? '#FFF' : this.textPrimary)
          }
          .width(80)
          .height(32)
          .backgroundColor(this.currentLocation === "Tokyo" ? this.primaryBlue : this.surfaceVariant)
          .borderRadius(10)
          .onClick(() => { this.currentLocation = "Tokyo" })

          Blank()
        }
        .padding({ top: 14, bottom: 14 })
        .backgroundColor(this.surfaceColor)
      }
      .width('100%')
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  WeatherInfoItem(title: string, value: string) {
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
}