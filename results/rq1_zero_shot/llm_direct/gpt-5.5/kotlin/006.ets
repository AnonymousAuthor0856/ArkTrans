interface ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number
}

interface TextStyleSpec {
  fontSize: number
  fontWeight: FontWeight | number | string
  lineHeight: number
  letterSpacing: number
}

interface WeatherHour {
  hour: string
  temp: string
  condition: string
  color: ResourceColor
}

interface WeatherDay {
  day: string
  high: string
  low: string
  condition: string
  color: ResourceColor
}

class AppTokens {
  static readonly Colors = {
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
    onSurface: '#263238',
    onSurface70: '#B3263238',
    onSurface50: '#80263238'
  }

  static readonly TypographyTokens = {
    display: { fontSize: 20, fontWeight: FontWeight.Bold, lineHeight: 24, letterSpacing: -0.2 } as TextStyleSpec,
    headline: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 20, letterSpacing: 0 } as TextStyleSpec,
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18, letterSpacing: 0 } as TextStyleSpec,
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16, letterSpacing: 0.1 } as TextStyleSpec,
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 12, letterSpacing: 0.2 } as TextStyleSpec
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
    bottomBar: 14
  }

  static readonly Spacing = {
    xs: 4,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 18,
    xxl: 24,
    xxxl: 32
  }

  static readonly ElevationMapping = {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.1 } as ShadowSpec,
    level2: { elevation: 2, radius: 5, dy: 2, opacity: 0.12 } as ShadowSpec,
    level3: { elevation: 4, radius: 8, dy: 3, opacity: 0.15 } as ShadowSpec,
    level4: { elevation: 6, radius: 12, dy: 4, opacity: 0.18 } as ShadowSpec
  }
}

@Component
struct StyleText {
  text: string = ''
  style: TextStyleSpec = AppTokens.TypographyTokens.body
  color: ResourceColor = AppTokens.Colors.onSurface
  widthValue?: Length

  build() {
    Text(this.text)
      .fontSize(this.style.fontSize)
      .fontWeight(this.style.fontWeight)
      .lineHeight(this.style.lineHeight)
      .letterSpacing(this.style.letterSpacing)
      .fontColor(this.color)
      .width(this.widthValue)
  }
}

@Component
struct WeatherMetric {
  label: string = ''
  value: string = ''

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      StyleText({
        text: this.label,
        style: AppTokens.TypographyTokens.label,
        color: AppTokens.Colors.onSurface70
      })

      StyleText({
        text: this.value,
        style: AppTokens.TypographyTokens.body,
        color: AppTokens.Colors.onSurface
      })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoMetric {
  label: string = ''
  value: string = ''

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      StyleText({
        text: this.label,
        style: AppTokens.TypographyTokens.label,
        color: AppTokens.Colors.onSurface70
      })

      StyleText({
        text: this.value,
        style: AppTokens.TypographyTokens.body,
        color: AppTokens.Colors.onSurface
      })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct MainActivity {
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

  @Builder
  LocationButton(label: string, location: string) {
    Button(label, { type: ButtonType.Normal })
      .width(80)
      .height(32)
      .borderRadius(AppTokens.Shapes.medium)
      .backgroundColor(this.currentLocation === location ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .fontColor(this.currentLocation === location ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .fontSize(AppTokens.TypographyTokens.label.fontSize)
      .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
      .padding(0)
      .onClick(() => {
        this.currentLocation = location
      })
  }

  @Builder
  CurrentWeatherCard() {
    Column({ space: AppTokens.Spacing.sm }) {
      StyleText({
        text: this.currentLocation,
        style: AppTokens.TypographyTokens.headline,
        color: AppTokens.Colors.onSurface
      })

      Text(this.temperature)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .lineHeight(36)
        .fontColor(AppTokens.Colors.onSurface)

      StyleText({
        text: this.condition,
        style: AppTokens.TypographyTokens.title,
        color: AppTokens.Colors.onSurface70
      })

      Row() {
        WeatherMetric({ label: 'Feels like', value: this.feelsLike })
        WeatherMetric({ label: 'Humidity', value: this.humidity })
        WeatherMetric({ label: 'Wind', value: this.wind })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: '#1F000000',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }

  @Builder
  HourlyForecastItem(hour: WeatherHour) {
    Column({ space: AppTokens.Spacing.xs }) {
      StyleText({
        text: hour.hour,
        style: AppTokens.TypographyTokens.label,
        color: AppTokens.Colors.onSurface
      })

      Circle()
        .width(20)
        .height(20)
        .fill(hour.color)

      StyleText({
        text: hour.temp,
        style: AppTokens.TypographyTokens.body,
        color: AppTokens.Colors.onSurface
      })
    }
    .width(70)
    .padding(AppTokens.Spacing.sm)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }

  @Builder
  WeeklyForecastItem(day: WeatherDay) {
    Row() {
      StyleText({
        text: day.day,
        style: AppTokens.TypographyTokens.body,
        color: AppTokens.Colors.onSurface,
        widthValue: 40
      })

      Circle()
        .width(16)
        .height(16)
        .fill(day.color)

      Row({ space: AppTokens.Spacing.sm }) {
        StyleText({
          text: day.high,
          style: AppTokens.TypographyTokens.body,
          color: AppTokens.Colors.onSurface
        })

        StyleText({
          text: day.low,
          style: AppTokens.TypographyTokens.body,
          color: AppTokens.Colors.onSurface50
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }

  @Builder
  ExtraInfoCard() {
    Row() {
      InfoMetric({ label: 'UV Index', value: 'Moderate' })
      InfoMetric({ label: 'Sunset', value: '7:45 PM' })
      InfoMetric({ label: 'Visibility', value: '10 mi' })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }

  build() {
    Column() {
      Row() {
        StyleText({
          text: 'Weather',
          style: AppTokens.TypographyTokens.display,
          color: AppTokens.Colors.onBackground
        })
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.Transparent)

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          this.CurrentWeatherCard()

          StyleText({
            text: 'Hourly Forecast',
            style: AppTokens.TypographyTokens.headline,
            color: AppTokens.Colors.onBackground
          })
          .width('100%')

          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                this.HourlyForecastItem(hour)
              }, (hour: WeatherHour) => hour.hour)
            }
            .padding({
              top: AppTokens.Spacing.xs,
              bottom: AppTokens.Spacing.xs
            })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          StyleText({
            text: '7-Day Forecast',
            style: AppTokens.TypographyTokens.headline,
            color: AppTokens.Colors.onBackground
          })
          .width('100%')

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              this.WeeklyForecastItem(day)
            }, (day: WeatherDay) => day.day)
          }
          .width('100%')

          this.ExtraInfoCard()
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.md,
          right: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.lg
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        this.LocationButton('NY', 'New York')
        this.LocationButton('London', 'London')
        this.LocationButton('Tokyo', 'Tokyo')
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius({
        topLeft: AppTokens.Shapes.bottomBar,
        topRight: AppTokens.Shapes.bottomBar
      })
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: '#1F000000',
        offsetX: 0,
        offsetY: -AppTokens.ElevationMapping.level2.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}