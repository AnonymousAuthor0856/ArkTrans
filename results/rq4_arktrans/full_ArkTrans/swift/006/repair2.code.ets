@Entry
@Component
struct Index {
  @State selectedCity: number = 0

  build() {
    Stack() {
      Column() {
        Text('Weather')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F2937')
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 44, bottom: 18 })

        Scroll() {
          Column() {
            // Current Weather Card
            Column() {
              Text('New York')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F2937')
              
              Text('72°')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1F2937')
                .margin({ top: 4 })
              
              Text('Sunny')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#6B7280')
                .margin({ top: 4 })

              Row() {
                Column() {
                  Text('Feels like')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#9CA3AF')
                  Text('74°')
                    .fontSize(12)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#1F2937')
                    .margin({ top: 2 })
                }
                
                Blank()
                
                Column() {
                  Text('Humidity')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#9CA3AF')
                  Text('45%')
                    .fontSize(12)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#1F2937')
                    .margin({ top: 2 })
                }
                
                Blank()
                
                Column() {
                  Text('Wind')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#9CA3AF')
                  Text('5 mph')
                    .fontSize(12)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#1F2937')
                    .margin({ top: 2 })
                }
              }.padding({ left: 20, right: 20 }).margin({ top: 16 })

            }
            .width('100%')
            .padding(18)
            .backgroundColor('#FFFFFF')
            .borderRadius(14)
            .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: 2 })

            // Hourly Forecast
            Column() {
              Text('Hourly Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F2937')
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 10 })

              Scroll() {
                Row({ space: 6 }) {
                  ForEach([
                    { time: 'Now', temp: '72°', color: '#FFA500' },
                    { time: '1 PM', temp: '74°', color: '#FFA500' },
                    { time: '2 PM', temp: '75°', color: '#FFA500' },
                    { time: '3 PM', temp: '76°', color: '#1E90FF' }
                  ], (item: HourlyForecastItem) => {
                    Column() {
                      Text(item.time)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#1F2937')
                      
                      Circle()
                        .width(20)
                        .height(20)
                        .fill(item.color)
                        .margin({ top: 6, bottom: 6 })
                      
                      Text(item.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor('#1F2937')
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor('#FFFFFF')
                    .borderRadius(10)
                    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                  })
                }
              }.scrollBar(BarState.Off).scrollable(ScrollDirection.Horizontal)
            }.alignSelf(ItemAlign.Start).width('100%').margin({ top: 18 })

            // 7-Day Forecast
            Column() {
              Text('7-Day Forecast')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F2937')
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 10 })

              Column({ space: 6 }) {
                ForEach([
                  { day: 'Today', high: '76°', low: '62°', color: '#FFA500' },
                  { day: 'Mon', high: '74°', low: '60°', color: '#1E90FF' },
                  { day: 'Tue', high: '72°', low: '58°', color: '#32CD32' },
                  { day: 'Wed', high: '70°', low: '56°', color: '#32CD32' }
                ], (item: DailyForecastItem) => {
                  Row() {
                    Text(item.day)
                      .fontSize(12)
                      .fontWeight(FontWeight.Regular)
                      .fontColor('#1F2937')
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
                        .fontWeight(FontWeight.Regular)
                        .fontColor('#1F2937')
                      
                      Text(item.low)
                        .fontSize(12)
                        .fontWeight(FontWeight.Regular)
                        .fontColor('#6B7280')
                    }
                  }
                  .width('100%')
                  .padding(14)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(6)
                  .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                })
              }
            }.alignSelf(ItemAlign.Start).width('100%').margin({ top: 18 })

            // Bottom Stats
            Row() {
              Column() {
                Text('UV Index')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#9CA3AF')
                Text('Moderate')
                  .fontSize(12)
                  .fontWeight(FontWeight.Regular)
                  .fontColor('#1F2937')
                  .margin({ top: 2 })
              }
              
              Blank()
              
              Column() {
                Text('Sunrise')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#9CA3AF')
                Text('6:12 AM')
                  .fontSize(12)
                  .fontWeight(FontWeight.Regular)
                  .fontColor('#1F2937')
                  .margin({ top: 2 })
              }
              
              Blank()
              
              Column() {
                Text('Pressure')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#9CA3AF')
                Text('1012 hPa')
                  .fontSize(12)
                  .fontWeight(FontWeight.Regular)
                  .fontColor('#1F2937')
                  .margin({ top: 2 })
              }
            }
            .width('100%')
            .padding(18)
            .backgroundColor('#F3F4F6')
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
            .margin({ top: 18 })

          }
          .width('100%')
          .padding({ left: 14, right: 14, bottom: 80 })
        }
      }.width('100%').height('100%')

      // Bottom Navigation
      Column() {
        Rect()
          .width('100%')
          .height(1)
          .fill(Color.Transparent)
        
        Row() {
          Button() {
            Text('NY')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedCity === 0 ? '#FFFFFF' : '#1F2937')
          }
          .width(80)
          .height(32)
          .backgroundColor(this.selectedCity === 0 ? '#1E90FF' : '#E5E7EB')
          .borderRadius(10)
          .onClick(() => this.selectedCity = 0)
          
          Button() {
            Text('London')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedCity === 1 ? '#FFFFFF' : '#1F2937')
          }
          .width(80)
          .height(32)
          .backgroundColor(this.selectedCity === 1 ? '#1E90FF' : '#E5E7EB')
          .borderRadius(10)
          .onClick(() => this.selectedCity = 1)
          
          Button() {
            Text('Tokyo')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedCity === 2 ? '#FFFFFF' : '#1F2937')
          }
          .width(80)
          .height(32)
          .backgroundColor(this.selectedCity === 2 ? '#1E90FF' : '#E5E7EB')
          .borderRadius(10)
          .onClick(() => this.selectedCity = 2)
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .padding({ top: 14, bottom: 14 })
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 14, topRight: 14 })
        .shadow({ radius: 5, color: '#1F000000', offsetX: 0, offsetY: -2 })
      }
      .alignItems(HorizontalAlign.Center)
      .position({ x: 0, y: 0 })
      .width('100%')
      .alignSelf(ItemAlign.End)
    }.width('100%').height('100%').backgroundColor('#F9FAFB')
  }
}

interface HourlyForecastItem {
  time: string;
  temp: string;
  color: string;
}

interface DailyForecastItem {
  day: string;
  high: string;
  low: string;
  color: string;
}