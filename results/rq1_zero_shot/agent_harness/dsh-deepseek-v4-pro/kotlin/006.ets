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

const Colors = {
  primary: '#2196F3',
  secondary: '#4CAF50',
  tertiary: '#FF9800',
  background: '#F5F7FA',
  surface: '#FFFFFF',
  surfaceVariant: '#E8F5E8',
  outline: '#E0E0E0',
  success: '#4CAF50',
  warning: '#FF9800',
  error: '#F44336',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#263238',
  onSurface: '#263238'
}

const Spacing = {
  xs: 4, sm: 6, md: 10, lg: 14, xl: 18, xxl: 24, xxxl: 32
}

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
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: Colors.tertiary },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: Colors.tertiary },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: Colors.tertiary },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: Colors.primary },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: Colors.primary },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: Colors.secondary },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: Colors.secondary }
  ]
  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: Colors.tertiary },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: Colors.primary },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: Colors.secondary },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: Colors.secondary },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: Colors.primary },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: Colors.tertiary },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: Colors.tertiary }
  ]

  build() {
    Column() {
      Row() {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Column({ space: Spacing.sm }) {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .opacity(0.7)
            Row() {
              Column({ space: Spacing.xs }) {
                Text('Feels like')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .opacity(0.7)
                Text(this.feelsLike)
                  .fontSize(12)
                  .fontColor(Colors.onSurface)
              }
              Column({ space: Spacing.xs }) {
                Text('Humidity')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .opacity(0.7)
                Text(this.humidity)
                  .fontSize(12)
                  .fontColor(Colors.onSurface)
              }
              Column({ space: Spacing.xs }) {
                Text('Wind')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .opacity(0.7)
                Text(this.wind)
                  .fontSize(12)
                  .fontColor(Colors.onSurface)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .backgroundColor(Colors.surface)
          .borderRadius(14)
          .padding(Spacing.lg)
          .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })

          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)

          Scroll() {
            Row({ space: Spacing.sm }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                Column({ space: Spacing.xs }) {
                  Text(hour.hour)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Blank()
                    .width(20)
                    .height(20)
                    .backgroundColor(hour.color)
                    .borderRadius(20)
                  Text(hour.temp)
                    .fontSize(12)
                    .fontColor(Colors.onSurface)
                }
                .width(70)
                .backgroundColor(Colors.surface)
                .borderRadius(10)
                .padding(Spacing.sm)
                .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
              }, (hour: WeatherHour) => hour.hour)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)

          Column({ space: Spacing.sm }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              Row() {
                Text(day.day)
                  .fontSize(12)
                  .fontColor(Colors.onSurface)
                  .width(40)
                Blank()
                  .width(16)
                  .height(16)
                  .backgroundColor(day.color)
                  .borderRadius(16)
                Row({ space: Spacing.sm }) {
                  Text(day.high)
                    .fontSize(12)
                    .fontColor(Colors.onSurface)
                  Text(day.low)
                    .fontSize(12)
                    .fontColor(Colors.onSurface)
                    .opacity(0.5)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .backgroundColor(Colors.surface)
              .borderRadius(6)
              .padding(Spacing.md)
              .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (day: WeatherDay) => day.day)
          }
          .width('100%')

          Row() {
            Column({ space: Spacing.xs }) {
              Text('UV Index')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .opacity(0.7)
              Text('Moderate')
                .fontSize(12)
                .fontColor(Colors.onSurface)
            }
            Column({ space: Spacing.xs }) {
              Text('Sunset')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .opacity(0.7)
              Text('7:45 PM')
                .fontSize(12)
                .fontColor(Colors.onSurface)
            }
            Column({ space: Spacing.xs }) {
              Text('Visibility')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .opacity(0.7)
              Text('10 mi')
                .fontSize(12)
                .fontColor(Colors.onSurface)
            }
          }
          .width('100%')
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(10)
          .padding(Spacing.md)
          .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)

      Row() {
        Button('NY')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'New York' ? Colors.onPrimary : Colors.onSurface)
          .backgroundColor(this.currentLocation === 'New York' ? Colors.primary : Colors.surfaceVariant)
          .borderRadius(10)
          .height(32)
          .width(80)
          .onClick(() => { this.currentLocation = 'New York' })
        Button('London')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'London' ? Colors.onPrimary : Colors.onSurface)
          .backgroundColor(this.currentLocation === 'London' ? Colors.primary : Colors.surfaceVariant)
          .borderRadius(10)
          .height(32)
          .width(80)
          .onClick(() => { this.currentLocation = 'London' })
        Button('Tokyo')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'Tokyo' ? Colors.onPrimary : Colors.onSurface)
          .backgroundColor(this.currentLocation === 'Tokyo' ? Colors.primary : Colors.surfaceVariant)
          .borderRadius(10)
          .height(32)
          .width(80)
          .onClick(() => { this.currentLocation = 'Tokyo' })
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .padding(Spacing.md)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 5, color: '#1F000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
