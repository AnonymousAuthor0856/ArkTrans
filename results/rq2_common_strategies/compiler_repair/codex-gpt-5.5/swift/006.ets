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
struct Index {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  private primaryBlue: string = '#2196F3'
  private primaryGreen: string = '#4CAF50'
  private primaryOrange: string = '#FF9800'
  private pageBg: string = '#F5F7FA'
  private surface: string = '#FFFFFF'
  private surfaceVariant: string = '#E8F5E8'
  private textPrimary: string = '#263238'
  private textSecondary: string = '#B3263238'
  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', '#FF9800'),
    new WeatherHour('1 PM', '74°', 'Sunny', '#FF9800'),
    new WeatherHour('2 PM', '75°', 'Sunny', '#FF9800'),
    new WeatherHour('3 PM', '76°', 'Cloudy', '#2196F3'),
    new WeatherHour('4 PM', '74°', 'Cloudy', '#2196F3'),
    new WeatherHour('5 PM', '72°', 'Rain', '#4CAF50'),
    new WeatherHour('6 PM', '70°', 'Rain', '#4CAF50')
  ]
  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', '#FF9800'),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', '#2196F3'),
    new WeatherDay('Tue', '72°', '58°', 'Rain', '#4CAF50'),
    new WeatherDay('Wed', '70°', '56°', 'Rain', '#4CAF50'),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', '#2196F3'),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', '#FF9800'),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', '#FF9800')
  ]

  @Builder
  WeatherInfoItem(title: string, value: string) {
    Column() {
      Text(title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textSecondary)
      Text(value)
        .fontSize(12)
        .fontColor(this.textPrimary)
        .margin({ top: 4 })
    }
  }

  @Builder
  HourCard(hour: WeatherHour) {
    Column() {
      Text(hour.hour)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textPrimary)
      Circle()
        .width(20)
        .height(20)
        .fill(hour.color)
        .margin({ top: 6, bottom: 6 })
      Text(hour.temp)
        .fontSize(12)
        .fontColor(this.textPrimary)
    }
    .width(70)
    .padding(6)
    .backgroundColor(this.surface)
    .borderRadius(10)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .margin({ right: 6 })
  }

  @Builder
  DayRow(day: WeatherDay) {
    Row() {
      Text(day.day)
        .width(40)
        .fontSize(12)
        .fontColor(this.textPrimary)
      Circle()
        .width(16)
        .height(16)
        .fill(day.color)
      Blank()
      Row() {
        Text(day.high)
          .fontSize(12)
          .fontColor(this.textPrimary)
          .margin({ right: 6 })
        Text(day.low)
          .fontSize(12)
          .fontColor(this.textSecondary)
      }
    }
    .width('100%')
    .padding(14)
    .backgroundColor(this.surface)
    .borderRadius(6)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .margin({ bottom: 6 })
  }

  @Builder
  LocationButton(title: string, location: string) {
    Button(title)
      .width(80)
      .height(32)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentLocation === location ? Color.White : this.textPrimary)
      .backgroundColor(this.currentLocation === location ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        this.currentLocation = location
      })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 44, bottom: 18 })

        Scroll() {
          Column() {
            Column() {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimary)
              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimary)
                .margin({ top: 10 })
              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textSecondary)
                .margin({ top: 10 })
              Row() {
                this.WeatherInfoItem('Feels like', this.feelsLike)
                Blank()
                this.WeatherInfoItem('Humidity', this.humidity)
                Blank()
                this.WeatherInfoItem('Wind', this.wind)
              }
              .width('100%')
              .padding({ left: 20, right: 20 })
              .margin({ top: 10 })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surface)
            .borderRadius(14)
            .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })
            .margin({ bottom: 18 })

            Column() {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimary)
                .width('100%')
                .margin({ bottom: 10 })
              Scroll() {
                Row() {
                  ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                    this.HourCard(hour)
                  }, (hour: WeatherHour) => hour.hour)
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')
            .margin({ bottom: 18 })

            Column() {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimary)
                .width('100%')
                .margin({ bottom: 10 })
              ForEach(this.weeklyForecast, (day: WeatherDay) => {
                this.DayRow(day)
              }, (day: WeatherDay) => day.day)
            }
            .width('100%')
            .margin({ bottom: 18 })

            Row() {
              this.WeatherInfoItem('UV Index', 'Moderate')
              Blank()
              this.WeatherInfoItem('Sunset', '7:45 PM')
              Blank()
              this.WeatherInfoItem('Visibility', '10 mi')
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
            .margin({ bottom: 80 })
          }
          .padding({ left: 14, right: 14 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.pageBg)

      Column() {
        Row() {
          Blank()
          this.LocationButton('NY', 'New York')
          Blank()
          this.LocationButton('London', 'London')
          Blank()
          this.LocationButton('Tokyo', 'Tokyo')
          Blank()
        }
        .width('100%')
        .padding({ top: 14, bottom: 14 })
        .backgroundColor(this.surface)
        .border({ radius: 14 })
        .shadow({ radius: 5, color: '#1F000000', offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBg)
  }
}
