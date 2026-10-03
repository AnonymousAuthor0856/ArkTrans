class WeatherHour {
  hour: string
  temp: string
  condition: string
  color: ResourceColor

  constructor(hour: string, temp: string, condition: string, color: ResourceColor) {
    this.hour = hour
    this.temp = temp
    this.condition = condition
    this.color = color
  }
}

class WeatherDay {
  day: string
  high: string
  low: string
  condition: string
  color: ResourceColor

  constructor(day: string, high: string, low: string, condition: string, color: ResourceColor) {
    this.day = day
    this.high = high
    this.low = low
    this.condition = condition
    this.color = color
  }
}

@Component
struct WeatherInfoItem {
  title: string = ''
  value: string = ''
  textPrimary: ResourceColor = '#263238'
  textSecondary: ResourceColor = '#B3263238'

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textSecondary)

      Text(this.value)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.textPrimary)
    }
  }
}

@Component
struct LocationButton {
  title: string = ''
  isSelected: boolean = false
  textPrimary: ResourceColor = '#263238'
  primaryBlue: ResourceColor = '#2196F3'
  surfaceVariant: ResourceColor = '#E8F5E8'
  onTap: () => void = () => {
  }

  build() {
    Text(this.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? Color.White : this.textPrimary)
      .textAlign(TextAlign.Center)
      .width(80)
      .height(32)
      .backgroundColor(this.isSelected ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        this.onTap()
      })
  }
}

@Entry
@Component
struct ContentView {
  @State private currentLocation: string = 'New York'
  @State private temperature: string = '72°'
  @State private condition: string = 'Sunny'
  @State private feelsLike: string = '74°'
  @State private humidity: string = '45%'
  @State private wind: string = '5 mph'

  private primaryBlue: ResourceColor = '#2196F3'
  private primaryGreen: ResourceColor = '#4CAF50'
  private primaryOrange: ResourceColor = '#FF9800'
  private backgroundColor: ResourceColor = '#F5F7FA'
  private surfaceColor: ResourceColor = Color.White
  private surfaceVariant: ResourceColor = '#E8F5E8'
  private textPrimary: ResourceColor = '#263238'
  private textSecondary: ResourceColor = '#B3263238'

  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', '#FF9800'),
    new WeatherHour('1 PM', '74°', 'Sunny', '#FF9800'),
    new WeatherHour('2 PM', '75°', 'Sunny', '#FF9800'),
    new WeatherHour('3 PM', '76°', 'Cloudy', '#2196F3'),
    new WeatherHour('4 PM', '74°', 'Cloudy', '#2196F3'),
    new WeatherHour('5 PM', '72°', 'Rain', '#4CAF50'),
    new WeatherHour('6 PM', '70°', 'Rain', '#4CAF50')
  ]

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', '#FF9800'),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', '#2196F3'),
    new WeatherDay('Tue', '72°', '58°', 'Rain', '#4CAF50'),
    new WeatherDay('Wed', '70°', '56°', 'Rain', '#4CAF50'),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', '#2196F3'),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', '#FF9800'),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', '#FF9800')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .padding({ top: 44, bottom: 18 })

        Scroll() {
          Column({ space: 18 }) {
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

              Row({ space: 0 }) {
                WeatherInfoItem({
                  title: 'Feels like',
                  value: this.feelsLike,
                  textPrimary: this.textPrimary,
                  textSecondary: this.textSecondary
                })

                Blank().layoutWeight(1)

                WeatherInfoItem({
                  title: 'Humidity',
                  value: this.humidity,
                  textPrimary: this.textPrimary,
                  textSecondary: this.textSecondary
                })

                Blank().layoutWeight(1)

                WeatherInfoItem({
                  title: 'Wind',
                  value: this.wind,
                  textPrimary: this.textPrimary,
                  textSecondary: this.textSecondary
                })
              }
              .width('100%')
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ color: '#1F000000', radius: 5, offsetX: 0, offsetY: 2 })

            Column({ space: 10 }) {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
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
                    .shadow({ color: '#1A000000', radius: 3, offsetX: 0, offsetY: 1 })
                  }, (hour: WeatherHour) => hour.hour)
                }
              }
              .width('100%')
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .width('100%')

            Column({ space: 10 }) {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
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

                    Blank().layoutWeight(1)

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
                  .width('100%')
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ color: '#1A000000', radius: 3, offsetX: 0, offsetY: 1 })
                }, (day: WeatherDay) => day.day)
              }
              .width('100%')
            }
            .width('100%')

            Row({ space: 0 }) {
              WeatherInfoItem({
                title: 'UV Index',
                value: 'Moderate',
                textPrimary: this.textPrimary,
                textSecondary: this.textSecondary
              })

              Blank().layoutWeight(1)

              WeatherInfoItem({
                title: 'Sunset',
                value: '7:45 PM',
                textPrimary: this.textPrimary,
                textSecondary: this.textSecondary
              })

              Blank().layoutWeight(1)

              WeatherInfoItem({
                title: 'Visibility',
                value: '10 mi',
                textPrimary: this.textPrimary,
                textSecondary: this.textSecondary
              })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ color: '#1A000000', radius: 3, offsetX: 0, offsetY: 1 })
          }
          .width('100%')
          .padding({ left: 14, right: 14, bottom: 80 })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundColor)

      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Blank().layoutWeight(1)

          LocationButton({
            title: 'NY',
            isSelected: this.currentLocation === 'New York',
            textPrimary: this.textPrimary,
            primaryBlue: this.primaryBlue,
            surfaceVariant: this.surfaceVariant,
            onTap: () => {
              this.currentLocation = 'New York'
            }
          })

          Blank().layoutWeight(1)

          LocationButton({
            title: 'London',
            isSelected: this.currentLocation === 'London',
            textPrimary: this.textPrimary,
            primaryBlue: this.primaryBlue,
            surfaceVariant: this.surfaceVariant,
            onTap: () => {
              this.currentLocation = 'London'
            }
          })

          Blank().layoutWeight(1)

          LocationButton({
            title: 'Tokyo',
            isSelected: this.currentLocation === 'Tokyo',
            textPrimary: this.textPrimary,
            primaryBlue: this.primaryBlue,
            surfaceVariant: this.surfaceVariant,
            onTap: () => {
              this.currentLocation = 'Tokyo'
            }
          })

          Blank().layoutWeight(1)
        }
        .width('100%')
        .padding({ top: 14, bottom: 14 })
        .backgroundColor(this.surfaceColor)
        .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 })
        .shadow({ color: '#1F000000', radius: 5, offsetX: 0, offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}