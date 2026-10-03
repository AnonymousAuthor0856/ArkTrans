// Weather UI (SwiftUI -> ArkTS).

// 定义颜色常量以匹配设计 (Color constants matching the design)
const PRIMARY_BLUE: string = '#2196F2';
const PRIMARY_GREEN: string = '#4DB04F';
const PRIMARY_ORANGE: string = '#FF9900';
const BACKGROUND_COLOR: string = '#F5F7FA';
const SURFACE_COLOR: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#E8F5E8';
const TEXT_PRIMARY: string = '#263238';
const TEXT_SECONDARY: string = '#B3263238';

class WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: string;

  constructor(hour: string, temp: string, condition: string, color: string) {
    this.hour = hour;
    this.temp = temp;
    this.condition = condition;
    this.color = color;
  }
}

class WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: string;

  constructor(day: string, high: string, low: string, condition: string, color: string) {
    this.day = day;
    this.high = high;
    this.low = low;
    this.condition = condition;
    this.color = color;
  }
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

  hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', PRIMARY_ORANGE),
    new WeatherHour('1 PM', '74°', 'Sunny', PRIMARY_ORANGE),
    new WeatherHour('2 PM', '75°', 'Sunny', PRIMARY_ORANGE),
    new WeatherHour('3 PM', '76°', 'Cloudy', PRIMARY_BLUE),
    new WeatherHour('4 PM', '74°', 'Cloudy', PRIMARY_BLUE),
    new WeatherHour('5 PM', '72°', 'Rain', PRIMARY_GREEN),
    new WeatherHour('6 PM', '70°', 'Rain', PRIMARY_GREEN)
  ];

  weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', PRIMARY_ORANGE),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', PRIMARY_BLUE),
    new WeatherDay('Tue', '72°', '58°', 'Rain', PRIMARY_GREEN),
    new WeatherDay('Wed', '70°', '56°', 'Rain', PRIMARY_GREEN),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', PRIMARY_BLUE),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', PRIMARY_ORANGE),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', PRIMARY_ORANGE)
  ];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(BACKGROUND_COLOR)

      Column({ space: 0 }) {
        // Header
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
          .padding({ top: 44, bottom: 18 })

        // Main Content
        Scroll() {
          Column({ space: 18 }) {
            // Current Weather Card
            Column({ space: 10 }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Semibold)
                .fontColor(TEXT_PRIMARY)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(TEXT_PRIMARY)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(TEXT_SECONDARY)

              Row({ space: 0 }) {
                WeatherInfoItem({ title: 'Feels like', value: this.feelsLike, textPrimary: TEXT_PRIMARY })
                Blank()
                WeatherInfoItem({ title: 'Humidity', value: this.humidity, textPrimary: TEXT_PRIMARY })
                Blank()
                WeatherInfoItem({ title: 'Wind', value: this.wind, textPrimary: TEXT_PRIMARY })
              }
              .padding({ left: 20, right: 20 })
            }
            .padding(18)
            .backgroundColor(SURFACE_COLOR)
            .borderRadius(14)
            .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 2 })

            // Hourly Forecast
            Column({ space: 10 }) {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Semibold)
                .fontColor(TEXT_PRIMARY)

              Scroll() {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(hour.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(TEXT_PRIMARY)

                      Circle()
                        .width(20)
                        .height(20)
                        .fill(hour.color)

                      Text(hour.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(TEXT_PRIMARY)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(SURFACE_COLOR)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
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
                .fontWeight(FontWeight.Semibold)
                .fontColor(TEXT_PRIMARY)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (day: WeatherDay) => {
                  Row() {
                    Text(day.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor(TEXT_PRIMARY)
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
                        .fontWeight(FontWeight.Regular)
                        .fontColor(TEXT_PRIMARY)

                      Text(day.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor(TEXT_SECONDARY)
                    }
                  }
                  .padding(14)
                  .backgroundColor(SURFACE_COLOR)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
                }, (day: WeatherDay) => day.day)
              }
            }
            .alignItems(HorizontalAlign.Start)

            // Additional Info Card
            Row({ space: 0 }) {
              WeatherInfoItem({ title: 'UV Index', value: 'Moderate', textPrimary: TEXT_PRIMARY })
              Blank()
              WeatherInfoItem({ title: 'Sunset', value: '7:45 PM', textPrimary: TEXT_PRIMARY })
              Blank()
              WeatherInfoItem({ title: 'Visibility', value: '10 mi', textPrimary: TEXT_PRIMARY })
            }
            .padding(18)
            .backgroundColor(SURFACE_VARIANT)
            .borderRadius(10)
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
          }
          .padding({ left: 14, right: 14, bottom: 80 })
        }
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()

        Column({ space: 0 }) {
          Row()
            .width('100%')
            .height(1)
            .backgroundColor('#00000000')

          Row({ space: 0 }) {
            Blank()
            LocationButton({
              title: 'NY',
              isSelected: this.currentLocation === 'New York',
              textPrimary: TEXT_PRIMARY,
              primaryBlue: PRIMARY_BLUE,
              surfaceVariant: SURFACE_VARIANT,
              action: () => { this.currentLocation = 'New York'; }
            })
            Blank()
            LocationButton({
              title: 'London',
              isSelected: this.currentLocation === 'London',
              textPrimary: TEXT_PRIMARY,
              primaryBlue: PRIMARY_BLUE,
              surfaceVariant: SURFACE_VARIANT,
              action: () => { this.currentLocation = 'London'; }
            })
            Blank()
            LocationButton({
              title: 'Tokyo',
              isSelected: this.currentLocation === 'Tokyo',
              textPrimary: TEXT_PRIMARY,
              primaryBlue: PRIMARY_BLUE,
              surfaceVariant: SURFACE_VARIANT,
              action: () => { this.currentLocation = 'Tokyo'; }
            })
            Blank()
          }
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(SURFACE_COLOR)
          .borderRadius({ topLeft: 14, topRight: 14 })
          .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: -2 })
        }
      }
      .width('100%')
      .height('100%')
    }
  }
}

@Component
struct WeatherInfoItem {
  @Prop title: string = '';
  @Prop value: string = '';
  @Prop textPrimary: string = '';

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textPrimary)
        .opacity(0.7)
      Text(this.value)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.textPrimary)
    }
  }
}

@Component
struct LocationButton {
  @Prop title: string = '';
  @Prop isSelected: boolean = false;
  @Prop textPrimary: string = '';
  @Prop primaryBlue: string = '';
  @Prop surfaceVariant: string = '';
  action: () => void = () => {};

  build() {
    Button(this.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? '#FFFFFF' : this.textPrimary)
      .width(80)
      .height(32)
      .backgroundColor(this.isSelected ? this.primaryBlue : this.surfaceVariant)
      .borderRadius(10)
      .onClick(() => { this.action(); })
  }
}
