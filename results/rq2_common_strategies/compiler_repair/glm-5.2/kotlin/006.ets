// Index.ets

class WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: ResourceColor;

  constructor(hour: string, temp: string, condition: string, color: ResourceColor) {
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
  color: ResourceColor;

  constructor(day: string, high: string, low: string, condition: string, color: ResourceColor) {
    this.day = day;
    this.high = high;
    this.low = low;
    this.condition = condition;
    this.color = color;
  }
}

class AppTokens {
  static primary: ResourceColor = '#2196F3';
  static secondary: ResourceColor = '#4CAF50';
  static tertiary: ResourceColor = '#FF9800';
  static background: ResourceColor = '#F5F7FA';
  static surface: ResourceColor = '#FFFFFF';
  static surfaceVariant: ResourceColor = '#E8F5E8';
  static outline: ResourceColor = '#E0E0E0';
  static onPrimary: ResourceColor = '#FFFFFF';
  static onSurface: ResourceColor = '#263238';
  static onBackground: ResourceColor = '#263238';

  static xs: number = 4;
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 14;
  static xl: number = 18;
  static xxl: number = 24;
  static xxxl: number = 32;
}

@Entry
@Component
struct RootScreen {
  @State currentLocation: string = 'New York';
  @State temperature: string = '72°';
  @State condition: string = 'Sunny';
  @State feelsLike: string = '74°';
  @State humidity: string = '45%';
  @State wind: string = '5 mph';

  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', AppTokens.tertiary),
    new WeatherHour('1 PM', '74°', 'Sunny', AppTokens.tertiary),
    new WeatherHour('2 PM', '75°', 'Sunny', AppTokens.tertiary),
    new WeatherHour('3 PM', '76°', 'Cloudy', AppTokens.primary),
    new WeatherHour('4 PM', '74°', 'Cloudy', AppTokens.primary),
    new WeatherHour('5 PM', '72°', 'Rain', AppTokens.secondary),
    new WeatherHour('6 PM', '70°', 'Rain', AppTokens.secondary)
  ];

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', AppTokens.tertiary),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', AppTokens.primary),
    new WeatherDay('Tue', '72°', '58°', 'Rain', AppTokens.secondary),
    new WeatherDay('Wed', '70°', '56°', 'Rain', AppTokens.secondary),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', AppTokens.primary),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', AppTokens.tertiary),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', AppTokens.tertiary)
  ];

  build() {
    Column() {
      // Top App Bar
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onBackground)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.lg, bottom: AppTokens.sm })

      // Content
      Scroll() {
        Column() {
          // Current Weather Card
          Column() {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.onSurface)

            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.onSurface)
              .margin({ top: AppTokens.sm })

            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.onSurface)
              .opacity(0.7)
              .margin({ top: AppTokens.xs })

            Row() {
              Column() {
                Text('Feels like')
                  .fontSize(10)
                  .fontColor(AppTokens.onSurface)
                  .opacity(0.7)
                Text(this.feelsLike)
                  .fontSize(12)
                  .fontColor(AppTokens.onSurface)
                  .margin({ top: AppTokens.xs })
              }

              Column() {
                Text('Humidity')
                  .fontSize(10)
                  .fontColor(AppTokens.onSurface)
                  .opacity(0.7)
                Text(this.humidity)
                  .fontSize(12)
                  .fontColor(AppTokens.onSurface)
                  .margin({ top: AppTokens.xs })
              }

              Column() {
                Text('Wind')
                  .fontSize(10)
                  .fontColor(AppTokens.onSurface)
                  .opacity(0.7)
                Text(this.wind)
                  .fontSize(12)
                  .fontColor(AppTokens.onSurface)
                  .margin({ top: AppTokens.xs })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .margin({ top: AppTokens.lg })
          }
          .width('100%')
          .padding(AppTokens.lg)
          .backgroundColor(AppTokens.surface)
          .borderRadius(14)
          .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 2 })

          // Hourly Forecast
          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onBackground)
            .margin({ top: AppTokens.lg, bottom: AppTokens.sm })

          Scroll() {
            Row({ space: AppTokens.sm }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                Column() {
                  Text(hour.hour)
                    .fontSize(10)
                    .fontColor(AppTokens.onSurface)
                  Circle({ width: 20, height: 20 })
                    .fill(hour.color)
                    .margin({ top: AppTokens.xs })
                  Text(hour.temp)
                    .fontSize(12)
                    .fontColor(AppTokens.onSurface)
                    .margin({ top: AppTokens.xs })
                }
                .padding(AppTokens.sm)
                .backgroundColor(AppTokens.surface)
                .borderRadius(10)
                .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                .width(70)
                .alignItems(HorizontalAlign.Center)
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // 7-Day Forecast
          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onBackground)
            .margin({ top: AppTokens.lg, bottom: AppTokens.sm })

          Column({ space: AppTokens.sm }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              Row() {
                Text(day.day)
                  .fontSize(12)
                  .fontColor(AppTokens.onSurface)
                  .width(40)

                Circle({ width: 16, height: 16 })
                  .fill(day.color)

                Row({ space: AppTokens.sm }) {
                  Text(day.high)
                    .fontSize(12)
                    .fontColor(AppTokens.onSurface)
                  Text(day.low)
                    .fontSize(12)
                    .fontColor(AppTokens.onSurface)
                    .opacity(0.5)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(AppTokens.md)
              .backgroundColor(AppTokens.surface)
              .borderRadius(6)
              .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            })
          }
          .width('100%')

          // UV / Sunset / Visibility Card
          Row() {
            Column() {
              Text('UV Index')
                .fontSize(10)
                .fontColor(AppTokens.onSurface)
                .opacity(0.7)
              Text('Moderate')
                .fontSize(12)
                .fontColor(AppTokens.onSurface)
                .margin({ top: AppTokens.xs })
            }

            Column() {
              Text('Sunset')
                .fontSize(10)
                .fontColor(AppTokens.onSurface)
                .opacity(0.7)
              Text('7:45 PM')
                .fontSize(12)
                .fontColor(AppTokens.onSurface)
                .margin({ top: AppTokens.xs })
            }

            Column() {
              Text('Visibility')
                .fontSize(10)
                .fontColor(AppTokens.onSurface)
                .opacity(0.7)
              Text('10 mi')
                .fontSize(12)
                .fontColor(AppTokens.onSurface)
                .margin({ top: AppTokens.xs })
            }
          }
          .width('100%')
          .padding(AppTokens.md)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(10)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: AppTokens.lg })
        }
        .padding({ left: AppTokens.md, right: AppTokens.md, bottom: 80 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      // Bottom Bar
      Row() {
        Button('NY', { type: ButtonType.Capsule })
          .height(32)
          .width(80)
          .fontSize(10)
          .backgroundColor(this.currentLocation === 'New York' ? AppTokens.primary : AppTokens.surfaceVariant)
          .fontColor(this.currentLocation === 'New York' ? AppTokens.onPrimary : AppTokens.onSurface)
          .onClick(() => {
            this.currentLocation = 'New York';
          })

        Button('London', { type: ButtonType.Capsule })
          .height(32)
          .width(80)
          .fontSize(10)
          .backgroundColor(this.currentLocation === 'London' ? AppTokens.primary : AppTokens.surfaceVariant)
          .fontColor(this.currentLocation === 'London' ? AppTokens.onPrimary : AppTokens.onSurface)
          .onClick(() => {
            this.currentLocation = 'London';
          })

        Button('Tokyo', { type: ButtonType.Capsule })
          .height(32)
          .width(80)
          .fontSize(10)
          .backgroundColor(this.currentLocation === 'Tokyo' ? AppTokens.primary : AppTokens.surfaceVariant)
          .fontColor(this.currentLocation === 'Tokyo' ? AppTokens.onPrimary : AppTokens.onSurface)
          .onClick(() => {
            this.currentLocation = 'Tokyo';
          })
      }
      .width('100%')
      .padding(AppTokens.md)
      .backgroundColor(AppTokens.surface)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}