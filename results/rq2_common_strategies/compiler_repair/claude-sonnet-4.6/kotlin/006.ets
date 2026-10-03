import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const COLOR_PRIMARY: string = '#2196F3'
const COLOR_SECONDARY: string = '#4CAF50'
const COLOR_TERTIARY: string = '#FF9800'
const COLOR_BACKGROUND: string = '#F5F7FA'
const COLOR_SURFACE: string = '#FFFFFF'
const COLOR_SURFACE_VARIANT: string = '#E8F5E9'
const COLOR_ON_SURFACE: string = '#263238'
const COLOR_ON_BACKGROUND: string = '#263238'
const COLOR_ON_PRIMARY: string = '#FFFFFF'

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
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: COLOR_TERTIARY },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: COLOR_TERTIARY },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: COLOR_TERTIARY },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: COLOR_SECONDARY },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: COLOR_SECONDARY },
  ]

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: COLOR_TERTIARY },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: COLOR_SECONDARY },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: COLOR_SECONDARY },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: COLOR_TERTIARY },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: COLOR_TERTIARY },
  ]

  @Builder
  TopBar() {
    Row() {
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(COLOR_BACKGROUND)
  }

  @Builder
  BottomBar() {
    Row() {
      Button('NY')
        .height(32)
        .width(80)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(this.currentLocation === 'New York' ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
        .fontColor(this.currentLocation === 'New York' ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
        .borderRadius(10)
        .onClick(() => {
          this.currentLocation = 'New York'
        })

      Button('London')
        .height(32)
        .width(80)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(this.currentLocation === 'London' ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
        .fontColor(this.currentLocation === 'London' ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
        .borderRadius(10)
        .onClick(() => {
          this.currentLocation = 'London'
        })

      Button('Tokyo')
        .height(32)
        .width(80)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(this.currentLocation === 'Tokyo' ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
        .fontColor(this.currentLocation === 'Tokyo' ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
        .borderRadius(10)
        .onClick(() => {
          this.currentLocation = 'Tokyo'
        })
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius({ topLeft: 14, topRight: 14 })
    .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })
  }

  @Builder
  CurrentWeatherCard() {
    Column() {
      Column({ space: 6 }) {
        Text(this.currentLocation)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)

        Text(this.temperature)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)

        Text(this.condition)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99263238')

        Row() {
          Column({ space: 4 }) {
            Text('Feels like')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#99263238')
            Text(this.feelsLike)
              .fontSize(12)
              .fontColor(COLOR_ON_SURFACE)
          }
          .alignItems(HorizontalAlign.Center)

          Column({ space: 4 }) {
            Text('Humidity')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#99263238')
            Text(this.humidity)
              .fontSize(12)
              .fontColor(COLOR_ON_SURFACE)
          }
          .alignItems(HorizontalAlign.Center)

          Column({ space: 4 }) {
            Text('Wind')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#99263238')
            Text(this.wind)
              .fontSize(12)
              .fontColor(COLOR_ON_SURFACE)
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(14)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(14)
    .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })
  }

  @Builder
  HourlyForecastSection() {
    Column({ space: 14 }) {
      Text('Hourly Forecast')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_BACKGROUND)

      Scroll() {
        Row({ space: 6 }) {
          ForEach(this.hourlyForecast, (hour: WeatherHour) => {
            Column({ space: 4 }) {
              Text(hour.hour)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE)
              Circle({ width: 20, height: 20 })
                .fill(hour.color)
              Text(hour.temp)
                .fontSize(12)
                .fontColor(COLOR_ON_SURFACE)
            }
            .width(70)
            .padding(6)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
          })
        }
        .padding({ left: 2, right: 2, top: 2, bottom: 2 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
  }

  @Builder
  WeeklyForecastSection() {
    Column({ space: 14 }) {
      Text('7-Day Forecast')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_BACKGROUND)

      Column({ space: 6 }) {
        ForEach(this.weeklyForecast, (day: WeatherDay) => {
          Row() {
            Text(day.day)
              .fontSize(12)
              .fontColor(COLOR_ON_SURFACE)
              .width(40)

            Circle({ width: 16, height: 16 })
              .fill(day.color)

            Row({ space: 6 }) {
              Text(day.high)
                .fontSize(12)
                .fontColor(COLOR_ON_SURFACE)
              Text(day.low)
                .fontSize(12)
                .fontColor('#80263238')
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(6)
          .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
        })
      }
    }
  }

  @Builder
  ExtraInfoCard() {
    Row() {
      Column({ space: 4 }) {
        Text('UV Index')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99263238')
        Text('Moderate')
          .fontSize(12)
          .fontColor(COLOR_ON_SURFACE)
      }
      .alignItems(HorizontalAlign.Start)

      Column({ space: 4 }) {
        Text('Sunset')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99263238')
        Text('7:45 PM')
          .fontSize(12)
          .fontColor(COLOR_ON_SURFACE)
      }
      .alignItems(HorizontalAlign.Start)

      Column({ space: 4 }) {
        Text('Visibility')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99263238')
        Text('10 mi')
          .fontSize(12)
          .fontColor(COLOR_ON_SURFACE)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .borderRadius(10)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 14 }) {
          this.CurrentWeatherCard()
          this.HourlyForecastSection()
          this.WeeklyForecastSection()
          this.ExtraInfoCard()
        }
        .padding({ left: 10, right: 10, bottom: 20 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}