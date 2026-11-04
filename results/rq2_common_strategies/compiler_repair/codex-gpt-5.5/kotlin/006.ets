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

class WeatherColors {
  static primary: string = '#2196F3';
  static secondary: string = '#4CAF50';
  static tertiary: string = '#FF9800';
  static background: string = '#F5F7FA';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E8F5E8';
  static outline: string = '#E0E0E0';
  static error: string = '#F44336';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#263238';
}

@Entry
@Component
struct Index {
  @State currentLocation: string = 'New York';
  @State temperature: string = '72°';
  @State condition: string = 'Sunny';
  @State feelsLike: string = '74°';
  @State humidity: string = '45%';
  @State wind: string = '5 mph';

  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', WeatherColors.tertiary),
    new WeatherHour('1 PM', '74°', 'Sunny', WeatherColors.tertiary),
    new WeatherHour('2 PM', '75°', 'Sunny', WeatherColors.tertiary),
    new WeatherHour('3 PM', '76°', 'Cloudy', WeatherColors.primary),
    new WeatherHour('4 PM', '74°', 'Cloudy', WeatherColors.primary),
    new WeatherHour('5 PM', '72°', 'Rain', WeatherColors.secondary),
    new WeatherHour('6 PM', '70°', 'Rain', WeatherColors.secondary)
  ];

  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', WeatherColors.tertiary),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', WeatherColors.primary),
    new WeatherDay('Tue', '72°', '58°', 'Rain', WeatherColors.secondary),
    new WeatherDay('Wed', '70°', '56°', 'Rain', WeatherColors.secondary),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', WeatherColors.primary),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', WeatherColors.tertiary),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', WeatherColors.tertiary)
  ];

  @Builder
  CityButton(city: string, label: string) {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentLocation === city ? WeatherColors.onPrimary : WeatherColors.onSurface)
      .backgroundColor(this.currentLocation === city ? WeatherColors.primary : WeatherColors.surfaceVariant)
      .borderRadius(10)
      .height(32)
      .width(80)
      .onClick(() => {
        this.currentLocation = city;
      })
  }

  @Builder
  MetricColumn(label: string, value: string) {
    Column({ space: 4 }) {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3263238')
        .lineHeight(12)
      Text(value)
        .fontSize(12)
        .fontColor(WeatherColors.onSurface)
        .lineHeight(16)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HourCard(hour: WeatherHour) {
    Column({ space: 4 }) {
      Text(hour.hour)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(WeatherColors.onSurface)
        .lineHeight(12)
      Blank()
        .width(20)
        .height(20)
        .backgroundColor(hour.color)
        .borderRadius(20)
      Text(hour.temp)
        .fontSize(12)
        .fontColor(WeatherColors.onSurface)
        .lineHeight(16)
    }
    .width(70)
    .padding(6)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(WeatherColors.surface)
    .borderRadius(10)
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  DayRow(day: WeatherDay) {
    Row() {
      Text(day.day)
        .fontSize(12)
        .fontColor(WeatherColors.onSurface)
        .lineHeight(16)
        .width(40)
      Blank()
        .width(16)
        .height(16)
        .backgroundColor(day.color)
        .borderRadius(16)
      Row({ space: 6 }) {
        Text(day.high)
          .fontSize(12)
          .fontColor(WeatherColors.onSurface)
          .lineHeight(16)
        Text(day.low)
          .fontSize(12)
          .fontColor('#80263238')
          .lineHeight(16)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(WeatherColors.surface)
    .borderRadius(6)
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  StatColumn(label: string, value: string) {
    Column({ space: 4 }) {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3263238')
        .lineHeight(12)
      Text(value)
        .fontSize(12)
        .fontColor(WeatherColors.onSurface)
        .lineHeight(16)
    }
  }

  build() {
    Column() {
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(WeatherColors.onSurface)
        .lineHeight(24)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)

      Scroll() {
        Column({ space: 14 }) {
          Column({ space: 6 }) {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(WeatherColors.onSurface)
              .lineHeight(20)
            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(WeatherColors.onSurface)
              .lineHeight(36)
            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#B3263238')
              .lineHeight(18)
            Row() {
              this.MetricColumn('Feels like', this.feelsLike)
              this.MetricColumn('Humidity', this.humidity)
              this.MetricColumn('Wind', this.wind)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(14)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(WeatherColors.surface)
          .borderRadius(14)
          .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: 2 })

          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(WeatherColors.onSurface)
            .lineHeight(20)
            .width('100%')

          Scroll() {
            Row({ space: 6 }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                this.HourCard(hour)
              }, (hour: WeatherHour) => hour.hour)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .width('100%')

          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(WeatherColors.onSurface)
            .lineHeight(20)
            .width('100%')

          Column({ space: 6 }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              this.DayRow(day)
            }, (day: WeatherDay) => day.day)
          }
          .width('100%')

          Row() {
            this.StatColumn('UV Index', 'Moderate')
            this.StatColumn('Sunset', '7:45 PM')
            this.StatColumn('Visibility', '10 mi')
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(WeatherColors.surfaceVariant)
          .borderRadius(10)
          .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
        }
        .width('100%')
        .padding({ left: 10, right: 10, bottom: 16 })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        this.CityButton('New York', 'NY')
        this.CityButton('London', 'London')
        this.CityButton('Tokyo', 'Tokyo')
      }
      .width('100%')
      .padding(10)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(WeatherColors.surface)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(WeatherColors.background)
  }
}
