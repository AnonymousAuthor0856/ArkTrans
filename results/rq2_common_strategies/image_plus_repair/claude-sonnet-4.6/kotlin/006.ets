// Index.ets

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

// Color tokens
const colorPrimary: ResourceColor = '#FF2196F3'
const colorSecondary: ResourceColor = '#FF4CAF50'
const colorTertiary: ResourceColor = '#FFFF9800'
const colorBackground: ResourceColor = '#FFF5F7FA'
const colorSurface: ResourceColor = '#FFFFFFFF'
const colorSurfaceVariant: ResourceColor = '#FFE8F5E8'
const colorOnBackground: ResourceColor = '#FF263238'
const colorOnSurface: ResourceColor = '#FF263238'
const colorOnSurface70: ResourceColor = '#B3263238'
const colorOnSurface50: ResourceColor = '#80263238'
const colorOnPrimary: ResourceColor = '#FFFFFFFF'

@Entry
@Component
struct Index {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', colorTertiary),
    new WeatherHour('1 PM', '74°', 'Sunny', colorTertiary),
    new WeatherHour('2 PM', '75°', 'Sunny', colorTertiary),
    new WeatherHour('3 PM', '76°', 'Cloudy', colorPrimary),
    new WeatherHour('4 PM', '74°', 'Cloudy', colorPrimary),
    new WeatherHour('5 PM', '72°', 'Rain', colorSecondary),
    new WeatherHour('6 PM', '70°', 'Rain', colorSecondary),
  ]

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', colorTertiary),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', colorPrimary),
    new WeatherDay('Tue', '72°', '58°', 'Rain', colorSecondary),
    new WeatherDay('Wed', '70°', '56°', 'Rain', colorSecondary),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', colorPrimary),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', colorTertiary),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', colorTertiary),
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(colorOnBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: 14 }) {
          // Current weather card
          Column({ space: 6 }) {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(colorOnSurface)

            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(colorOnSurface)

            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(colorOnSurface70)

            Row() {
              Column({ space: 4 }) {
                Text('Feels like')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(colorOnSurface70)
                Text(this.feelsLike)
                  .fontSize(12)
                  .fontColor(colorOnSurface)
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)

              Column({ space: 4 }) {
                Text('Humidity')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(colorOnSurface70)
                Text(this.humidity)
                  .fontSize(12)
                  .fontColor(colorOnSurface)
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)

              Column({ space: 4 }) {
                Text('Wind')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(colorOnSurface70)
                Text(this.wind)
                  .fontSize(12)
                  .fontColor(colorOnSurface)
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)
            }
            .width('100%')
          }
          .width('100%')
          .padding(14)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(colorSurface)
          .borderRadius(14)
          .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 2 })

          // Hourly Forecast label
          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnBackground)
            .width('100%')

          // Hourly forecast scroll
          Scroll() {
            Row({ space: 6 }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                Column({ space: 4 }) {
                  Text(hour.hour)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(colorOnSurface)

                  Circle({ width: 20, height: 20 })
                    .fill(hour.color)

                  Text(hour.temp)
                    .fontSize(12)
                    .fontColor(colorOnSurface)
                }
                .width(70)
                .padding(6)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor(colorSurface)
                .borderRadius(10)
                .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
              })
            }
            .padding({ left: 2, right: 2, top: 2, bottom: 2 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // 7-Day Forecast label
          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnBackground)
            .width('100%')

          // Weekly forecast
          Column({ space: 6 }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              Row() {
                Text(day.day)
                  .fontSize(12)
                  .fontColor(colorOnSurface)
                  .width(40)

                Circle({ width: 16, height: 16 })
                  .fill(day.color)

                Blank()

                Row({ space: 6 }) {
                  Text(day.high)
                    .fontSize(12)
                    .fontColor(colorOnSurface)
                  Text(day.low)
                    .fontSize(12)
                    .fontColor(colorOnSurface50)
                }
              }
              .width('100%')
              .padding(10)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(colorSurface)
              .borderRadius(6)
              .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
            })
          }
          .width('100%')

          // UV/Sunset/Visibility card
          Row() {
            Column({ space: 4 }) {
              Text('UV Index')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnSurface70)
              Text('Moderate')
                .fontSize(12)
                .fontColor(colorOnSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Column({ space: 4 }) {
              Text('Sunset')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnSurface70)
              Text('7:45 PM')
                .fontSize(12)
                .fontColor(colorOnSurface)
            }
            .alignItems(HorizontalAlign.Center)

            Blank()

            Column({ space: 4 }) {
              Text('Visibility')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorOnSurface70)
              Text('10 mi')
                .fontSize(12)
                .fontColor(colorOnSurface)
            }
            .alignItems(HorizontalAlign.End)
          }
          .width('100%')
          .padding(10)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(colorSurfaceVariant)
          .borderRadius(10)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })

          // Bottom padding
          Row().height(80)
        }
        .padding({ left: 10, right: 10 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')

      // Bottom bar
      Row({ space: 0 }) {
        Button('NY')
          .height(32)
          .width(80)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'New York' ? colorOnPrimary : colorOnSurface)
          .backgroundColor(this.currentLocation === 'New York' ? colorPrimary : colorSurfaceVariant)
          .borderRadius(10)
          .onClick(() => {
            this.currentLocation = 'New York'
          })

        Button('London')
          .height(32)
          .width(80)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'London' ? colorOnPrimary : colorOnSurface)
          .backgroundColor(this.currentLocation === 'London' ? colorPrimary : colorSurfaceVariant)
          .borderRadius(10)
          .onClick(() => {
            this.currentLocation = 'London'
          })

        Button('Tokyo')
          .height(32)
          .width(80)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'Tokyo' ? colorOnPrimary : colorOnSurface)
          .backgroundColor(this.currentLocation === 'Tokyo' ? colorPrimary : colorSurfaceVariant)
          .borderRadius(10)
          .onClick(() => {
            this.currentLocation = 'Tokyo'
          })
      }
      .width('100%')
      .padding(10)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(colorSurface)
      .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 })
      .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}