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

// Mock AppTokens to resolve compilation errors since the module is missing
const AppTokens = {
  Colors: {
    tertiary: '#FFD700',
    primary: '#2196F3',
    secondary: '#4CAF50',
    onBackground: '#263238',
    onSurface: '#263238',
    surface: '#FFFFFF',
    background: '#F5F5F5',
    surfaceVariant: '#E0E0E0',
    onPrimary: '#FFFFFF'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32
  }
}

@Entry
@Component
struct RootScreen {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: AppTokens.Colors.secondary },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: AppTokens.Colors.secondary }
  ]

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: AppTokens.Colors.secondary },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: AppTokens.Colors.secondary },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: AppTokens.Colors.primary },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: AppTokens.Colors.tertiary },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: AppTokens.Colors.tertiary }
  ]

  build() {
    Column() {
      // Top Bar
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: AppTokens.Spacing.md })

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Current Weather Card
          Row() {
            Column({ space: AppTokens.Spacing.sm }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTokens.Colors.onSurface)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#B3263238') // 70% opacity approx

              Row({ space: AppTokens.Spacing.xl }) {
                Column({ space: AppTokens.Spacing.xs }) {
                  Text('Feels like').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#B3263238')
                  Text(this.feelsLike).fontSize(12).fontColor(AppTokens.Colors.onSurface)
                }
                Column({ space: AppTokens.Spacing.xs }) {
                  Text('Humidity').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#B3263238')
                  Text(this.humidity).fontSize(12).fontColor(AppTokens.Colors.onSurface)
                }
                Column({ space: AppTokens.Spacing.xs }) {
                  Text('Wind').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#B3263238')
                  Text(this.wind).fontSize(12).fontColor(AppTokens.Colors.onSurface)
                }
              }.justifyContent(FlexAlign.SpaceEvenly).width('100%')
            }
            .alignItems(HorizontalAlign.Center)
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(14)
          .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })

          // Hourly Forecast
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Hourly Forecast')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onBackground)

            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(this.hourlyForecast, (item: WeatherHour) => {
                Column({ space: AppTokens.Spacing.xs }) {
                  Text(item.hour).fontSize(10).fontWeight(FontWeight.Medium).fontColor(AppTokens.Colors.onSurface)
                  Circle({ width: 20, height: 20 }).fill(item.color)
                  Text(item.temp).fontSize(12).fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Center)
                .width(70)
                .padding(AppTokens.Spacing.sm)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(10)
                .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
                .margin({ right: AppTokens.Spacing.sm })
              })
            }
            .width('100%')
          }

          // 7-Day Forecast
          Column({ space: AppTokens.Spacing.sm }) {
            Text('7-Day Forecast')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onBackground)

            ForEach(this.weeklyForecast, (item: WeatherDay) => {
              Row() {
                Text(item.day).fontSize(12).fontColor(AppTokens.Colors.onSurface).width(40)
                Circle({ width: 16, height: 16 }).fill(item.color)
                Blank()
                Row({ space: AppTokens.Spacing.sm }) {
                  Text(item.high).fontSize(12).fontColor(AppTokens.Colors.onSurface)
                  Text(item.low).fontSize(12).fontColor('#80263238') // 50% opacity
                }
              }
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(6)
              .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
            })
          }

          // Extra Info Card
          Row() {
            Column({ space: AppTokens.Spacing.xs }) {
              Text('UV Index').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#B3263238')
              Text('Moderate').fontSize(12).fontColor(AppTokens.Colors.onSurface)
            }
            Column({ space: AppTokens.Spacing.xs }) {
              Text('Sunset').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#B3263238')
              Text('7:45 PM').fontSize(12).fontColor(AppTokens.Colors.onSurface)
            }
            Column({ space: AppTokens.Spacing.xs }) {
              Text('Visibility').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#B3263238')
              Text('10 mi').fontSize(12).fontColor(AppTokens.Colors.onSurface)
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(10)
          .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, bottom: 80 })
      }
      .layoutWeight(1)

      // Bottom Navigation
      Row({ space: AppTokens.Spacing.md }) {
        Button('NY')
          .backgroundColor(this.currentLocation === 'New York' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === 'New York' ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .height(32)
          .width(80)
          .borderRadius(10)
          .onClick(() => { this.currentLocation = 'New York' })

        Button('London')
          .backgroundColor(this.currentLocation === 'London' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === 'London' ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .height(32)
          .width(80)
          .borderRadius(10)
          .onClick(() => { this.currentLocation = 'London' })

        Button('Tokyo')
          .backgroundColor(this.currentLocation === 'Tokyo' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === 'Tokyo' ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .height(32)
          .width(80)
          .borderRadius(10)
          .onClick(() => { this.currentLocation = 'Tokyo' })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}