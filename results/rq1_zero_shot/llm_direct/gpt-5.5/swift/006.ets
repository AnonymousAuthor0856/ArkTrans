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

@Component
struct WeatherInfoItem {
  title: string = ''
  value: string = ''
  textPrimary: ResourceColor = '#263238'

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('rgba(38, 50, 56, 0.7)')

      Text(this.value)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.textPrimary)
    }
  }
}

@Component
struct LocationButton {
  title: string = ''
  isSelected: boolean = false
  textPrimary: ResourceColor = '#263238'
  primaryBlue: ResourceColor = '#2196F3'
  surfaceVariant: ResourceColor = '#E8F5E8'
  action: () => void = () => {
  }

  build() {
    Text(this.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? Color.White : this.textPrimary)
      .textAlign(TextAlign.Center)
      .width(80)
      .height(32)
      .backgroundColor(this.isSelected ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        this.action()
      })
  }
}

@Entry
@Component
struct ContentView {
  @State private currentLocation: string = 'New York'
  @State private temperature: string = '72°'
  @State private condition: string = 'Sunny'
  @State private feelsLike: string = '74°'
  @State private humidity: string = '45%'
  @State private wind: string = '5 mph'

  private readonly primaryBlue: ResourceColor = '#2196F3'
  private readonly primaryGreen: ResourceColor = '#4CAF50'
  private readonly primaryOrange: ResourceColor = '#FF9800'
  private readonly backgroundColor: ResourceColor = '#F5F7FA'
  private readonly surfaceColor: ResourceColor = '#FFFFFF'
  private readonly surfaceVariant: ResourceColor = '#E8F5E8'
  private readonly textPrimary: ResourceColor = '#263238'
  private readonly textSecondary: ResourceColor = 'rgba(38, 50, 56, 0.7)'

  private readonly hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: '#4CAF50' }
  ]

  private readonly weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: '#FF9800' }
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .padding({ top: 44, bottom: 18 })

        Scroll() {
          Column({ space: 18 }) {
            Column({ space: 10 }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(this.textPrimary)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimary)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textSecondary)

              Row({ space: 0 }) {
                WeatherInfoItem({
                  title: 'Feels like',
                  value: this.feelsLike,
                  textPrimary: this.textPrimary
                })

                Blank()

                WeatherInfoItem({
                  title: 'Humidity',
                  value: this.humidity,
                  textPrimary: this.textPrimary
                })

                Blank()

                WeatherInfoItem({
                  title: 'Wind',
                  value: this.wind,
                  textPrimary: this.textPrimary
                })
              }
              .width('100%')
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({
              radius: 5,
              color: 'rgba(0, 0, 0, 0.12)',
              offsetX: 0,
              offsetY: 2
            })

            Column({ space: 10 }) {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(this.textPrimary)
                .width('100%')
                .textAlign(TextAlign.Start)

              Scroll() {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(hour.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.textPrimary)

                      Circle()
                        .width(20)
                        .height(20)
                        .fill(hour.color)

                      Text(hour.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(this.textPrimary)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({
                      radius: 3,
                      color: 'rgba(0, 0, 0, 0.10)',
                      offsetX: 0,
                      offsetY: 1
                    })
                  }, (hour: WeatherHour) => hour.hour)
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Column({ space: 10 }) {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(this.textPrimary)
                .width('100%')
                .textAlign(TextAlign.Start)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (day: WeatherDay) => {
                  Row() {
                    Text(day.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Normal)
                      .fontColor(this.textPrimary)
                      .width(40)
                      .textAlign(TextAlign.Start)

                    Circle()
                      .width(16)
                      .height(16)
                      .fill(day.color)

                    Blank()

                    Row({ space: 6 }) {
                      Text(day.high)
                        .fontSize(12)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(this.textPrimary)

                      Text(day.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(this.textSecondary)
                    }
                  }
                  .width('100%')
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({
                    radius: 3,
                    color: 'rgba(0, 0, 0, 0.10)',
                    offsetX: 0,
                    offsetY: 1
                  })
                }, (day: WeatherDay) => day.day)
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Row({ space: 0 }) {
              WeatherInfoItem({
                title: 'UV Index',
                value: 'Moderate',
                textPrimary: this.textPrimary
              })

              Blank()

              WeatherInfoItem({
                title: 'Sunset',
                value: '7:45 PM',
                textPrimary: this.textPrimary
              })

              Blank()

              WeatherInfoItem({
                title: 'Visibility',
                value: '10 mi',
                textPrimary: this.textPrimary
              })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({
              radius: 3,
              color: 'rgba(0, 0, 0, 0.10)',
              offsetX: 0,
              offsetY: 1
            })
          }
          .width('100%')
          .padding({ left: 14, right: 14, bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column({ space: 0 }) {
        Blank()

        Column({ space: 0 }) {
          Rect()
            .width('100%')
            .height(1)
            .fill(Color.Transparent)

          Row({ space: 0 }) {
            Blank()

            LocationButton({
              title: 'NY',
              isSelected: this.currentLocation === 'New York',
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => {
                this.currentLocation = 'New York'
              }
            })

            Blank()

            LocationButton({
              title: 'London',
              isSelected: this.currentLocation === 'London',
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => {
                this.currentLocation = 'London'
              }
            })

            Blank()

            LocationButton({
              title: 'Tokyo',
              isSelected: this.currentLocation === 'Tokyo',
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => {
                this.currentLocation = 'Tokyo'
              }
            })

            Blank()
          }
          .width('100%')
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(this.surfaceColor)
          .borderRadius({
            topLeft: 14,
            topRight: 14
          })
          .shadow({
            radius: 5,
            color: 'rgba(0, 0, 0, 0.12)',
            offsetX: 0,
            offsetY: -2
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}