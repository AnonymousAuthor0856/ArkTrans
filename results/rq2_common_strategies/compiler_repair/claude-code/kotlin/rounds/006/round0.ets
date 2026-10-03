@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = "New York"
  @State temperature: string = "72°"
  @State condition: string = "Sunny"
  @State feelsLike: string = "74°"
  @State humidity: string = "45%"
  @State wind: string = "5 mph"

  private hourlyForecast: WeatherHour[] = [
    { hour: "Now", temp: "72°", condition: "Sunny", color: AppTokens.Colors.tertiary },
    { hour: "1 PM", temp: "74°", condition: "Sunny", color: AppTokens.Colors.tertiary },
    { hour: "2 PM", temp: "75°", condition: "Sunny", color: AppTokens.Colors.tertiary },
    { hour: "3 PM", temp: "76°", condition: "Cloudy", color: AppTokens.Colors.primary },
    { hour: "4 PM", temp: "74°", condition: "Cloudy", color: AppTokens.Colors.primary },
    { hour: "5 PM", temp: "72°", condition: "Rain", color: AppTokens.Colors.secondary },
    { hour: "6 PM", temp: "70°", condition: "Rain", color: AppTokens.Colors.secondary }
  ]

  private weeklyForecast: WeatherDay[] = [
    { day: "Today", high: "76°", low: "62°", condition: "Sunny", color: AppTokens.Colors.tertiary },
    { day: "Mon", high: "74°", low: "60°", condition: "Cloudy", color: AppTokens.Colors.primary },
    { day: "Tue", high: "72°", low: "58°", condition: "Rain", color: AppTokens.Colors.secondary },
    { day: "Wed", high: "70°", low: "56°", condition: "Rain", color: AppTokens.Colors.secondary },
    { day: "Thu", high: "73°", low: "59°", condition: "Cloudy", color: AppTokens.Colors.primary },
    { day: "Fri", high: "75°", low: "61°", condition: "Sunny", color: AppTokens.Colors.tertiary },
    { day: "Sat", high: "77°", low: "63°", condition: "Sunny", color: AppTokens.Colors.tertiary }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Weather")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      // Content
      Scroll() {
        Column() {
          // Current Weather Card
          Column() {
            Column() {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTokens.Colors.onSurface)
              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.7)
              Row() {
                Column() {
                  Text("Feels like")
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.7)
                  Text(this.feelsLike)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Center)

                Column() {
                  Text("Humidity")
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.7)
                  Text(this.humidity)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Center)

                Column() {
                  Text("Wind")
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.7)
                  Text(this.wind)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Center)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceEvenly)
              .margin({ top: 6 })
            }
            .width('100%')
            .padding(14)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(14)
          .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: 2 })

          // Hourly Forecast Section
          Text("Hourly Forecast")
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ top: 14 })

          // Hourly Forecast List
          List({ space: 6 }) {
            ForEach(this.hourlyForecast, (item: WeatherHour) => {
              ListItem() {
                Column() {
                  Text(item.hour)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                  Circle()
                    .width(20)
                    .height(20)
                    .fill(item.color)
                  Text(item.temp)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                }
                .width(70)
                .padding(6)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(10)
                .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
              }
            }, (item: WeatherHour) => item.hour)
          }
          .listDirection(Axis.Horizontal)
          .width('100%')
          .height(100)

          // 7-Day Forecast Section
          Text("7-Day Forecast")
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ top: 14 })

          // Weekly Forecast List
          Column({ space: 6 }) {
            ForEach(this.weeklyForecast, (item: WeatherDay) => {
              Row() {
                Text(item.day)
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width(40)
                Circle()
                  .width(16)
                  .height(16)
                  .fill(item.color)
                Row({ space: 6 }) {
                  Text(item.high)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text(item.low)
                    .fontSize(12)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.5)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .padding(10)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(6)
              .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
            }, (item: WeatherDay) => item.day)
          }
          .width('100%')

          // Info Card (UV Index, Sunset, Visibility)
          Row() {
            Column({ space: 4 }) {
              Text("UV Index")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.7)
              Text("Moderate")
                .fontSize(12)
                .fontColor(AppTokens.Colors.onSurface)
            }

            Column({ space: 4 }) {
              Text("Sunset")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.7)
              Text("7:45 PM")
                .fontSize(12)
                .fontColor(AppTokens.Colors.onSurface)
            }

            Column({ space: 4 }) {
              Text("Visibility")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.7)
              Text("10 mi")
                .fontSize(12)
                .fontColor(AppTokens.Colors.onSurface)
            }
          }
          .width('100%')
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(10)
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
          .margin({ top: 14 })
        }
        .width('100%')
        .padding({ left: 10, right: 10, top: 0, bottom: 10 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)

      // Bottom Bar
      Row() {
        Button("NY")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .height(32)
          .width(80)
          .backgroundColor(this.currentLocation === "New York" ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === "New York" ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .borderRadius(10)
          .onClick(() => {
            this.currentLocation = "New York"
          })

        Button("London")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .height(32)
          .width(80)
          .backgroundColor(this.currentLocation === "London" ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === "London" ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .borderRadius(10)
          .onClick(() => {
            this.currentLocation = "London"
          })

        Button("Tokyo")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .height(32)
          .width(80)
          .backgroundColor(this.currentLocation === "Tokyo" ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
          .fontColor(this.currentLocation === "Tokyo" ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
          .borderRadius(10)
          .onClick(() => {
            this.currentLocation = "Tokyo"
          })
      }
      .width('100%')
      .padding(10)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

interface WeatherHour {
  hour: string
  temp: string
  condition: string
  color: ResourceColor
}

interface WeatherDay {
  day: string
  high: string
  low: string
  condition: string
  color: ResourceColor
}

namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#2196F3'
    export const secondary: ResourceColor = '#4CAF50'
    export const tertiary: ResourceColor = '#FF9800'
    export const background: ResourceColor = '#F5F7FA'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#E8F5E8'
    export const outline: ResourceColor = '#E0E0E0'
    export const success: ResourceColor = '#4CAF50'
    export const warning: ResourceColor = '#FF9800'
    export const error: ResourceColor = '#F44336'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#FFFFFF'
    export const onTertiary: ResourceColor = '#FFFFFF'
    export const onBackground: ResourceColor = '#263238'
    export const onSurface: ResourceColor = '#263238'
  }
}
