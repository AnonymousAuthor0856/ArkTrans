// Weather App - translated from Kotlin/Jetpack Compose to ArkTS/ArkUI

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

const COLOR_PRIMARY: string = '#2196F3';
const COLOR_SECONDARY: string = '#4CAF50';
const COLOR_TERTIARY: string = '#FF9800';
const COLOR_BACKGROUND: string = '#F5F7FA';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_SURFACE_VARIANT: string = '#E8F5E8';
const COLOR_ON_PRIMARY: string = '#FFFFFF';
const COLOR_ON_SURFACE: string = '#263238';
const COLOR_ON_BACKGROUND: string = '#263238';
const COLOR_ON_SURFACE_70: string = '#B3263238';
const COLOR_ON_SURFACE_50: string = '#80263238';

@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = 'New York';
  @State temperature: string = '72°';
  @State condition: string = 'Sunny';
  @State feelsLike: string = '74°';
  @State humidity: string = '45%';
  @State wind: string = '5 mph';

  private hourlyForecast: WeatherHour[] = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: COLOR_TERTIARY },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: COLOR_TERTIARY },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: COLOR_TERTIARY },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: COLOR_SECONDARY },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: COLOR_SECONDARY }
  ];

  private weeklyForecast: WeatherDay[] = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: COLOR_TERTIARY },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: COLOR_SECONDARY },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: COLOR_SECONDARY },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: COLOR_PRIMARY },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: COLOR_TERTIARY },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: COLOR_TERTIARY }
  ];

  @Builder
  HourCard(hour: WeatherHour) {
    Column({ space: 4 }) {
      Text(hour.hour)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
      Column()
        .width(20)
        .height(20)
        .borderRadius(10)
        .backgroundColor(hour.color)
      Text(hour.temp)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(COLOR_ON_SURFACE)
    }
    .width(70)
    .padding(6)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(10)
    .alignItems(HorizontalAlign.Center)
    .margin({ right: 6 })
  }

  @Builder
  DayCard(day: WeatherDay) {
    Row() {
      Text(day.day)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(COLOR_ON_SURFACE)
        .width(40)
      Column()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(day.color)
      Row({ space: 6 }) {
        Text(day.high)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(COLOR_ON_SURFACE)
        Text(day.low)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(COLOR_ON_SURFACE_50)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(10)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(6)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 6 })
  }

  @Builder
  LocationButton(label: string, city: string) {
    Button(label)
      .type(ButtonType.Normal)
      .width(80)
      .height(32)
      .borderRadius(10)
      .backgroundColor(this.currentLocation === city ? COLOR_PRIMARY : COLOR_SURFACE_VARIANT)
      .fontColor(this.currentLocation === city ? COLOR_ON_PRIMARY : COLOR_ON_SURFACE)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .onClick(() => {
        this.currentLocation = city;
      })
  }

  build() {
    Column() {
      // Top app bar
      Row() {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      // Scrollable main content
      Scroll() {
        Column({ space: 14 }) {
          // Current weather card
          Column({ space: 6 }) {
            Text(this.currentLocation)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SURFACE)
            Text(this.temperature)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_ON_SURFACE)
            Text(this.condition)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_SURFACE_70)
            Row() {
              Column({ space: 4 }) {
                Text('Feels like')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE_70)
                Text(this.feelsLike)
                  .fontSize(12)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(COLOR_ON_SURFACE)
              }
              .alignItems(HorizontalAlign.Center)

              Column({ space: 4 }) {
                Text('Humidity')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE_70)
                Text(this.humidity)
                  .fontSize(12)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(COLOR_ON_SURFACE)
              }
              .alignItems(HorizontalAlign.Center)

              Column({ space: 4 }) {
                Text('Wind')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(COLOR_ON_SURFACE_70)
                Text(this.wind)
                  .fontSize(12)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(COLOR_ON_SURFACE)
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(14)
          .backgroundColor(COLOR_SURFACE)
          .borderRadius(14)
          .alignItems(HorizontalAlign.Center)

          Text('Hourly Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_BACKGROUND)

          Scroll() {
            Row() {
              ForEach(this.hourlyForecast, (hour: WeatherHour) => {
                this.HourCard(hour)
              }, (hour: WeatherHour) => hour.hour)
            }
            .padding({ left: 10, right: 4 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Text('7-Day Forecast')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_BACKGROUND)

          Column() {
            ForEach(this.weeklyForecast, (day: WeatherDay) => {
              this.DayCard(day)
            }, (day: WeatherDay) => day.day)
          }
          .width('100%')

          // Extra info card
          Row() {
            Column({ space: 4 }) {
              Text('UV Index')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE_70)
              Text('Moderate')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(COLOR_ON_SURFACE)
            }
            Column({ space: 4 }) {
              Text('Sunset')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE_70)
              Text('7:45 PM')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(COLOR_ON_SURFACE)
            }
            Column({ space: 4 }) {
              Text('Visibility')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_ON_SURFACE_70)
              Text('10 mi')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(COLOR_ON_SURFACE)
            }
          }
          .width('100%')
          .padding(10)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(10)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: 10, right: 10, top: 14, bottom: 14 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom bar
      Row() {
        this.LocationButton('NY', 'New York')
        this.LocationButton('London', 'London')
        this.LocationButton('Tokyo', 'Tokyo')
      }
      .width('100%')
      .padding(10)
      .backgroundColor(COLOR_SURFACE)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
