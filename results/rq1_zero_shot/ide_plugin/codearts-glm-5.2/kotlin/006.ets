const AppColors = {
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

const AppSpacing = {
  xs: 4,
  sm: 6,
  md: 10,
  lg: 14,
  xl: 18,
  xxl: 24,
  xxxl: 32
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

@Entry
@Component
struct Index {
  @State currentLocation: string = 'New York'
  private temperature: string = '72°'
  private condition: string = 'Sunny'
  private feelsLike: string = '74°'
  private humidity: string = '45%'
  private wind: string = '5 mph'
  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: '#4CAF50' }
  ]
  private weeklyForecast: WeatherDay[] = [
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
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.CurrentWeatherCard()

          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onBackground)

          this.HourlyForecastRow()

          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onBackground)

          this.WeeklyForecastList()

          this.DetailsCard()
        }
        .width('100%')
        .padding({ left: AppSpacing.md, right: AppSpacing.md, bottom: 100 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .align(Alignment.Top)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  CurrentWeatherCard() {
    Column({ space: AppSpacing.sm }) {
      Text(this.currentLocation)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(this.temperature)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Text(this.condition)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3263238')

      Row() {
        Column({ space: AppSpacing.xs }) {
          Text('Feels like')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3263238')
          Text(this.feelsLike)
            .fontSize(12)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)

        Column({ space: AppSpacing.xs }) {
          Text('Humidity')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3263238')
          Text(this.humidity)
            .fontSize(12)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)

        Column({ space: AppSpacing.xs }) {
          Text('Wind')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3263238')
          Text(this.wind)
            .fontSize(12)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HourlyForecastRow() {
    Scroll() {
      Row({ space: AppSpacing.sm }) {
        ForEach(this.hourlyForecast, (h: WeatherHour) => {
          Column({ space: AppSpacing.xs }) {
            Text(h.hour)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
            Column()
              .width(20)
              .height(20)
              .backgroundColor(h.color)
              .borderRadius(10)
            Text(h.temp)
              .fontSize(12)
              .fontColor(AppColors.onSurface)
          }
          .width(70)
          .padding(AppSpacing.sm)
          .backgroundColor(AppColors.surface)
          .borderRadius(10)
          .alignItems(HorizontalAlign.Center)
        }, (h: WeatherHour) => h.hour)
      }
    }
    .scrollDirection(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  WeeklyForecastList() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.weeklyForecast, (d: WeatherDay) => {
        Row() {
          Text(d.day)
            .fontSize(12)
            .fontColor(AppColors.onSurface)
            .width(40)

          Column()
            .width(16)
            .height(16)
            .backgroundColor(d.color)
            .borderRadius(8)

          Row({ space: AppSpacing.sm }) {
            Text(d.high)
              .fontSize(12)
              .fontColor(AppColors.onSurface)
            Text(d.low)
              .fontSize(12)
              .fontColor('#80263238')
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(6)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }, (d: WeatherDay) => d.day)
    }
    .width('100%')
  }

  @Builder
  DetailsCard() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('UV Index')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3263238')
        Text('Moderate')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }

      Column({ space: AppSpacing.xs }) {
        Text('Sunset')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3263238')
        Text('7:45 PM')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }

      Column({ space: AppSpacing.xs }) {
        Text('Visibility')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3263238')
        Text('10 mi')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Button('NY')
        .type(ButtonType.Normal)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentLocation === 'New York' ? AppColors.onPrimary : AppColors.onSurface)
        .backgroundColor(this.currentLocation === 'New York' ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(10)
        .height(32)
        .width(80)
        .onClick(() => {
          this.currentLocation = 'New York'
        })

      Button('London')
        .type(ButtonType.Normal)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentLocation === 'London' ? AppColors.onPrimary : AppColors.onSurface)
        .backgroundColor(this.currentLocation === 'London' ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(10)
        .height(32)
        .width(80)
        .onClick(() => {
          this.currentLocation = 'London'
        })

      Button('Tokyo')
        .type(ButtonType.Normal)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentLocation === 'Tokyo' ? AppColors.onPrimary : AppColors.onSurface)
        .backgroundColor(this.currentLocation === 'Tokyo' ? AppColors.primary : AppColors.surfaceVariant)
        .borderRadius(10)
        .height(32)
        .width(80)
        .onClick(() => {
          this.currentLocation = 'Tokyo'
        })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius({ topLeft: 14, topRight: 14 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}