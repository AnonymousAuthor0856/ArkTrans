const NAME: string = '013_WeatherApp_en';
const UI_TYPE: string = 'Weather';
const STYLE_THEME: string = 'Clean Light';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

class AppColors {
  static readonly primary: string = '#2196F3';
  static readonly secondary: string = '#4CAF50';
  static readonly tertiary: string = '#FF9800';
  static readonly background: string = '#F5F7FA';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E8F5E8';
  static readonly outline: string = '#E0E0E0';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FF9800';
  static readonly error: string = '#F44336';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#263238';
  static readonly onSurface: string = '#263238';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 18;
  static readonly xxl: number = 24;
  static readonly xxxl: number = 32;
}

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
struct MainActivity {
  @State currentLocation: string = 'New York';
  @State temperature: string = '72°';
  @State condition: string = 'Sunny';
  @State feelsLike: string = '74°';
  @State humidity: string = '45%';
  @State wind: string = '5 mph';
  private hourlyForecast: WeatherHour[] = [
    new WeatherHour('Now', '72°', 'Sunny', AppColors.tertiary),
    new WeatherHour('1 PM', '74°', 'Sunny', AppColors.tertiary),
    new WeatherHour('2 PM', '75°', 'Sunny', AppColors.tertiary),
    new WeatherHour('3 PM', '76°', 'Cloudy', AppColors.primary),
    new WeatherHour('4 PM', '74°', 'Cloudy', AppColors.primary),
    new WeatherHour('5 PM', '72°', 'Rain', AppColors.secondary),
    new WeatherHour('6 PM', '70°', 'Rain', AppColors.secondary)
  ];
  private weeklyForecast: WeatherDay[] = [
    new WeatherDay('Today', '76°', '62°', 'Sunny', AppColors.tertiary),
    new WeatherDay('Mon', '74°', '60°', 'Cloudy', AppColors.primary),
    new WeatherDay('Tue', '72°', '58°', 'Rain', AppColors.secondary),
    new WeatherDay('Wed', '70°', '56°', 'Rain', AppColors.secondary),
    new WeatherDay('Thu', '73°', '59°', 'Cloudy', AppColors.primary),
    new WeatherDay('Fri', '75°', '61°', 'Sunny', AppColors.tertiary),
    new WeatherDay('Sat', '77°', '63°', 'Sunny', AppColors.tertiary)
  ];

  @Builder
  Header(): void {
    Text('Weather')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onBackground)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Transparent);
  }

  @Builder
  CurrentCard(): void {
    Column({ space: AppSpacing.sm }) {
      Text(this.currentLocation)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      Text(this.temperature)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface);
      Text(this.condition)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3263238');
      Row() {
        this.InfoMetric('Feels like', this.feelsLike);
        this.InfoMetric('Humidity', this.humidity);
        this.InfoMetric('Wind', this.wind);
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({ radius: 5, color: '#1F000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  InfoMetric(label: string, value: string): void {
    Column({ space: AppSpacing.xs }) {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3263238');
      Text(value)
        .fontSize(12)
        .fontColor(AppColors.onSurface);
    }
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  HourCard(hour: WeatherHour): void {
    Column({ space: AppSpacing.xs }) {
      Text(hour.hour)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Circle().width(20).height(20).fill(hour.color);
      Text(hour.temp)
        .fontSize(12)
        .fontColor(AppColors.onSurface);
    }
    .width(70)
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  WeeklyRow(day: WeatherDay): void {
    Row() {
      Text(day.day)
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .width(40);
      Circle().width(16).height(16).fill(day.color);
      Blank();
      Row({ space: AppSpacing.sm }) {
        Text(day.high).fontSize(12).fontColor(AppColors.onSurface);
        Text(day.low).fontSize(12).fontColor('#80263238');
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(6)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  ExtraMetrics(): void {
    Row() {
      this.InfoMetric('UV Index', 'Moderate');
      this.InfoMetric('Sunset', '7:45 PM');
      this.InfoMetric('Visibility', '10 mi');
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(10)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 });
  }

  @Builder
  CityButton(label: string, value: string): void {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentLocation === value ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(this.currentLocation === value ? AppColors.primary : AppColors.surfaceVariant)
      .borderRadius(10)
      .width(80)
      .height(32)
      .onClick(() => {
        this.currentLocation = value;
      });
  }

  @Builder
  BottomBar(): void {
    Row() {
      this.CityButton('NY', 'New York');
      this.CityButton('London', 'London');
      this.CityButton('Tokyo', 'Tokyo');
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius({ topLeft: 14, topRight: 14 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 5, color: '#1F000000', offsetY: -2 });
  }

  build() {
    Column() {
      this.Header();
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.CurrentCard();
          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground);
          Scroll() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                this.HourCard(hour);
              }, (hour: WeatherHour) => hour.hour)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .width('100%');
          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground);
          Column({ space: AppSpacing.sm }) {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              this.WeeklyRow(day);
            }, (day: WeatherDay) => day.day)
          }
          this.ExtraMetrics();
        }
        .width('100%')
        .padding({ left: AppSpacing.md, right: AppSpacing.md, bottom: AppSpacing.lg });
      }
      .layoutWeight(1);
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
