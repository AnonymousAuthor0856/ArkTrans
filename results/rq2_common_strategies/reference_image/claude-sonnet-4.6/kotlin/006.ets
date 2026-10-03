// Weather app – ArkTS (HarmonyOS ArkUI)
// Single-file Stage-model implementation mirroring the Compose layout.

interface WeatherHour {
  hour: string;
  temp: string;
  color: string;
}

interface WeatherDay {
  day: string;
  high: string;
  low: string;
  color: string;
}

const AppColors = {
  primary: '#2196F3',
  secondary: '#4CAF50',
  tertiary: '#FF9800',
  background: '#F5F7FA',
  surface: '#FFFFFF',
  surfaceVariant: '#E8F5E8',
  outline: '#E0E0E0',
  error: '#F44336',
  onPrimary: '#FFFFFF',
  onSurface: '#263238',
  onSurface70: '#B3263240',
  onSurface50: '#80263240',
  shadow1: '#1A000000',
  shadow2: '#1F000000'
};

const AppSpacing = {
  xs: 4,
  sm: 6,
  md: 10,
  lg: 14,
  xl: 18,
  xxl: 24
};

const HOURLY_FORECAST: WeatherHour[] = [
  { hour: 'Now', temp: '72°', color: AppColors.tertiary },
  { hour: '1 PM', temp: '74°', color: AppColors.tertiary },
  { hour: '2 PM', temp: '75°', color: AppColors.tertiary },
  { hour: '3 PM', temp: '76°', color: AppColors.primary },
  { hour: '4 PM', temp: '74°', color: AppColors.primary },
  { hour: '5 PM', temp: '72°', color: AppColors.secondary },
  { hour: '6 PM', temp: '70°', color: AppColors.secondary }
];

const WEEKLY_FORECAST: WeatherDay[] = [
  { day: 'Today', high: '76°', low: '62°', color: AppColors.tertiary },
  { day: 'Mon', high: '74°', low: '60°', color: AppColors.primary },
  { day: 'Tue', high: '72°', low: '58°', color: AppColors.secondary },
  { day: 'Wed', high: '70°', low: '56°', color: AppColors.secondary },
  { day: 'Thu', high: '73°', low: '59°', color: AppColors.primary },
  { day: 'Fri', high: '75°', low: '61°', color: AppColors.tertiary },
  { day: 'Sat', high: '77°', low: '63°', color: AppColors.tertiary }
];

@Entry
@Component
struct RootScreen {
  @State currentLocation: string = 'New York';
  @State temperature: string = '72°';
  @State condition: string = 'Sunny';
  @State feelsLike: string = '74°';
  @State humidity: string = '45%';
  @State wind: string = '5 mph';

  @Builder
  StatBlock(label: string, value: string) {
    Column({ space: AppSpacing.xs }) {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .lineHeight(12)
        .fontColor(AppColors.onSurface70)
      Text(value)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .lineHeight(16)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  LocationButton(label: string, city: string) {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentLocation === city ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(this.currentLocation === city ? AppColors.primary : AppColors.surfaceVariant)
      .width(80)
      .height(32)
      .borderRadius(10)
      .onClick(() => {
        this.currentLocation = city;
      })
  }

  @Builder
  HourlyCard(item: WeatherHour) {
    Column({ space: AppSpacing.xs }) {
      Text(item.hour)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .lineHeight(12)
        .fontColor(AppColors.onSurface)
      Column()
        .width(20)
        .height(20)
        .borderRadius(10)
        .backgroundColor(item.color)
      Text(item.temp)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .lineHeight(16)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Center)
    .padding(AppSpacing.sm)
    .width(70)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .shadow({ radius: 3, color: AppColors.shadow1, offsetX: 0, offsetY: 1 })
  }

  @Builder
  DailyCard(item: WeatherDay) {
    Row() {
      Text(item.day)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .lineHeight(16)
        .fontColor(AppColors.onSurface)
        .width(40)
      Column()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(item.color)
      Row({ space: AppSpacing.sm }) {
        Text(item.high)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .lineHeight(16)
          .fontColor(AppColors.onSurface)
        Text(item.low)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .lineHeight(16)
          .fontColor(AppColors.onSurface50)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(6)
    .shadow({ radius: 3, color: AppColors.shadow1, offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomBar() {
    Row() {
      this.LocationButton('NY', 'New York')
      this.LocationButton('London', 'London')
      this.LocationButton('Tokyo', 'Tokyo')
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius({ topLeft: 14, topRight: 14 })
    .shadow({ radius: 5, color: AppColors.shadow2, offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      // Top app bar
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .lineHeight(24)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })

      // Scrollable content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Current weather card
          Column({ space: AppSpacing.sm }) {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .lineHeight(20)
              .fontColor(AppColors.onSurface)
            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .lineHeight(36)
              .fontColor(AppColors.onSurface)
            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .lineHeight(18)
              .fontColor(AppColors.onSurface70)
            Row() {
              this.StatBlock('Feels like', this.feelsLike)
              this.StatBlock('Humidity', this.humidity)
              this.StatBlock('Wind', this.wind)
            }
            .justifyContent(FlexAlign.SpaceEvenly)
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .margin({ top: AppSpacing.xs })
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(14)
          .shadow({ radius: 5, color: AppColors.shadow2, offsetX: 0, offsetY: 2 })

          // Hourly forecast
          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .lineHeight(20)
            .fontColor(AppColors.onSurface)
            .width('100%')

          Scroll() {
            Row({ space: AppSpacing.sm }) {
              ForEach(HOURLY_FORECAST, (item: WeatherHour) => {
                this.HourlyCard(item)
              }, (item: WeatherHour) => item.hour)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // 7-day forecast
          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .lineHeight(20)
            .fontColor(AppColors.onSurface)
            .width('100%')

          Column({ space: AppSpacing.sm }) {
            ForEach(WEEKLY_FORECAST, (item: WeatherDay) => {
              this.DailyCard(item)
            }, (item: WeatherDay) => item.day)
          }
          .width('100%')

          // Extra detail card
          Row() {
            this.StatBlock('UV Index', 'Moderate')
            this.StatBlock('Sunset', '7:45 PM')
            this.StatBlock('Visibility', '10 mi')
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(10)
          .shadow({ radius: 3, color: AppColors.shadow1, offsetX: 0, offsetY: 1 })

          Blank().height(AppSpacing.md)
        }
        .width('100%')
        .padding({ left: AppSpacing.md, right: AppSpacing.md, bottom: AppSpacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}