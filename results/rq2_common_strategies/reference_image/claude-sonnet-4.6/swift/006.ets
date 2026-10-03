// Index.ets  —  Weather screen (SwiftUI ➜ ArkTS/ArkUI)

const PRIMARY_BLUE: string = '#2196F3';
const PRIMARY_GREEN: string = '#4CAF50';
const PRIMARY_ORANGE: string = '#FF9800';
const BACKGROUND_COLOR: string = '#F5F7FA';
const SURFACE_COLOR: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#E8F5E8';
const TEXT_PRIMARY: string = '#263238';
const TEXT_SECONDARY: string = '#B3263238'; // #263238 @ 70% opacity
const SHADOW_CARD: string = '#1F000000';    // black @ 12%
const SHADOW_SOFT: string = '#1A000000';    // black @ 10%

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

@Component
struct WeatherInfoItem {
  @Prop title: string = '';
  @Prop value: string = '';

  build() {
    Column({ space: 4 }) {
      Text(this.title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_SECONDARY)
      Text(this.value)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(TEXT_PRIMARY)
    }
  }
}

@Component
struct LocationButton {
  @Prop title: string = '';
  @Prop isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Text(this.title)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? '#FFFFFF' : TEXT_PRIMARY)
      .textAlign(TextAlign.Center)
      .width(80)
      .height(32)
      .backgroundColor(this.isSelected ? PRIMARY_BLUE : SURFACE_VARIANT)
      .borderRadius(10)
      .onClick(() => {
        this.onTap();
      })
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

  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: PRIMARY_ORANGE },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: PRIMARY_ORANGE },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: PRIMARY_ORANGE },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: PRIMARY_BLUE },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: PRIMARY_BLUE },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: PRIMARY_GREEN },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: PRIMARY_GREEN }
  ];

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: PRIMARY_ORANGE },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: PRIMARY_BLUE },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: PRIMARY_GREEN },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: PRIMARY_GREEN },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: PRIMARY_BLUE },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: PRIMARY_ORANGE },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: PRIMARY_ORANGE }
  ];

  @Builder
  CurrentWeatherCard() {
    Column({ space: 10 }) {
      Text(this.currentLocation)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(TEXT_PRIMARY)

      Text(this.temperature)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_PRIMARY)

      Text(this.condition)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_SECONDARY)

      Row() {
        WeatherInfoItem({ title: 'Feels like', value: this.feelsLike })
        Blank()
        WeatherInfoItem({ title: 'Humidity', value: this.humidity })
        Blank()
        WeatherInfoItem({ title: 'Wind', value: this.wind })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .padding(18)
    .backgroundColor(SURFACE_COLOR)
    .borderRadius(14)
    .shadow({ radius: 5, color: SHADOW_CARD, offsetX: 0, offsetY: 2 })
  }

  @Builder
  HourlyForecastSection() {
    Column({ space: 10 }) {
      Text('Hourly Forecast')
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(TEXT_PRIMARY)

      Scroll() {
        Row({ space: 6 }) {
          ForEach(this.hourlyForecast, (item: WeatherHour) => {
            Column({ space: 6 }) {
              Text(item.hour)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(TEXT_PRIMARY)

              Circle()
                .width(20)
                .height(20)
                .fill(item.color)

              Text(item.temp)
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(TEXT_PRIMARY)
            }
            .width(70)
            .padding(6)
            .backgroundColor(SURFACE_COLOR)
            .borderRadius(10)
            .shadow({ radius: 3, color: SHADOW_SOFT, offsetX: 0, offsetY: 1 })
          }, (item: WeatherHour) => item.hour + item.temp)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .align(Alignment.Start)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  WeeklyForecastSection() {
    Column({ space: 10 }) {
      Text('7-Day Forecast')
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(TEXT_PRIMARY)

      Column({ space: 6 }) {
        ForEach(this.weeklyForecast, (item: WeatherDay) => {
          Row() {
            Text(item.day)
              .fontSize(12)
              .fontWeight(FontWeight.Normal)
              .fontColor(TEXT_PRIMARY)
              .width(40)
              .textAlign(TextAlign.Start)

            Circle()
              .width(16)
              .height(16)
              .fill(item.color)

            Blank()

            Row({ space: 6 }) {
              Text(item.high)
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(TEXT_PRIMARY)

              Text(item.low)
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(TEXT_SECONDARY)
            }
          }
          .width('100%')
          .padding(14)
          .backgroundColor(SURFACE_COLOR)
          .borderRadius(6)
          .shadow({ radius: 3, color: SHADOW_SOFT, offsetX: 0, offsetY: 1 })
        }, (item: WeatherDay) => item.day)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  AdditionalInfoCard() {
    Row() {
      WeatherInfoItem({ title: 'UV Index', value: 'Moderate' })
      Blank()
      WeatherInfoItem({ title: 'Sunset', value: '7:45 PM' })
      Blank()
      WeatherInfoItem({ title: 'Visibility', value: '10 mi' })
    }
    .width('100%')
    .padding(18)
    .backgroundColor(SURFACE_VARIANT)
    .borderRadius(10)
    .shadow({ radius: 3, color: SHADOW_SOFT, offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomBar() {
    Row() {
      LocationButton({
        title: 'NY',
        isSelected: this.currentLocation === 'New York',
        onTap: () => {
          this.currentLocation = 'New York';
        }
      })

      LocationButton({
        title: 'London',
        isSelected: this.currentLocation === 'London',
        onTap: () => {
          this.currentLocation = 'London';
        }
      })

      LocationButton({
        title: 'Tokyo',
        isSelected: this.currentLocation === 'Tokyo',
        onTap: () => {
          this.currentLocation = 'Tokyo';
        }
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .padding({ top: 14, bottom: 14 })
    .backgroundColor(SURFACE_COLOR)
    .borderRadius({ topLeft: 14, topRight: 14 })
    .shadow({ radius: 5, color: SHADOW_CARD, offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Header
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
          .padding({ top: 44, bottom: 18 })

        // Main content
        Scroll() {
          Column({ space: 18 }) {
            this.CurrentWeatherCard()
            this.HourlyForecastSection()
            this.WeeklyForecastSection()
            this.AdditionalInfoCard()
          }
          .width('100%')
          .padding({ left: 14, right: 14, bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom bar
      Column() {
        this.BottomBar()
      }
      .width('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}