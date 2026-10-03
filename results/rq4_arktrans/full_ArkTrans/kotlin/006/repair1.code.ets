@Entry
@Component
struct Index {
  @State currentLocation: string = "New York"

  interface HourlyItem {
    hour: string;
    temp: string;
    color: string;
  }

  interface WeeklyItem {
    day: string;
    high: string;
    low: string;
    color: string;
  }

  // Mock Data for Hourly Forecast
  private hourlyData: Array<HourlyItem> = [
    { hour: 'Now', temp: '72°', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', color: '#2196F3' }
  ]

  // Mock Data for 7-Day Forecast
  private weeklyData: Array<WeeklyItem> = [
    { day: 'Today', high: '76°', low: '62°', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', color: '#4CAF50' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Main Scrollable Content
      Column({ space: 14 }) {
        // Current Weather Card
        Column() {
          Column({ space: 6 }) {
            Text(this.currentLocation)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#263238')

            Text('72°')
              .fontSize(64)
              .fontWeight(FontWeight.Bold)
              .lineHeight(72)
              .fontColor('#263238')

            Text('Sunny')
              .fontSize(18)
              .fontColor('#263238')

            Row({ space: 0 }) {
              Column({ space: 4 }) {
                Text('Feels like').fontSize(14).fontColor('#263238')
                Text('74°').fontSize(16).fontColor('#263238')
              }.alignItems(HorizontalAlign.Center)

              Column({ space: 4 }) {
                Text('Humidity').fontSize(14).fontColor('#263238')
                Text('45%').fontSize(16).fontColor('#263238')
              }.alignItems(HorizontalAlign.Center)

              Column({ space: 4 }) {
                Text('Wind').fontSize(14).fontColor('#263238')
                Text('5 mph').fontSize(16).fontColor('#263238')
              }.alignItems(HorizontalAlign.Center)
            }
            .justifyContent(FlexAlign.SpaceEvenly)
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .alignItems(HorizontalAlign.Center)
          .padding(20)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .width('100%')

        // Hourly Forecast Section
        Text('Hourly Forecast')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')

        List({ space: 6 }) {
          ForEach(this.hourlyData, (item: HourlyItem) => {
            ListItem() {
              Column() {
                Column({ space: 4 }) {
                  Text(item.hour).fontSize(14).fontColor('#263238')
                  
                  // Icon Placeholder
                  Stack({ alignContent: Alignment.Center }) {
                    Circle().width(24).height(24).fill(item.color)
                  }
                  .width(24).height(24)

                  Text(item.temp).fontSize(16).fontColor('#263238')
                }
                .alignItems(HorizontalAlign.Center)
                .padding(10)
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
              .width(80)
            }
          }, (item: HourlyItem) => item.hour)
        }
        .width('100%')
        .listDirection(Axis.Horizontal)

        // 7-Day Forecast Section
        Text('7-Day Forecast')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')

        Column({ space: 6 }) {
          ForEach(this.weeklyData, (item: WeeklyItem) => {
            Column() {
              Row({ space: 0 }) {
                Text(item.day)
                  .fontSize(16)
                  .fontColor('#263238')
                  .width(60)

                // Spacer to push icon to center visually or use layout weight
                Blank()

                Stack({ alignContent: Alignment.Center }) {
                   Circle().width(20).height(20).fill(item.color)
                }
                .width(20).height(20)

                Blank()

                Row({ space: 8 }) {
                  Text(item.high).fontSize(16).fontColor('#263238')
                  Text(item.low).fontSize(16).fontColor('#9E9E9E')
                }
                .alignItems(VerticalAlign.Center)
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .padding(12)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            .width('100%')
          }, (item: WeeklyItem) => item.day)
        }

        // Details Card (UV, Sunset, Visibility)
        Column() {
          Row({ space: 0 }) {
            Column({ space: 4 }) {
              Text('UV Index').fontSize(14).fontColor('#263238')
              Text('Moderate').fontSize(16).fontColor('#263238')
            }
            
            Column({ space: 4 }) {
              Text('Sunset').fontSize(14).fontColor('#263238')
              Text('7:45 PM').fontSize(16).fontColor('#263238')
            }

            Column({ space: 4 }) {
              Text('Visibility').fontSize(14).fontColor('#263238')
              Text('10 mi').fontSize(16).fontColor('#263238')
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding(12)
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .width('100%')
        
        // Bottom padding for the navigation bar
        Column().height(80)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F5F7FA')

      // Top App Bar
      Column() {
        Text('Weather')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#263238')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 40, bottom: 10 })
      }
      .width('100%')
      .position({ x: 0, y: 0 })

      // Bottom Navigation Bar
      Column() {
        Row({ space: 0 }) {
          Button() {
            Text('NY').fontSize(16).fontColor(this.currentLocation === 'New York' ? '#FFFFFF' : '#263238')
          }
          .height(40)
          .width(80)
          .backgroundColor(this.currentLocation === 'New York' ? '#2196F3' : '#E0E0E0')
          .borderRadius(20)
          .onClick(() => { this.currentLocation = 'New York' })

          Button() {
            Text('London').fontSize(16).fontColor(this.currentLocation === 'London' ? '#FFFFFF' : '#263238')
          }
          .height(40)
          .width(80)
          .backgroundColor(this.currentLocation === 'London' ? '#2196F3' : '#E0E0E0')
          .borderRadius(20)
          .onClick(() => { this.currentLocation = 'London' })

          Button() {
            Text('Tokyo').fontSize(16).fontColor(this.currentLocation === 'Tokyo' ? '#FFFFFF' : '#263238')
          }
          .height(40)
          .width(80)
          .backgroundColor(this.currentLocation === 'Tokyo' ? '#2196F3' : '#E0E0E0')
          .borderRadius(20)
          .onClick(() => { this.currentLocation = 'Tokyo' })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding(10)
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .width('100%')
      .position({ x: 0, y: 0 })
      .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}