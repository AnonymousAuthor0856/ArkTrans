@Entry
@Component
struct ContentView {
  @State private currentLocation: string = 'New York'
  @State private temperature: string = '72°'
  @State private condition: string = 'Sunny'
  @State private feelsLike: string = '74°'
  @State private humidity: string = '45%'
  @State private wind: string = '5 mph'

  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: '#4CAF50' },
  ]

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: '#FF9800' },
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F7FA')

      // Main scrollable content
      Column({ space: 0 }) {
        // Header
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#263238')
          .padding({ top: 44, bottom: 18 })

        // Scrollable list
        List({ space: 18 }) {
          // Current Weather Card
          ListItem() {
            Column({ space: 10 }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#263238')
              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#263238')
              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#263238')
                .opacity(0.7)

              Row({ space: 0 }) {
                WeatherInfoItem({ title: 'Feels like', value: this.feelsLike })
                Blank()
                WeatherInfoItem({ title: 'Humidity', value: this.humidity })
                Blank()
                WeatherInfoItem({ title: 'Wind', value: this.wind })
              }
              .padding({ left: 20, right: 20 })
            }
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(14)
            .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })
            .width('100%')
          }

          // Hourly Forecast
          ListItem() {
            Column({ space: 10 }) {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#263238')

              // Horizontal row of hourly items
              Row({ space: 6 }) {
                ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                  Column({ space: 6 }) {
                    Text(hour.hour)
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#263238')
                    Image('')
                      .width(20)
                      .height(20)
                      .borderRadius(10)
                      .backgroundColor(hour.color)
                    Text(hour.temp)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor('#263238')
                  }
                  .width(70)
                  .padding(6)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(10)
                  .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
                })
              }
            }
            .width('100%')
          }

          // 7-Day Forecast
          ListItem() {
            Column({ space: 10 }) {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#263238')

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (day: WeatherDay) => {
                  Row({ space: 0 }) {
                    Text(day.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor('#263238')
                      .width(40)
                      .textAlign(TextAlign.Start)
                    Image('')
                      .width(16)
                      .height(16)
                      .borderRadius(8)
                      .backgroundColor(day.color)
                    Blank()
                    Row({ space: 6 }) {
                      Text(day.high)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor('#263238')
                      Text(day.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor('#263238')
                        .opacity(0.7)
                    }
                  }
                  .padding(14)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(6)
                  .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
                  .width('100%')
                })
              }
            }
            .width('100%')
          }

          // Additional Info Card
          ListItem() {
            Row({ space: 0 }) {
              WeatherInfoItem({ title: 'UV Index', value: 'Moderate' })
              Blank()
              WeatherInfoItem({ title: 'Sunset', value: '7:45 PM' })
              Blank()
              WeatherInfoItem({ title: 'Visibility', value: '10 mi' })
            }
            .padding(18)
            .backgroundColor('#E8F5E8')
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
            .width('100%')
          }
        }
        .padding({ left: 14, right: 14, bottom: 80 })
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')

      // Bottom bar
      Column({ space: 0 }) {
        Divider()
          .height(1)
          .backgroundColor('#00000000') // invisible divider
        Row({ space: 0 }) {
          Blank()
          LocationButton({ title: 'NY', isSelected: this.currentLocation == 'New York', onClick: () => { this.currentLocation = 'New York' } })
          Blank()
          LocationButton({ title: 'London', isSelected: this.currentLocation == 'London', onClick: () => { this.currentLocation = 'London' } })
          Blank()
          LocationButton({ title: 'Tokyo', isSelected: this.currentLocation == 'Tokyo', onClick: () => { this.currentLocation = 'Tokyo' } })
          Blank()
        }
        .padding({ top: 14, bottom: 14 })
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 14, topRight: 14 })
        .shadow({ radius: 5, color: '#1F000000', offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// Builder functions with typed single parameter
@Builder
function WeatherInfoItem(param: WeatherInfoItemParam) {
  Column({ space: 4 }) {
    Text(param.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor('#263238')
      .opacity(0.7)
    Text(param.value)
      .fontSize(12)
      .fontWeight(FontWeight.Regular)
      .fontColor('#263238')
  }
}

@Builder
function LocationButton(param: LocationButtonParam) {
  Button({ type: ButtonType.Normal }) {
    Text(param.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(param.isSelected ? '#FFFFFF' : '#263238')
  }
  .width(80)
  .height(32)
  .backgroundColor(param.isSelected ? '#2196F3' : '#E8F5E8')
  .borderRadius(10)
  .onClick(param.onClick)
}

// Interfaces for builder parameters
interface WeatherInfoItemParam {
  title: string
  value: string
}

interface LocationButtonParam {
  title: string
  isSelected: boolean
  onClick: () => void
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