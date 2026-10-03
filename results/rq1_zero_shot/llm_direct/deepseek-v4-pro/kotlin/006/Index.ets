@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  // AppTokens
  private readonly colors = {
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

  private readonly spacing = {
    xs: 4,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 18,
    xxl: 24,
    xxxl: 32
  }

  private readonly borderRadius = {
    small: 6,
    medium: 10,
    large: 14,
    bottomBar: 14
  }

  private readonly hourlyForecast: Array<WeatherHour> = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: '#4CAF50' }
  ]

  private readonly weeklyForecast: Array<WeatherDay> = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: '#FF9800' }
  ]

  @Builder
  TopBar() {
    Row() {
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .padding({ top: 16, bottom: 8 })
  }

  @Builder
  BottomBar() {
    Row() {
      Button() {
        Text('NY')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'New York' ? this.colors.onPrimary : this.colors.onSurface)
      }
      .height(32)
      .width(80)
      .backgroundColor(this.currentLocation === 'New York' ? this.colors.primary : this.colors.surfaceVariant)
      .borderRadius(this.borderRadius.medium)
      .onClick(() => {
        this.currentLocation = 'New York'
      })

      Button() {
        Text('London')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'London' ? this.colors.onPrimary : this.colors.onSurface)
      }
      .height(32)
      .width(80)
      .backgroundColor(this.currentLocation === 'London' ? this.colors.primary : this.colors.surfaceVariant)
      .borderRadius(this.borderRadius.medium)
      .onClick(() => {
        this.currentLocation = 'London'
      })

      Button() {
        Text('Tokyo')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentLocation === 'Tokyo' ? this.colors.onPrimary : this.colors.onSurface)
      }
      .height(32)
      .width(80)
      .backgroundColor(this.currentLocation === 'Tokyo' ? this.colors.primary : this.colors.surfaceVariant)
      .borderRadius(this.borderRadius.medium)
      .onClick(() => {
        this.currentLocation = 'Tokyo'
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .padding(this.spacing.md)
    .backgroundColor(this.colors.surface)
    .borderRadius({ topLeft: this.borderRadius.bottomBar, topRight: this.borderRadius.bottomBar })
    .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
  }

  @Builder
  CurrentWeatherCard() {
    Column({ space: this.spacing.sm }) {
      Text(this.currentLocation)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)

      Text(this.temperature)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)

      Text(this.condition)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('rgba(38,50,56,0.7)')

      Row() {
        Column({ space: this.spacing.xs }) {
          Text('Feels like')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(38,50,56,0.7)')
          Text(this.feelsLike)
            .fontSize(12)
            .fontColor(this.colors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)

        Column({ space: this.spacing.xs }) {
          Text('Humidity')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(38,50,56,0.7)')
          Text(this.humidity)
            .fontSize(12)
            .fontColor(this.colors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)

        Column({ space: this.spacing.xs }) {
          Text('Wind')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(38,50,56,0.7)')
          Text(this.wind)
            .fontSize(12)
            .fontColor(this.colors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(this.spacing.lg)
    .backgroundColor(this.colors.surface)
    .borderRadius(this.borderRadius.large)
    .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
  }

  @Builder
  HourlyForecastCard(hour: WeatherHour) {
    Column({ space: this.spacing.xs }) {
      Text(hour.hour)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)

      Circle()
        .width(20)
        .height(20)
        .fill(hour.color)

      Text(hour.temp)
        .fontSize(12)
        .fontColor(this.colors.onSurface)
    }
    .width(70)
    .alignItems(HorizontalAlign.Center)
    .padding(this.spacing.sm)
    .backgroundColor(this.colors.surface)
    .borderRadius(this.borderRadius.medium)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
  }

  @Builder
  WeeklyForecastCard(day: WeatherDay) {
    Row() {
      Text(day.day)
        .fontSize(12)
        .fontColor(this.colors.onSurface)
        .width(40)

      Circle()
        .width(16)
        .height(16)
        .fill(day.color)

      Row({ space: this.spacing.sm }) {
        Text(day.high)
          .fontSize(12)
          .fontColor(this.colors.onSurface)
        Text(day.low)
          .fontSize(12)
          .fontColor('rgba(38,50,56,0.5)')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(this.spacing.md)
    .backgroundColor(this.colors.surface)
    .borderRadius(this.borderRadius.small)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
  }

  @Builder
  AdditionalInfoCard() {
    Row() {
      Column({ space: this.spacing.xs }) {
        Text('UV Index')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(38,50,56,0.7)')
        Text('Moderate')
          .fontSize(12)
          .fontColor(this.colors.onSurface)
      }

      Column({ space: this.spacing.xs }) {
        Text('Sunset')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(38,50,56,0.7)')
        Text('7:45 PM')
          .fontSize(12)
          .fontColor(this.colors.onSurface)
      }

      Column({ space: this.spacing.xs }) {
        Text('Visibility')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(38,50,56,0.7)')
        Text('10 mi')
          .fontSize(12)
          .fontColor(this.colors.onSurface)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(this.spacing.md)
    .backgroundColor(this.colors.surfaceVariant)
    .borderRadius(this.borderRadius.medium)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: this.spacing.lg }) {
          this.CurrentWeatherCard()

          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onBackground)
            .width('100%')

          Scroll() {
            Row({ space: this.spacing.sm }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                this.HourlyForecastCard(hour)
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onBackground)
            .width('100%')

          Column({ space: this.spacing.sm }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              this.WeeklyForecastCard(day)
            })
          }
          .width('100%')

          this.AdditionalInfoCard()
        }
        .width('100%')
        .padding({ left: this.spacing.md, right: this.spacing.md, bottom: this.spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
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