// AppTokens.ets
export class AppTokens {
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
  };

  static readonly TypographyTokens = {
    display: { fontSize: 20, fontWeight: FontWeight.Bold, lineHeight: 24, letterSpacing: -0.2 },
    headline: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 20, letterSpacing: 0 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18, letterSpacing: 0 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16, letterSpacing: 0.1 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 12, letterSpacing: 0.2 },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
    bottomBarTop: 14,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 18,
    xxl: 24,
    xxxl: 32,
  };

  static readonly ElevationMapping = {
    level1: 2,
    level2: 4,
    level3: 6,
    level4: 8,
  };
}

// Models.ets
export class WeatherHour {
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

export class WeatherDay {
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

// RootScreen.ets
import { AppTokens, WeatherHour, WeatherDay } from './AppTokens';

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
    new WeatherHour('Now', '72°', 'Sunny', AppTokens.Colors.tertiary),
    new WeatherHour('1 PM', '74°', 'Sunny', AppTokens.Colors.tertiary),
    new WeatherHour('2 PM', '75°', 'Sunny', AppTokens.Colors.tertiary),
    new WeatherHour('3 PM', '76°', 'Cloudy', AppTokens.Colors.primary),
    new WeatherHour('4 PM', '74°', 'Cloudy', AppTokens.Colors.primary),
    new WeatherHour('5 PM', '72°', 'Rain', AppTokens.Colors.secondary),
    new WeatherHour('6 PM', '70°', 'Rain', AppTokens.Colors.secondary),
  ];

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', AppTokens.Colors.tertiary),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', AppTokens.Colors.primary),
    new WeatherDay('Tue', '72°', '58°', 'Rain', AppTokens.Colors.secondary),
    new WeatherDay('Wed', '70°', '56°', 'Rain', AppTokens.Colors.secondary),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', AppTokens.Colors.primary),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', AppTokens.Colors.tertiary),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', AppTokens.Colors.tertiary),
  ];

  build() {
    Column() {
      // Top App Bar
      Text('Weather')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .height(56)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 10, bottom: 10 });

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Current Weather Card
          Column() {
            Text(this.currentLocation)
              .fontSize(AppTokens.TypographyTokens.headline.fontSize)
              .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.sm });

            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.sm });

            Text(this.condition)
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.7)
              .margin({ bottom: AppTokens.Spacing.md });

            // Weather Details Row
            Row() {
              this.WeatherDetailItem('Feels like', this.feelsLike)
              this.WeatherDetailItem('Humidity', this.humidity)
              this.WeatherDetailItem('Wind', this.wind)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly);
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: AppTokens.ElevationMapping.level2, color: 'rgba(0,0,0,0.12)', offsetY: 2 });

          // Hourly Forecast
          Text('Hourly Forecast')
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%');

          // Hourly Forecast List
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                Column({ space: AppTokens.Spacing.xs }) {
                  Text(hour.hour)
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontColor(AppTokens.Colors.onSurface);
                  Circle({ width: 20, height: 20 }).fill(hour.color);
                  Text(hour.temp)
                    .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    .fontColor(AppTokens.Colors.onSurface);
                }
                .width(70)
                .padding(AppTokens.Spacing.sm)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.medium)
                .shadow({ radius: AppTokens.ElevationMapping.level1, color: 'rgba(0,0,0,0.1)', offsetY: 1 });
              });
            }
            .padding({ bottom: 4 });
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%');

          // 7-Day Forecast
          Text('7-Day Forecast')
            .fontSize(AppTokens.TypographyTokens.headline.fontSize)
            .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%');

          // 7-Day Forecast List
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              Row() {
                Text(day.day)
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width(40);
                Circle({ width: 16, height: 16 }).fill(day.color);
                Row({ space: AppTokens.Spacing.sm }) {
                  Text(day.high)
                    .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    .fontColor(AppTokens.Colors.onSurface);
                  Text(day.low)
                    .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.5);
                }
              }
              .width('100%')
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.small)
              .shadow({ radius: AppTokens.ElevationMapping.level1, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
              .justifyContent(FlexAlign.SpaceBetween);
            });
          }
          .width('100%');

          // Additional Info Card
          Row() {
            this.WeatherDetailItem('UV Index', 'Moderate')
            this.WeatherDetailItem('Sunset', '7:45 PM')
            this.WeatherDetailItem('Visibility', '10 mi')
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .shadow({ radius: AppTokens.ElevationMapping.level1, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
          .justifyContent(FlexAlign.SpaceBetween);
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, bottom: 80 });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background);

      // Bottom Bar
      Row() {
        Button('NY')
          .height(32)
          .width(80)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .backgroundColor(this.currentLocation === 'New York' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === 'New York' ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => { this.currentLocation = 'New York'; });

        Button('London')
          .height(32)
          .width(80)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .backgroundColor(this.currentLocation === 'London' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === 'London' ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => { this.currentLocation = 'London'; });

        Button('Tokyo')
          .height(32)
          .width(80)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .backgroundColor(this.currentLocation === 'Tokyo' ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === 'Tokyo' ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => { this.currentLocation = 'Tokyo'; });
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius({ topLeft: AppTokens.Shapes.bottomBarTop, topRight: AppTokens.Shapes.bottomBarTop })
      .shadow({ radius: AppTokens.ElevationMapping.level2, color: 'rgba(0,0,0,0.12)', offsetY: -2 })
      .justifyContent(FlexAlign.SpaceEvenly);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }

  @Builder WeatherDetailItem(label: string, value: string) {
    Column({ space: AppTokens.Spacing.xs }) {
      Text(label)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7);
      Text(value)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontColor(AppTokens.Colors.onSurface);
    }
    .alignItems(HorizontalAlign.Center);
  }
}