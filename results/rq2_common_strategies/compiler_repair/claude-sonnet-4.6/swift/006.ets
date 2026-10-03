interface WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: string;
}

interface WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: string;
}

@Entry
@Component
struct ContentView {
  @State currentLocation: string = 'New York';
  @State temperature: string = '72°';
  @State condition: string = 'Sunny';
  @State feelsLike: string = '74°';
  @State humidity: string = '45%';
  @State wind: string = '5 mph';

  private primaryBlueColor: string = '#2196F3';
  private primaryGreenColor: string = '#4CAF50';
  private primaryOrangeColor: string = '#FF9800';
  private bgColor: string = '#F5F7FA';
  private surfaceColor: string = '#FFFFFF';
  private surfaceVariantColor: string = '#E8F5E8';
  private textPrimaryColor: string = '#263238';
  private textSecondaryColor: string = '#263238B3';

  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: '#4CAF50' },
  ];

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: '#FF9800' },
  ];

  @Builder
  WeatherInfoItemBuilder(title: string, value: string) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#263238B3')
      Text(value)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.textPrimaryColor)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LocationButtonBuilder(title: string, isSelected: boolean, action: () => void) {
    Text(title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? '#FFFFFF' : this.textPrimaryColor)
      .width(80)
      .height(32)
      .textAlign(TextAlign.Center)
      .backgroundColor(isSelected ? this.primaryBlueColor : this.surfaceVariantColor)
      .borderRadius(10)
      .onClick(action)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column() {
        // Header
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimaryColor)
          .margin({ top: 44, bottom: 18 })

        // Main Content
        Scroll() {
          Column({ space: 18 }) {
            // Current Weather Card
            Column({ space: 10 }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimaryColor)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimaryColor)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textSecondaryColor)

              Row() {
                this.WeatherInfoItemBuilder('Feels like', this.feelsLike)
                Blank()
                this.WeatherInfoItemBuilder('Humidity', this.humidity)
                Blank()
                this.WeatherInfoItemBuilder('Wind', this.wind)
              }
              .width('100%')
              .padding({ left: 20, right: 20 })
            }
            .padding(18)
            .width('100%')
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: 2 })

            // Hourly Forecast
            Column({ space: 10 }) {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimaryColor)
                .width('100%')
                .textAlign(TextAlign.Start)

              Scroll() {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(hour.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.textPrimaryColor)

                      Circle({ width: 20, height: 20 })
                        .fill(hour.color)

                      Text(hour.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(this.textPrimaryColor)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                    .alignItems(HorizontalAlign.Center)
                  })
                }
                .padding({ bottom: 4 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // 7-Day Forecast
            Column({ space: 10 }) {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimaryColor)
                .width('100%')
                .textAlign(TextAlign.Start)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (day: WeatherDay) => {
                  Row() {
                    Text(day.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Normal)
                      .fontColor(this.textPrimaryColor)
                      .width(40)
                      .textAlign(TextAlign.Start)

                    Circle({ width: 16, height: 16 })
                      .fill(day.color)
                      .margin({ left: 8 })

                    Blank()

                    Row({ space: 6 }) {
                      Text(day.high)
                        .fontSize(12)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(this.textPrimaryColor)

                      Text(day.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(this.textSecondaryColor)
                    }
                  }
                  .padding(14)
                  .width('100%')
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                })
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Additional Info Card
            Row() {
              this.WeatherInfoItemBuilder('UV Index', 'Moderate')
              Blank()
              this.WeatherInfoItemBuilder('Sunset', '7:45 PM')
              Blank()
              this.WeatherInfoItemBuilder('Visibility', '10 mi')
            }
            .padding(18)
            .width('100%')
            .backgroundColor(this.surfaceVariantColor)
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          }
          .padding({ left: 14, right: 14, bottom: 100 })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)
      .alignItems(HorizontalAlign.Center)

      // Bottom Bar
      Column() {
        Row({ space: 0 }) {
          Blank()
          this.LocationButtonBuilder('NY', this.currentLocation === 'New York', () => {
            this.currentLocation = 'New York';
          })
          Blank()
          this.LocationButtonBuilder('London', this.currentLocation === 'London', () => {
            this.currentLocation = 'London';
          })
          Blank()
          this.LocationButtonBuilder('Tokyo', this.currentLocation === 'Tokyo', () => {
            this.currentLocation = 'Tokyo';
          })
          Blank()
        }
        .padding({ top: 14, bottom: 14 })
        .width('100%')
        .backgroundColor(this.surfaceColor)
        .borderRadius({ topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0 })
        .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}