class AppTokens {
  static readonly Colors = {
    primaryBlue: '#FF2196F3',
    primaryGreen: '#FF4CAF50',
    primaryOrange: '#FFFF9800',
    background: '#FFF5F7FA',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE8F5E8',
    textPrimary: '#FF263238',
    textSecondary: '#B3263238'
  }
}

class WeatherHour {
  hour: string
  temp: string
  condition: string
  color: string

  constructor(hour: string, temp: string, condition: string, color: string) {
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
  color: string

  constructor(day: string, high: string, low: string, condition: string, color: string) {
    this.day = day
    this.high = high
    this.low = low
    this.condition = condition
    this.color = color
  }
}

@Entry
@Component
struct ContentView {
  @State currentLocation: string = 'New York'

  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', AppTokens.Colors.primaryOrange),
    new WeatherHour('1 PM', '74°', 'Sunny', AppTokens.Colors.primaryOrange),
    new WeatherHour('2 PM', '75°', 'Sunny', AppTokens.Colors.primaryOrange),
    new WeatherHour('3 PM', '76°', 'Cloudy', AppTokens.Colors.primaryBlue),
    new WeatherHour('4 PM', '74°', 'Cloudy', AppTokens.Colors.primaryBlue),
    new WeatherHour('5 PM', '72°', 'Rain', AppTokens.Colors.primaryGreen),
    new WeatherHour('6 PM', '70°', 'Rain', AppTokens.Colors.primaryGreen)
  ]

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', AppTokens.Colors.primaryOrange),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', AppTokens.Colors.primaryBlue),
    new WeatherDay('Tue', '72°', '58°', 'Rain', AppTokens.Colors.primaryGreen),
    new WeatherDay('Wed', '70°', '56°', 'Rain', AppTokens.Colors.primaryGreen),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', AppTokens.Colors.primaryBlue),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', AppTokens.Colors.primaryOrange),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', AppTokens.Colors.primaryOrange)
  ]

  build() {
    Column() {
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.textPrimary)
        .margin({ top: 44, bottom: 18 })

      Scroll() {
        Column() {
          Column() {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.textPrimary)
            Text('72°')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.textPrimary)
            Text('Sunny')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.textSecondary)

            Row() {
              WeatherInfoItem({ title: 'Feels like', value: '74°' })
              WeatherInfoItem({ title: 'Humidity', value: '45%' })
              WeatherInfoItem({ title: 'Wind', value: '5 mph' })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ left: 20, right: 20 })
            .margin({ top: 10 })
          }
          .padding(18)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: 2 })
          .alignItems(HorizontalAlign.Center)

          Column() {
            Text('Hourly Forecast')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.textPrimary)

            Scroll() {
              Row() {
                ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                  Column() {
                    Text(hour.hour)
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.textPrimary)
                    Row()
                      .width(20)
                      .height(20)
                      .borderRadius(10)
                      .backgroundColor(hour.color)
                    Text(hour.temp)
                      .fontSize(12)
                      .fontColor(AppTokens.Colors.textPrimary)
                  }
                  .width(70)
                  .padding(6)
                  .borderRadius(10)
                  .backgroundColor(AppTokens.Colors.surface)
                  .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                  .alignItems(HorizontalAlign.Center)
                  .margin({ right: 6 })
                })
              }
            }
            .scrollDirection(Axis.Horizontal)
            .scrollBar(BarState.Off)
            .margin({ top: 10 })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 18 })

          Column() {
            Text('7-Day Forecast')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.textPrimary)

            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              Row() {
                Text(day.day)
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.textPrimary)
                  .width(40)
                Row()
                  .width(16)
                  .height(16)
                  .borderRadius(8)
                  .backgroundColor(day.color)
                Row()
                  .layoutWeight(1)
                Text(day.high)
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.textPrimary)
                Text(day.low)
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.textSecondary)
                  .margin({ left: 6 })
              }
              .width('100%')
              .padding(14)
              .borderRadius(6)
              .backgroundColor(AppTokens.Colors.surface)
              .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
              .alignItems(VerticalAlign.Center)
              .margin({ top: 6 })
            })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 18 })

          Row() {
            WeatherInfoItem({ title: 'UV Index', value: 'Moderate' })
            WeatherInfoItem({ title: 'Sunset', value: '7:45 PM' })
            WeatherInfoItem({ title: 'Visibility', value: '10 mi' })
          }
          .width('100%')
          .padding(18)
          .borderRadius(10)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 18 })
        }
        .padding({ left: 14, right: 14, bottom: 80 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Text('NY')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'New York' ? AppTokens.Colors.surface : AppTokens.Colors.textPrimary)
          .width(80)
          .height(32)
          .textAlign(TextAlign.Center)
          .borderRadius(10)
          .backgroundColor(this.currentLocation === 'New York' ? AppTokens.Colors.primaryBlue : AppTokens.Colors.surfaceVariant)
          .onClick(() => {
            this.currentLocation = 'New York'
          })

        Text('London')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'London' ? AppTokens.Colors.surface : AppTokens.Colors.textPrimary)
          .width(80)
          .height(32)
          .textAlign(TextAlign.Center)
          .borderRadius(10)
          .backgroundColor(this.currentLocation === 'London' ? AppTokens.Colors.primaryBlue : AppTokens.Colors.surfaceVariant)
          .onClick(() => {
            this.currentLocation = 'London'
          })

        Text('Tokyo')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'Tokyo' ? AppTokens.Colors.surface : AppTokens.Colors.textPrimary)
          .width(80)
          .height(32)
          .textAlign(TextAlign.Center)
          .borderRadius(10)
          .backgroundColor(this.currentLocation === 'Tokyo' ? AppTokens.Colors.primaryBlue : AppTokens.Colors.surfaceVariant)
          .onClick(() => {
            this.currentLocation = 'Tokyo'
          })
      }
      .width('100%')
      .padding({ top: 14, bottom: 14 })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct WeatherInfoItem {
  @Prop title: string
  @Prop value: string

  build() {
    Column() {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.textSecondary)
      Text(this.value)
        .fontSize(12)
        .fontColor(AppTokens.Colors.textPrimary)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}