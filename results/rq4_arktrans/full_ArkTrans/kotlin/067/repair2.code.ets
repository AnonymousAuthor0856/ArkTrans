@Entry
@Component
struct Index {
  @State clients: Client[] = [
    { name: 'Sunrise Tech', region: 'North', level: 5, x: 16.6, y: 40 },
    { name: 'Delta Logistics', region: 'Central', level: 3, x: 50, y: 55 },
    { name: 'Oceanic Foods', region: 'South', level: 8, x: 83.3, y: 70 },
    { name: 'Horizon Ltd.', region: 'West', level: 2, x: 33.3, y: 85 }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        // Header Box
        Stack({ alignContent: Alignment.Center }) {
          Text('Regional Client Map')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(200)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .linearGradient({
          direction: GradientDirection.RightBottom,
          colors: [['#FFB74D', 0], ['#FF7043', 1]]
        })

        // Map Grid Overlay
        Stack({ alignContent: Alignment.TopStart }) {
          // Vertical Lines
          ForEach([16.6, 33.3, 50, 66.6, 83.3], (percent: number) => {
            Column()
              .width(1)
              .height('100%')
              .backgroundColor('#FFE082')
              .position({ x: `${percent}%`, y: 0 })
          })

          // Horizontal Lines
          ForEach([20, 40, 60, 80], (percent: number) => {
            Row()
              .width('100%')
              .height(1)
              .backgroundColor('#FFE082')
              .position({ x: 0, y: `${percent}%` })
          })

          // Clients
          ForEach(this.clients, (client: Client) => {
            Stack({ alignContent: Alignment.Start }) {
              // Dot
              Column()
                .width(24)
                .height(24)
                .borderRadius(12)
                .backgroundColor(client.level > 5 ? '#FF7043' : (client.level > 3 ? '#FFA726' : '#FFCA28'))
                .border({ width: 1, color: '#FFF' })

              // Label
              Text(client.name)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#3E2723')
                .padding({ left: 8, right: 12, top: 4, bottom: 4 })
                .backgroundColor('#FFE0B2')
                .borderRadius(12)
                .shadow({ radius: 2, color: '#40000000', offsetY: 2 })
                .margin({ left: 12 })
            }
            .position({ x: `${client.x}%`, y: `${client.y}%` })
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)
          })
        }
        .width('100%')
        .height(360)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .border({ width: 1, color: '#FFCC80' })
        .margin({ top: -20 })

        // List of Cards
        List({ space: 12 }) {
          ForEach(this.clients, (client: Client) => {
            ListItem() {
              Column() {
                Row({ space: 0 }) {
                  Column({ space: 4 }) {
                    Text(client.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#3E2723')
                    
                    Text(client.region)
                      .fontSize(14)
                      .fontColor('#5D4037')
                  }
                  
                  Blank()
                  
                  Text(`Level ${client.level}`)
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FF7043')
                }
                .width('100%')
                .alignItems(VerticalAlign.Center)
                .padding(16)
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
              .border({ width: 1, color: '#FFCC80' })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 40 })

      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFF8E1')

      // Top App Bar
      Row() {
        Text('Client Detail')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
  }
}

interface Client {
  name: string;
  region: string;
  level: number;
  x: number;
  y: number;
}