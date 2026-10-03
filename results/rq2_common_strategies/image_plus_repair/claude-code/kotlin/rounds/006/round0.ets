@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  private hourlyForecast: Array<WeatherHour> = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: '#4CAF50' }
  ]

  private weeklyForecast: Array<WeatherDay> = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: '#FF9800' }
  ]

  build() {
    Column() {
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#263238')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 16, bottom: 14 })

      Scroll() {
        Column({ space: 14 }) {
          // Current weather card
          Column({ space: 6 }) {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#263238')

            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#263238')
              .lineHeight(36)

            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('rgba(38, 50, 56, 0.7)')

            Row() {
              Column({ space: 4 }) {
                Text('Feels like')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('rgba(38, 50, 56, 0.7)')
                Text(this.feelsLike)
                  .fontSize(12)
                  .fontColor('#263238')
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)

              Column({ space: 4 }) {
                Text('Humidity')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('rgba(38, 50, 56, 0.7)')
                Text(this.humidity)
                  .fontSize(12)
                  .fontColor('#263238')
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)

              Column({ space: 4 }) {
                Text('Wind')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('rgba(38, 50, 56, 0.7)')
                Text(this.wind)
                  .fontSize(12)
                  .fontColor('#263238')
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)
            }
            .width('100%')
            .margin({ top: 6 })
          }
          .width('100%')
          .padding(14)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#FFFFFF')
          .borderRadius(28)
          .shadow({ radius: 5, color: 'rgba(0, 0, 0, 0.08)', offsetY: 2 })

          // Hourly Forecast
          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#263238')
            .width('100%')

          Scroll() {
            Row({ space: 6 }) {
              ForEach(this.hourlyForecast, (item: WeatherHour) => {
                Column({ space: 4 }) {
                  Text(item.hour)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#263238')
                  Circle({ width: 20, height: 20, fill: item.color })
                  Text(item.temp)
                    .fontSize(12)
                    .fontColor('#263238')
                }
                .width(70)
                .padding(6)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor('#FFFFFF')
                .borderRadius(20)
                .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.06)', offsetY: 1 })
              }, (item: WeatherHour) => item.hour)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // 7-Day Forecast
          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#263238')
            .width('100%')

          Column({ space: 6 }) {
            ForEach(this.weeklyForecast, (item: WeatherDay) => {
              Row() {
                Text(item.day)
                  .fontSize(12)
                  .fontColor('#263238')
                  .width(40)

                Circle({ width: 16, height: 16, fill: item.color })

                Row({ space: 6 }) {
                  Text(item.high)
                    .fontSize(12)
                    .fontColor('#263238')
                  Text(item.low)
                    .fontSize(12)
                    .fontColor('rgba(38, 50, 56, 0.5)')
                }
              }
              .width('100%')
              .padding(10)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.06)', offsetY: 1 })
            }, (item: WeatherDay) => item.day)
          }
          .width('100%')

          // Bottom info card
          Row() {
            Column({ space: 4 }) {
              Text('UV Index')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('rgba(38, 50, 56, 0.7)')
              Text('Moderate')
                .fontSize(12)
                .fontColor('#263238')
            }
            .layoutWeight(1)

            Column({ space: 4 }) {
              Text('Sunset')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('rgba(38, 50, 56, 0.7)')
              Text('7:45 PM')
                .fontSize(12)
                .fontColor('#263238')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)

            Column({ space: 4 }) {
              Text('Visibility')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('rgba(38, 50, 56, 0.7)')
              Text('10 mi')
                .fontSize(12)
                .fontColor('#263238')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.End)
          }
          .width('100%')
          .padding(10)
          .backgroundColor('#E8F5E8')
          .borderRadius(10)
          .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.06)', offsetY: 1 })
        }
        .width('100%')
        .padding({ left: 10, right: 10, bottom: 10 })
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')

      // Bottom bar with location buttons
      Row({ space: 10 }) {
        Button('NY')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .height(32)
          .width(80)
          .backgroundColor(this.currentLocation === 'New York' ? '#2196F3' : '#E8F5E8')
          .fontColor(this.currentLocation === 'New York' ? '#FFFFFF' : '#263238')
          .borderRadius(16)
          .onClick(() => { this.currentLocation = 'New York' })

        Button('London')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .height(32)
          .width(80)
          .backgroundColor(this.currentLocation === 'London' ? '#2196F3' : '#E8F5E8')
          .fontColor(this.currentLocation === 'London' ? '#FFFFFF' : '#263238')
          .borderRadius(16)
          .onClick(() => { this.currentLocation = 'London' })

        Button('Tokyo')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .height(32)
          .width(80)
          .backgroundColor(this.currentLocation === 'Tokyo' ? '#2196F3' : '#E8F5E8')
          .fontColor(this.currentLocation === 'Tokyo' ? '#FFFFFF' : '#263238')
          .borderRadius(16)
          .onClick(() => { this.currentLocation = 'Tokyo' })
      }
      .width('100%')
      .padding({ top: 10, bottom: 20, left: 10, right: 10 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: 'rgba(0, 0, 0, 0.08)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA')
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
