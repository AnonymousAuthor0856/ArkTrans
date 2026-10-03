import { BusinessError } from '@kit.BasicServicesKit';

// Data Models
interface WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: Color;
}

interface WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: Color;
}

@Entry
@Component
struct ContentView {
  @State currentLocation: string = "New York"
  @State temperature: string = "72°"
  @State condition: string = "Sunny"
  @State feelsLike: string = "74°"
  @State humidity: string = "45%"
  @State wind: string = "5 mph"

  // Colors
  private primaryBlue: Color = '#2196F3'
  private primaryGreen: Color = '#4CAF50'
  private primaryOrange: Color = '#FF9800'
  private backgroundColor: Color = '#F5F7FA'
  private surfaceColor: Color = '#FFFFFF'
  private surfaceVariant: Color = '#E8F5E8'
  private textPrimary: Color = '#263238'
  private textSecondary: Color = '#263238' // Opacity handled in component

  private hourlyForecast: WeatherHour[] = [
    { hour: "Now", temp: "72°", condition: "Sunny", color: this.primaryOrange },
    { hour: "1 PM", temp: "74°", condition: "Sunny", color: this.primaryOrange },
    { hour: "2 PM", temp: "75°", condition: "Sunny", color: this.primaryOrange },
    { hour: "3 PM", temp: "76°", condition: "Cloudy", color: this.primaryBlue },
    { hour: "4 PM", temp: "74°", condition: "Cloudy", color: this.primaryBlue },
    { hour: "5 PM", temp: "72°", condition: "Rain", color: this.primaryGreen },
    { hour: "6 PM", temp: "70°", condition: "Rain", color: this.primaryGreen }
  ]

  private weeklyForecast: WeatherDay[] = [
    { day: "Today", high: "76°", low: "62°", condition: "Sunny", color: this.primaryOrange },
    { day: "Mon", high: "74°", low: "60°", condition: "Cloudy", color: this.primaryBlue },
    { day: "Tue", high: "72°", low: "58°", condition: "Rain", color: this.primaryGreen },
    { day: "Wed", high: "70°", low: "56°", condition: "Rain", color: this.primaryGreen },
    { day: "Thu", high: "73°", low: "59°", condition: "Cloudy", color: this.primaryBlue },
    { day: "Fri", high: "75°", low: "61°", condition: "Sunny", color: this.primaryOrange },
    { day: "Sat", high: "77°", low: "63°", condition: "Sunny", color: this.primaryOrange }
  ]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.backgroundColor)

      Column() {
        // Header
        Text("Weather")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .padding({ top: 44, bottom: 18 })
          .alignSelf(ItemAlign.Start)
          .margin({ left: 14 })

        // Main Content
        Scroll() {
          Column({ space: 18 }) {
            // Current Weather Card
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
                .fontColor(Color(this.textSecondary).opacity(0.7))

              Row() {
                WeatherInfoItem(
                  title: "Feels like",
                  value: this.feelsLike,
                  textPrimary: this.textPrimary
                )
                Flex().layoutWeight(1)
                WeatherInfoItem(
                  title: "Humidity",
                  value: this.humidity,
                  textPrimary: this.textPrimary
                )
                Flex().layoutWeight(1)
                WeatherInfoItem(
                  title: "Wind",
                  value: this.wind,
                  textPrimary: this.textPrimary
                )
              }
              .padding({ left: 20, right: 20 })
            }
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: '#0000001F', offsetX: 0, offsetY: 2 })

            // Hourly Forecast
            Column({ space: 10 }) {
              Text("Hourly Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(this.textPrimary)
                .alignSelf(ItemAlign.Start)

              Scroll(ScrollDirection.Horizontal) {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(hour.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.textPrimary)

                      Circle()
                        .fill(hour.color)
                        .width(20)
                        .height(20)

                      Text(hour.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: '#0000001A', offsetX: 0, offsetY: 1 })
                  })
                }
              }
              .scrollBar(BarState.Off)
            }

            // 7-Day Forecast
            Column({ space: 10 }) {
              Text("7-Day Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(this.textPrimary)
                .alignSelf(ItemAlign.Start)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (day: WeatherDay) => {
                  Row() {
                    Text(day.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor(this.textPrimary)
                      .width(40)
                      .textAlign(TextAlign.Start)

                    Circle()
                      .fill(day.color)
                      .width(16)
                      .height(16)

                    Flex().layoutWeight(1)

                    Row({ space: 6 }) {
                      Text(day.high)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(this.textPrimary)

                      Text(day.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(Color(this.textSecondary).opacity(0.7))
                    }
                  }
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: '#0000001A', offsetX: 0, offsetY: 1 })
                })
              }
            }

            // Additional Info Card
            Row() {
              WeatherInfoItem(
                title: "UV Index",
                value: "Moderate",
                textPrimary: this.textPrimary
              )
              Flex().layoutWeight(1)
              WeatherInfoItem(
                title: "Sunset",
                value: "7:45 PM",
                textPrimary: this.textPrimary
              )
              Flex().layoutWeight(1)
              WeatherInfoItem(
                title: "Visibility",
                value: "10 mi",
                textPrimary: this.textPrimary
              )
            }
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: '#0000001A', offsetX: 0, offsetY: 1 })
          }
          .padding({ left: 14, right: 14, bottom: 80 })
        }
        .layoutWeight(1)
      }

      // Bottom Bar
      Column() {
        Flex().layoutWeight(1)

        Column() {
          // Separator line simulation if needed, though background handles it mostly
          
          Row() {
            Flex().layoutWeight(1)
            
            LocationButton(
              title: "NY",
              isSelected: this.currentLocation === "New York",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => { this.currentLocation = "New York" }
            )
            
            Flex().layoutWeight(1)
            
            LocationButton(
              title: "London",
              isSelected: this.currentLocation === "London",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => { this.currentLocation = "London" }
            )
            
            Flex().layoutWeight(1)
            
            LocationButton(
              title: "Tokyo",
              isSelected: this.currentLocation === "Tokyo",
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => { this.currentLocation = "Tokyo" }
            )
            
            Flex().layoutWeight(1)
          }
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(this.surfaceColor)
          .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 })
          .shadow({ radius: 5, color: '#0000001F', offsetX: 0, offsetY: -2 })
        }
      }
      .width('100%')
      .position({ x: 0, y: 0 })
      .alignContent(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct WeatherInfoItem {
  title: string
  value: string
  textPrimary: Color

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color(this.textPrimary).opacity(0.7))
      
      Text(this.value)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.textPrimary)
    }
  }
}

@Component
struct LocationButton {
  title: string
  isSelected: boolean
  textPrimary: Color
  primaryBlue: Color
  surfaceVariant: Color
  action: () => void

  build() {
    Button() {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Color.White : this.textPrimary)
    }
    .width(80)
    .height(32)
    .backgroundColor(this.isSelected ? this.primaryBlue : this.surfaceVariant)
    .borderRadius(10)
    .onClick(() => {
      this.action()
    })
  }
}