@Entry
@Component
struct Index {
  @State currentLocation: string = "New York"
  @State temperature: string = "72°"
  @State condition: string = "Sunny"
  @State feelsLike: string = "74°"
  @State humidity: string = "45%"
  @State wind: string = "5 mph"

  private weeklyForecast: ForecastItem[] = [
    { day: 'Mon', high: '75°', low: '60°' },
    { day: 'Tue', high: '78°', low: '62°' },
    { day: 'Wed', high: '70°', low: '58°' }
  ];

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 14 }) {
        // Current Weather Card
        Column() {
          Column({ space: 6 }) {
            Text(this.currentLocation).fontSize(20).fontWeight(FontWeight.Medium).fontColor('#263238')
            Text(this.temperature).fontSize(32).fontWeight(FontWeight.Bold).lineHeight(36).fontColor('#263238')
            Text(this.condition).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#263238')
            
            Row({ space: 0 }) {
              Column({ space: 4 }) {
                Text('Feels like').fontSize(12).fontColor('#263238')
                Text(this.feelsLike).fontSize(14).fontColor('#263238')
              }.alignItems(HorizontalAlign.Center)
              
              Column({ space: 4 }) {
                Text('Humidity').fontSize(12).fontColor('#263238')
                Text(this.humidity).fontSize(14).fontColor('#263238')
              }.alignItems(HorizontalAlign.Center)
              
              Column({ space: 4 }) {
                Text('Wind').fontSize(12).fontColor('#263238')
                Text(this.wind).fontSize(14).fontColor('#263238')
              }.alignItems(HorizontalAlign.Center)
            }.alignItems(VerticalAlign.Center).width('100%')
          }.alignItems(HorizontalAlign.Center).padding(14)
        }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width('100%')

        // Hourly Forecast Section
        Text('Hourly Forecast').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#263238')
        
        List({ space: 6 }) {
          ListItem() {
            Column() {
              Column({ space: 4 }) {
                Text('Now').fontSize(12).fontColor('#263238')
                // Placeholder for icon/image as per rules
                Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
                Text('72°').fontSize(14).fontColor('#263238')
              }.alignItems(HorizontalAlign.Center).padding(6)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width(70)
          }
        }.width('100%').listDirection(Axis.Horizontal)

        // 7-Day Forecast Section
        Text('7-Day Forecast').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#263238')
        
        Column({ space: 6 }) {
          ForEach(this.weeklyForecast, (item: ForecastItem) => {
            Column() {
              Row({ space: 0 }) {
                Text(item.day).fontSize(14).fontColor('#263238').width(40)
                
                // Placeholder for icon/image
                Image($r('app.media.startIcon')).width(16).height(16).objectFit(ImageFit.Contain)
                
                Row({ space: 6 }) {
                  Text(item.high).fontSize(14).fontColor('#263238')
                  Text(item.low).fontSize(14).fontColor('#263238')
                }.alignItems(VerticalAlign.Center)
              }.alignItems(VerticalAlign.Center).width('100%').padding(10)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width('100%')
          })
        }

        // Details Card (UV, Sunset, Visibility)
        Column() {
          Row({ space: 0 }) {
            Column({ space: 4 }) {
              Text('UV Index').fontSize(12).fontColor('#263238')
              Text('Moderate').fontSize(14).fontColor('#263238')
            }
            Column({ space: 4 }) {
              Text('Sunset').fontSize(12).fontColor('#263238')
              Text('7:45 PM').fontSize(14).fontColor('#263238')
            }
            Column({ space: 4 }) {
              Text('Visibility').fontSize(12).fontColor('#263238')
              Text('10 mi').fontSize(14).fontColor('#263238')
            }
          }.alignItems(VerticalAlign.Center).width('100%').padding(10)
        }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width('100%')
      }.width('100%').height('100%').padding({ left: 10, right: 10 })

      // Top App Bar Simulation
      Column() {
        Text('Weather').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#263238').textAlign(TextAlign.Center)
      }.width('100%').position({ x: 0, y: 0 })

      // Bottom Navigation Simulation
      Column() {
        Row({ space: 0 }) {
          Button() {
            Text('NY').fontSize(12)
          }.height(32).width(80).onClick(() => {
            this.currentLocation = "New York"
          })
          
          Button() {
            Text('London').fontSize(12)
          }.height(32).width(80).onClick(() => {
            this.currentLocation = "London"
          })
          
          Button() {
            Text('Tokyo').fontSize(12)
          }.height(32).width(80).onClick(() => {
            this.currentLocation = "Tokyo"
          })
        }.alignItems(VerticalAlign.Center).width('100%').padding(10)
      }.backgroundColor('#FFFFFF').shadow({ radius: 4, color: '#1A000000' }).width('100%').position({ x: 0, y: -100 })
    }.width('100%').height('100%')
  }
}

interface ForecastItem {
  day: string;
  high: string;
  low: string;
}