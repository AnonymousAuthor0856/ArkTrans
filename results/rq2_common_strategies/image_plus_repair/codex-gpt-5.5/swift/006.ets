@Entry
@Component
struct WeatherPage {
  @State currentLocation: string = 'New York'

  private readonly primaryBlue: string = '#2196F3'
  private readonly primaryGreen: string = '#4CAF50'
  private readonly primaryOrange: string = '#FF9800'
  private readonly pageBackgroundColor: string = '#F5F7FA'
  private readonly surfaceVariant: string = '#E8F5E8'
  private readonly textPrimary: string = '#263238'
  private readonly textSecondary: string = '#687277'

  private readonly hourlyForecast: Array<WeatherHour> = [
    { hour: 'Now', temp: '72°', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', color: '#4CAF50' }
  ]

  private readonly weeklyForecast: Array<WeatherDay> = [
    { day: 'Today', high: '76°', low: '62°', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', color: '#4CAF50' },
    { day: 'Thu', high: '73°', low: '59°', color: '#2196F3' },
    { day: 'Fri', high: '75°', low: '61°', color: '#FF9800' },
    { day: 'Sat', high: '77°', low: '63°', color: '#FF9800' }
  ]

  build() {
    Stack() {
      Scroll() {
        Column({ space: 18 }) {
          this.currentWeatherCard()
          this.hourlyForecastSection()
          this.weeklyForecastSection()
          this.additionalInfoCard()
        }
        .width('100%')
        .padding({ left: 14, right: 14, bottom: 92 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')

      Column() {
        Blank()
          .height(1)
        Row({ space: 0 }) {
          this.locationButton('NY', 'New York')
          Blank()
            .layoutWeight(1)
          this.locationButton('London', 'London')
          Blank()
            .layoutWeight(1)
          this.locationButton('Tokyo', 'Tokyo')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ left: 28, right: 28, top: 14, bottom: 14 })
        .backgroundColor(Color.White)
      }
      .width('100%')
      .align(Alignment.Bottom)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: '#1F29371F', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackgroundColor)
  }

  @Builder
  currentWeatherCard() {
    Column({ space: 10 }) {
      Text(this.currentLocation)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textPrimary)

      Text('72°')
        .fontSize(64)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textPrimary)
        .margin({ top: 8, bottom: 8 })

      Text('Sunny')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textSecondary)

      Row() {
        this.infoItem('Feels like', '74°')
        Blank().layoutWeight(1)
        this.infoItem('Humidity', '45%')
        Blank().layoutWeight(1)
        this.infoItem('Wind', '5 mph')
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .margin({ top: 6 })
    }
    .width('100%')
    .padding({ top: 30, bottom: 32, left: 18, right: 18 })
    .backgroundColor(Color.White)
    .borderRadius(14)
    .shadow({ radius: 5, color: '#1F29371F', offsetY: 2 })
  }

  @Builder
  hourlyForecastSection() {
    Column({ space: 10 }) {
      Text('Hourly Forecast')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textPrimary)
        .width('100%')

      Scroll() {
        Row({ space: 10 }) {
          ForEach(this.hourlyForecast, (item: WeatherHour) => {
            Column({ space: 8 }) {
              Text(item.hour)
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Circle()
                .width(40)
                .height(40)
                .fill(item.color)

              Text(item.temp)
                .fontSize(24)
                .fontColor(this.textPrimary)
            }
            .width(164)
            .height(142)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(Color.White)
            .borderRadius(18)
            .shadow({ radius: 3, color: '#1F29371A', offsetY: 1 })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  weeklyForecastSection() {
    Column({ space: 10 }) {
      Text('7-Day Forecast')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textPrimary)
        .width('100%')

      Column({ space: 12 }) {
        ForEach(this.weeklyForecast, (item: WeatherDay) => {
          Row() {
            Text(item.day)
              .fontSize(24)
              .fontColor(this.textPrimary)
              .width(95)

            Circle()
              .width(32)
              .height(32)
              .fill(item.color)

            Blank().layoutWeight(1)

            Text(item.high)
              .fontSize(24)
              .fontColor(this.textPrimary)

            Text(item.low)
              .fontSize(24)
              .fontColor(this.textSecondary)
              .margin({ left: 10 })
          }
          .width('100%')
          .height(88)
          .padding({ left: 28, right: 28 })
          .backgroundColor(Color.White)
          .borderRadius(12)
          .shadow({ radius: 3, color: '#1F29371A', offsetY: 1 })
        })
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  additionalInfoCard() {
    Row() {
      this.infoItem('UV Index', 'Moderate')
      Blank().layoutWeight(1)
      this.infoItem('Sunset', '7:45 PM')
      Blank().layoutWeight(1)
      this.infoItem('Visibility', '10 mi')
    }
    .width('100%')
    .padding(18)
    .backgroundColor(this.surfaceVariant)
    .borderRadius(10)
    .shadow({ radius: 3, color: '#1F29371A', offsetY: 1 })
  }

  @Builder
  infoItem(title: string, value: string) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textSecondary)
        .textAlign(TextAlign.Center)
      Text(value)
        .fontSize(24)
        .fontColor(this.textPrimary)
        .textAlign(TextAlign.Center)
    }
  }

  @Builder
  locationButton(title: string, location: string) {
    Button(title)
      .fontSize(20)
      .fontColor(this.currentLocation === location ? Color.White : this.textPrimary)
      .width(160)
      .height(64)
      .backgroundColor(this.currentLocation === location ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(18)
      .onClick(() => {
        this.currentLocation = location
      })
  }
}

interface WeatherHour {
  hour: string
  temp: string
  color: string
}

interface WeatherDay {
  day: string
  high: string
  low: string
  color: string
}
