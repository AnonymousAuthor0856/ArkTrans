@Entry
@Component
struct ContentView {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  // 定义颜色常量以匹配设计
  private primaryBlue: ResourceColor = '#2196F3' // #2196F3
  private primaryGreen: ResourceColor = '#4CAF50' // #4CAF50
  private primaryOrange: ResourceColor = '#FF9800' // #FF9800
  private bgColor: ResourceColor = '#F5F7FA' // #F5F7FA
  private surfaceColor: ResourceColor = '#FFFFFF'
  private surfaceVariant: ResourceColor = '#E8F5E8' // #E8F5E8
  private textPrimary: ResourceColor = '#263238' // #263238
  private textSecondary: ResourceColor = '#B3263238' // textPrimary.opacity(0.7)

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

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.bgColor)

      // Main Content
      Column() {
        // Header
        Text('Weather')
          .fontSize(20)
          .fontWeight(700)
          .fontColor(this.textPrimary)
          .padding({ top: 44 })
          .padding({ bottom: 18 })

        // Main Content
        Scroll() {
          Column({ space: 18 }) {
            // Current Weather Card
            Column({ space: 10 }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(600)
                .fontColor(this.textPrimary)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(700)
                .fontColor(this.textPrimary)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(500)
                .fontColor(this.textSecondary)

              Row() {
                WeatherInfoItem({ title: 'Feels like', value: this.feelsLike, textPrimary: this.textPrimary })
                Blank()
                WeatherInfoItem({ title: 'Humidity', value: this.humidity, textPrimary: this.textPrimary })
                Blank()
                WeatherInfoItem({ title: 'Wind', value: this.wind, textPrimary: this.textPrimary })
              }
              .padding({ left: 20, right: 20 })
            }
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: 2 })

            // Hourly Forecast
            Column({ space: 10 }) {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(600)
                .fontColor(this.textPrimary)

              Scroll() {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(hour.hour)
                        .fontSize(10)
                        .fontWeight(500)
                        .fontColor(this.textPrimary)

                      Circle({ width: 20, height: 20 })
                        .fill(hour.color)

                      Text(hour.temp)
                        .fontSize(12)
                        .fontWeight(400)
                        .fontColor(this.textPrimary)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                  }, (hour: WeatherHour) => hour.hour)
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .alignItems(HorizontalAlign.Start)

            // 7-Day Forecast
            Column({ space: 10 }) {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(600)
                .fontColor(this.textPrimary)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (day: WeatherDay) => {
                  Row() {
                    Text(day.day)
                      .fontSize(12)
                      .fontWeight(400)
                      .fontColor(this.textPrimary)
                      .width(40)
                      .textAlign(TextAlign.Start)

                    Circle({ width: 16, height: 16 })
                      .fill(day.color)

                    Blank()

                    Row({ space: 6 }) {
                      Text(day.high)
                        .fontSize(12)
                        .fontWeight(400)
                        .fontColor(this.textPrimary)

                      Text(day.low)
                        .fontSize(12)
                        .fontWeight(400)
                        .fontColor(this.textSecondary)
                    }
                  }
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                }, (day: WeatherDay) => day.day)
              }
            }
            .alignItems(HorizontalAlign.Start)

            // Additional Info Card
            Row() {
              WeatherInfoItem({ title: 'UV Index', value: 'Moderate', textPrimary: this.textPrimary })
              Blank()
              WeatherInfoItem({ title: 'Sunset', value: '7:45 PM', textPrimary: this.textPrimary })
              Blank()
              WeatherInfoItem({ title: 'Visibility', value: '10 mi', textPrimary: this.textPrimary })
            }
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          }
          .padding({ left: 14, right: 14 })
          .padding({ bottom: 80 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()

        Column() {
          Rect({ width: '100%', height: 1 })
            .fill(Color.Transparent)

          Row() {
            Blank()
            LocationTabButton({
              title: 'NY',
              isSelected: this.currentLocation === 'New York',
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => { this.currentLocation = 'New York' }
            })
            Blank()
            LocationTabButton({
              title: 'London',
              isSelected: this.currentLocation === 'London',
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => { this.currentLocation = 'London' }
            })
            Blank()
            LocationTabButton({
              title: 'Tokyo',
              isSelected: this.currentLocation === 'Tokyo',
              textPrimary: this.textPrimary,
              primaryBlue: this.primaryBlue,
              surfaceVariant: this.surfaceVariant,
              action: () => { this.currentLocation = 'Tokyo' }
            })
            Blank()
          }
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(this.surfaceColor)
          .borderRadius({ topLeft: 14, topRight: 14 })
          .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
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
        .fontWeight(500)
        .fontColor(this.textPrimary)
        .opacity(0.7)
      Text(this.value)
        .fontSize(12)
        .fontWeight(400)
        .fontColor(this.textPrimary)
    }
  }
}

@Component
struct LocationTabButton {
  title: string = ''
  isSelected: boolean = false
  textPrimary: ResourceColor = '#263238'
  primaryBlue: ResourceColor = '#2196F3'
  surfaceVariant: ResourceColor = '#E8F5E8'
  action: () => void = () => {}

  build() {
    Button() {
      Text(this.title)
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.isSelected ? '#FFFFFF' : this.textPrimary)
    }
    .width(80)
    .height(32)
    .backgroundColor(this.isSelected ? this.primaryBlue : this.surfaceVariant)
    .borderRadius(10)
    .type(ButtonType.Normal)
    .onClick(() => {
      this.action()
    })
  }
}

class WeatherHour {
  hour: string = ''
  temp: string = ''
  condition: string = ''
  color: ResourceColor = '#FFFFFF'
  constructor(hour: string, temp: string, condition: string, color: ResourceColor) {
    this.hour = hour
    this.temp = temp
    this.condition = condition
    this.color = color
  }
}

class WeatherDay {
  day: string = ''
  high: string = ''
  low: string = ''
  condition: string = ''
  color: ResourceColor = '#FFFFFF'
  constructor(day: string, high: string, low: string, condition: string, color: ResourceColor) {
    this.day = day
    this.high = high
    this.low = low
    this.condition = condition
    this.color = color
  }
}
