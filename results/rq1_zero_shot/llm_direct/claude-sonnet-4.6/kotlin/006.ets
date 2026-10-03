import { router } from '@kit.ArkUI';

// Color tokens
const Colors = {
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
  onSurfaceMuted: '#26323899',
  onSurfaceVeryMuted: '#26323880',
};

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

const hourlyForecastData: WeatherHour[] = [
  { hour: 'Now', temp: '72°', condition: 'Sunny', color: Colors.tertiary },
  { hour: '1 PM', temp: '74°', condition: 'Sunny', color: Colors.tertiary },
  { hour: '2 PM', temp: '75°', condition: 'Sunny', color: Colors.tertiary },
  { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: Colors.primary },
  { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: Colors.primary },
  { hour: '5 PM', temp: '72°', condition: 'Rain', color: Colors.secondary },
  { hour: '6 PM', temp: '70°', condition: 'Rain', color: Colors.secondary },
];

const weeklyForecastData: WeatherDay[] = [
  { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: Colors.tertiary },
  { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: Colors.primary },
  { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: Colors.secondary },
  { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: Colors.secondary },
  { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: Colors.primary },
  { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: Colors.tertiary },
  { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: Colors.tertiary },
];

@Component
struct HourlyCard {
  item: WeatherHour = { hour: '', temp: '', condition: '', color: '' };

  build() {
    Column({ space: 4 }) {
      Text(this.item.hour)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)

      Circle({ width: 20, height: 20 })
        .fill(this.item.color)

      Text(this.item.temp)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .padding(6)
    .width(70)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius(10)
    .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })
  }
}

@Component
struct DayForecastCard {
  item: WeatherDay = { day: '', high: '', low: '', condition: '', color: '' };

  build() {
    Row() {
      Text(this.item.day)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
        .width(40)

      Circle({ width: 16, height: 16 })
        .fill(this.item.color)

      Row({ space: 6 }) {
        Text(this.item.high)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)

        Text(this.item.low)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurfaceVeryMuted)
      }
      .justifyContent(FlexAlign.End)
      .layoutWeight(1)
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius(6)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }
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

  private hourlyForecast: WeatherHour[] = hourlyForecastData;
  private weeklyForecast: WeatherDay[] = weeklyForecastData;

  @Builder
  TopBar() {
    Row() {
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.background)
  }

  @Builder
  BottomBar() {
    Row({ space: 8 }) {
      Button('NY')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .height(32)
        .width(80)
        .borderRadius(10)
        .backgroundColor(this.currentLocation === 'New York' ? Colors.primary : Colors.surfaceVariant)
        .fontColor(this.currentLocation === 'New York' ? Colors.onPrimary : Colors.onSurface)
        .onClick(() => {
          this.currentLocation = 'New York';
        })

      Button('London')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .height(32)
        .width(80)
        .borderRadius(10)
        .backgroundColor(this.currentLocation === 'London' ? Colors.primary : Colors.surfaceVariant)
        .fontColor(this.currentLocation === 'London' ? Colors.onPrimary : Colors.onSurface)
        .onClick(() => {
          this.currentLocation = 'London';
        })

      Button('Tokyo')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .height(32)
        .width(80)
        .borderRadius(10)
        .backgroundColor(this.currentLocation === 'Tokyo' ? Colors.primary : Colors.surfaceVariant)
        .fontColor(this.currentLocation === 'Tokyo' ? Colors.onPrimary : Colors.onSurface)
        .onClick(() => {
          this.currentLocation = 'Tokyo';
        })
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius({ topLeft: 14, topRight: 14 })
    .shadow({ radius: 5, color: '#1F000000', offsetY: -2 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 14 }) {
          // Current weather card
          Column({ space: 6 }) {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Colors.onSurface)
              .textAlign(TextAlign.Center)

            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .textAlign(TextAlign.Center)

            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurfaceMuted)
              .textAlign(TextAlign.Center)

            Row() {
              Column({ space: 4 }) {
                Text('Feels like')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurfaceMuted)
                  .textAlign(TextAlign.Center)
                Text(this.feelsLike)
                  .fontSize(12)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(Colors.onSurface)
                  .textAlign(TextAlign.Center)
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)

              Column({ space: 4 }) {
                Text('Humidity')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurfaceMuted)
                  .textAlign(TextAlign.Center)
                Text(this.humidity)
                  .fontSize(12)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(Colors.onSurface)
                  .textAlign(TextAlign.Center)
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)

              Column({ space: 4 }) {
                Text('Wind')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurfaceMuted)
                  .textAlign(TextAlign.Center)
                Text(this.wind)
                  .fontSize(12)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(Colors.onSurface)
                  .textAlign(TextAlign.Center)
              }
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(14)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(Colors.surface)
          .borderRadius(14)
          .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })

          // Hourly forecast label
          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Colors.onBackground)

          // Hourly forecast scroll
          Scroll() {
            Row({ space: 6 }) {
              ForEach(this.hourlyForecast, (item: WeatherHour) => {
                HourlyCard({ item: item })
              })
            }
            .padding({ bottom: 4 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // 7-Day forecast label
          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Colors.onBackground)

          // Weekly forecast
          Column({ space: 6 }) {
            ForEach(this.weeklyForecast, (item: WeatherDay) => {
              DayForecastCard({ item: item })
            })
          }
          .width('100%')

          // Extra info card
          Row() {
            Column({ space: 4 }) {
              Text('UV Index')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurfaceMuted)
              Text('Moderate')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Column({ space: 4 }) {
              Text('Sunset')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurfaceMuted)
              Text('7:45 PM')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Column({ space: 4 }) {
              Text('Visibility')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurfaceMuted)
              Text('10 mi')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(10)
          .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
        }
        .padding({ left: 10, right: 10, top: 4, bottom: 14 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}