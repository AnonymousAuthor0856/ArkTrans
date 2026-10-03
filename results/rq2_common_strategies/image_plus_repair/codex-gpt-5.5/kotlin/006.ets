interface ColorTokens {
  background: string
  surface: string
  surfaceVariant: string
  text: string
  muted: string
  faint: string
  outline: string
  blue: string
  green: string
  orange: string
}

const COLORS: ColorTokens = {
  background: '#F5F7FA',
  surface: '#FFFFFF',
  surfaceVariant: '#E8F5E8',
  text: '#263238',
  muted: '#687278',
  faint: '#98A0A5',
  outline: '#E0E0E0',
  blue: '#2196F3',
  green: '#4CAF50',
  orange: '#FF9800'
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

@Entry
@Component
struct Index {
  @State selectedLocation: string = 'New York'

  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', color: COLORS.orange },
    { hour: '1 PM', temp: '74°', color: COLORS.orange },
    { hour: '2 PM', temp: '75°', color: COLORS.orange },
    { hour: '3 PM', temp: '76°', color: COLORS.blue },
    { hour: '4 PM', temp: '74°', color: COLORS.blue },
    { hour: '5 PM', temp: '72°', color: COLORS.green },
    { hour: '6 PM', temp: '70°', color: COLORS.green }
  ]

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', color: COLORS.orange },
    { day: 'Mon', high: '74°', low: '60°', color: COLORS.blue },
    { day: 'Tue', high: '72°', low: '58°', color: COLORS.green },
    { day: 'Wed', high: '70°', low: '56°', color: COLORS.green },
    { day: 'Thu', high: '73°', low: '59°', color: COLORS.blue },
    { day: 'Fri', high: '75°', low: '61°', color: COLORS.orange },
    { day: 'Sat', high: '77°', low: '63°', color: COLORS.orange }
  ]

  @Builder
  private weatherSummary() {
    Column() {
      Text(this.selectedLocation)
        .fontSize(31)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .margin({ bottom: 8 })

      Text('72°')
        .fontSize(64)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)
        .lineHeight(70)

      Text('Sunny')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.muted)
        .margin({ top: 4, bottom: 18 })

      Row() {
        this.metric('Feels like', '74°')
        this.metric('Humidity', '45%')
        this.metric('Wind', '5 mph')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ top: 28, bottom: 25, left: 16, right: 16 })
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private metric(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.muted)
        .margin({ bottom: 8 })
      Text(value)
        .fontSize(24)
        .fontColor(COLORS.text)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private hourlyCard(hour: WeatherHour) {
    Column() {
      Text(hour.hour)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.text)
        .alignSelf(ItemAlign.Start)

      Circle()
        .width(40)
        .height(40)
        .fill(hour.color)
        .margin({ top: 10, bottom: 10 })

      Text(hour.temp)
        .fontSize(24)
        .fontColor(COLORS.text)
        .alignSelf(ItemAlign.Start)
    }
    .width(140)
    .height(132)
    .padding({ top: 13, bottom: 11, left: 13, right: 13 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(COLORS.surface)
    .borderRadius(19)
    .shadow({ radius: 4, color: '#24000000', offsetY: 2, offsetX: 0 })
  }

  @Builder
  private dayRow(day: WeatherDay) {
    Row() {
      Text(day.day)
        .fontSize(24)
        .fontColor(COLORS.text)
        .width(100)

      Circle()
        .width(32)
        .height(32)
        .fill(day.color)

      Row() {
        Text(day.high)
          .fontSize(23)
          .fontColor(COLORS.text)
        Text(day.low)
          .fontSize(23)
          .fontColor(COLORS.faint)
          .margin({ left: 16 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(74)
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLORS.surface)
    .borderRadius(15)
    .shadow({ radius: 4, color: '#22000000', offsetY: 2, offsetX: 0 })
  }

  @Builder
  private locationButton(label: string, value: string) {
    Button(label)
      .width(160)
      .height(64)
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedLocation === value ? '#FFFFFF' : COLORS.text)
      .backgroundColor(this.selectedLocation === value ? COLORS.blue : COLORS.surfaceVariant)
      .borderRadius(20)
      .onClick(() => {
        this.selectedLocation = value
      })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Blank()
            .width(34)
          Text('Weather')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.text)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
          Blank()
            .width(34)
        }
        .width('100%')
        .height(110)
        .padding({ top: 32 })
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: 28 }) {
            Column() {
              this.weatherSummary()
            }
            .width('100%')
            .backgroundColor(COLORS.surface)
            .borderRadius(28)
            .shadow({ radius: 7, color: '#25000000', offsetY: 3, offsetX: 0 })

            Text('Hourly Forecast')
              .width('100%')
              .fontSize(31)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.text)

            Scroll() {
              Row({ space: 11 }) {
                ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                  this.hourlyCard(hour)
                }, (hour: WeatherHour) => hour.hour)
              }
              .padding({ left: 1, right: 1, top: 2, bottom: 4 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Text('7-Day Forecast')
              .width('100%')
              .fontSize(31)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.text)

            Column({ space: 12 }) {
              ForEach(this.weeklyForecast, (day: WeatherDay) => {
                this.dayRow(day)
              }, (day: WeatherDay) => day.day)
            }
            .width('100%')

            Row() {
              Column() {
                Text('UV Index')
                  .fontSize(18)
                  .fontColor(COLORS.muted)
                Text('Moderate')
                  .fontSize(21)
                  .fontColor(COLORS.text)
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Sunset')
                  .fontSize(18)
                  .fontColor(COLORS.muted)
                Text('7:45 PM')
                  .fontSize(21)
                  .fontColor(COLORS.text)
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Visibility')
                  .fontSize(18)
                  .fontColor(COLORS.muted)
                Text('10 mi')
                  .fontSize(21)
                  .fontColor(COLORS.text)
                  .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding({ top: 18, bottom: 18, left: 18, right: 18 })
            .justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(COLORS.surfaceVariant)
            .borderRadius(18)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 132 })
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(COLORS.background)

      Row() {
        this.locationButton('NY', 'New York')
        this.locationButton('London', 'London')
        this.locationButton('Tokyo', 'Tokyo')
      }
      .width('100%')
      .height(104)
      .padding({ left: 20, right: 20, top: 18, bottom: 18 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F1FAFF')
      .borderRadius({ topLeft: 26, topRight: 26 })
      .shadow({ radius: 10, color: '#16000000', offsetY: -2, offsetX: 0 })
    }
    .width('100%')
    .height('100%')
  }
}
