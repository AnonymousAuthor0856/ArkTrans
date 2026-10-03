class AppColors {
  static readonly primary: string = '#2196F3'
  static readonly secondary: string = '#4CAF50'
  static readonly tertiary: string = '#FF9800'
  static readonly background: string = '#F5F7FA'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E8F5E8'
  static readonly outline: string = '#E0E0E0'
  static readonly success: string = '#4CAF50'
  static readonly warning: string = '#FF9800'
  static readonly error: string = '#F44336'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#263238'
  static readonly onSurface: string = '#263238'
  static readonly onSurface70: string = '#B3263238'
  static readonly onSurface50: string = '#80263238'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 18
  static readonly xxl: number = 24
  static readonly xxxl: number = 32
}

class AppRadius {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
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
struct WeatherApp {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', AppColors.tertiary),
    new WeatherHour('1 PM', '74°', 'Sunny', AppColors.tertiary),
    new WeatherHour('2 PM', '75°', 'Sunny', AppColors.tertiary),
    new WeatherHour('3 PM', '76°', 'Cloudy', AppColors.primary),
    new WeatherHour('4 PM', '74°', 'Cloudy', AppColors.primary),
    new WeatherHour('5 PM', '72°', 'Rain', AppColors.secondary),
    new WeatherHour('6 PM', '70°', 'Rain', AppColors.secondary)
  ]

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', AppColors.tertiary),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', AppColors.primary),
    new WeatherDay('Tue', '72°', '58°', 'Rain', AppColors.secondary),
    new WeatherDay('Wed', '70°', '56°', 'Rain', AppColors.secondary),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', AppColors.primary),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', AppColors.tertiary),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', AppColors.tertiary)
  ]

  @Builder
  LabelText(textValue: string) {
    Text(textValue)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .lineHeight(12)
      .letterSpacing(0.2)
  }

  @Builder
  BodyText(textValue: string) {
    Text(textValue)
      .fontSize(12)
      .fontWeight(FontWeight.Regular)
      .lineHeight(16)
      .letterSpacing(0.1)
  }

  @Builder
  HeadlineText(textValue: string) {
    Text(textValue)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .lineHeight(20)
  }

  @Builder
  WeatherDot(sizeValue: number, colorValue: string) {
    Circle()
      .width(sizeValue)
      .height(sizeValue)
      .fill(colorValue)
  }

  @Builder
  MetricItem(label: string, value: string) {
    Column({ space: AppSpacing.xs }) {
      this.LabelText(label)
        .fontColor(AppColors.onSurface70)

      this.BodyText(value)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  CurrentWeatherCard() {
    Column({ space: AppSpacing.sm }) {
      this.HeadlineText(this.currentLocation)
        .fontColor(AppColors.onSurface)

      Text(this.temperature)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .lineHeight(36)
        .fontColor(AppColors.onSurface)

      Text(this.condition)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .lineHeight(18)
        .fontColor(AppColors.onSurface70)

      Row() {
        this.MetricItem('Feels like', this.feelsLike)
        this.MetricItem('Humidity', this.humidity)
        this.MetricItem('Wind', this.wind)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 5,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  HourlyCard(hour: WeatherHour) {
    Column({ space: AppSpacing.xs }) {
      this.LabelText(hour.hour)
        .fontColor(AppColors.onSurface)

      this.WeatherDot(20, hour.color)

      this.BodyText(hour.temp)
        .fontColor(AppColors.onSurface)
    }
    .width(70)
    .padding(AppSpacing.sm)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  WeeklyCard(day: WeatherDay) {
    Row() {
      Text(day.day)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .lineHeight(16)
        .letterSpacing(0.1)
        .fontColor(AppColors.onSurface)
        .width(40)

      this.WeatherDot(16, day.color)

      Row({ space: AppSpacing.sm }) {
        this.BodyText(day.high)
          .fontColor(AppColors.onSurface)

        this.BodyText(day.low)
          .fontColor(AppColors.onSurface50)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.small)
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  InfoColumn(label: string, value: string) {
    Column({ space: AppSpacing.xs }) {
      this.LabelText(label)
        .fontColor(AppColors.onSurface70)

      this.BodyText(value)
        .fontColor(AppColors.onSurface)
    }
  }

  @Builder
  ExtraInfoCard() {
    Row() {
      this.InfoColumn('UV Index', 'Moderate')
      this.InfoColumn('Sunset', '7:45 PM')
      this.InfoColumn('Visibility', '10 mi')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppRadius.medium)
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  LocationButton(label: string, location: string) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .width(80)
      .height(32)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentLocation === location ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(this.currentLocation === location ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(AppRadius.medium)
      .onClick(() => {
        this.currentLocation = location
      })
  }

  @Builder
  BottomBar() {
    Row() {
      this.LocationButton('NY', 'New York')
      this.LocationButton('London', 'London')
      this.LocationButton('Tokyo', 'Tokyo')
    }
    .width('100%')
    .height(52)
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius({
      topLeft: AppRadius.large,
      topRight: AppRadius.large
    })
    .shadow({
      radius: 5,
      color: '#1F000000',
      offsetX: 0,
      offsetY: -2
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Weather')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .lineHeight(24)
            .letterSpacing(-0.2)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Center)
            .margin({ top: 48, bottom: 8 })

          this.CurrentWeatherCard()

          this.HeadlineText('Hourly Forecast')
            .fontColor(AppColors.onBackground)
            .width('100%')
            .margin({ top: 4 })

          Scroll() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                this.HourlyCard(hour)
              }, (hour: WeatherHour) => hour.hour)
            }
            .padding({ bottom: 2 })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          this.HeadlineText('7-Day Forecast')
            .fontColor(AppColors.onBackground)
            .width('100%')
            .margin({ top: 4 })

          Column({ space: AppSpacing.sm }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              this.WeeklyCard(day)
            }, (day: WeatherDay) => day.day)
          }
          .width('100%')

          this.ExtraInfoCard()
            .margin({ bottom: 70 })
        }
        .width('100%')
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}