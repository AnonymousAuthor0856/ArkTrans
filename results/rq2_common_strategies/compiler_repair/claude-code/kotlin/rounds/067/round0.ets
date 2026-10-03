@Entry
@Component
struct ClientDetailPage {
  @State selectedId: number | null = null;

  private clients = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFF8E1')

      Scroll() {
        Column() {
          // Gradient header
          Stack() {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#FFFFFF')
          }
          .width('100%')
          .height(200)
          .borderRadius(16)
          .linearGradient({
            direction: GradientDirection.LeftRight,
            colors: [['#FFB74D', 0.0], ['#FF7043', 1.0]]
          })
          .margin({ bottom: 12 })

          // Map area
          Stack({ alignContent: Alignment.TopStart }) {
            // Grid overlay
            Stack() {
              Column() {
                ForEach(Array.from({ length: 6 }, (_, i) => i), (item: number) => {
                  Row()
                    .width('100%')
                    .height(1)
                    .backgroundColor('#FFECB3')
                })
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.SpaceEvenly)
              .padding(16)

              Row() {
                ForEach(Array.from({ length: 6 }, (_, i) => i), (item: number) => {
                  Column()
                    .width(1)
                    .height('100%')
                    .backgroundColor('#FFECB3')
                })
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.SpaceEvenly)
              .padding(16)
            }
            .width('100%')
            .height('100%')

            // Map markers
            ForEach(this.clients, (client: { id: number; name: string; region: string; level: string; x: number; y: number }) => {
              Stack() {
                // Marker dot
                Circle({ width: this.selectedId === client.id ? 28 : 22, height: this.selectedId === client.id ? 28 : 22 })
                  .fill(this.getLevelColor(client.level))
                  .stroke(this.selectedId === client.id ? '#FFFFFF' : '#FFFFFFFF', 2)
                  .position({ x: 0, y: 0 })

                // Label card
                Stack() {
                  Text(client.name)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#3E2723')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                }
                .backgroundColor('#FFECB3')
                .borderRadius(8)
                .border({ width: 1, color: '#E0C097' })
                .position({ x: 20, y: -4 })
              }
              .position({
                x: `${client.x * 100}%`,
                y: `${client.y * 100}%`
              })
              .translate({ x: -11, y: -11 })
              .onClick(() => {
                this.selectedId = this.selectedId === client.id ? null : client.id;
              })
            }, (client: { id: number; name: string }) => client.id.toString())
          }
          .width('100%')
          .aspectRatio(0.9)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#E0C097' })
          .margin({ bottom: 12 })

          // Client list
          Column() {
            ForEach(this.clients, (client: { id: number; name: string; region: string; level: string; x: number; y: number }) => {
              Row() {
                Column() {
                  Text(client.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#3E2723')
                    .margin({ bottom: 4 })
                  Text(client.region)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#3E2723')
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Text(`Level ${client.level}`)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF7043')
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .border({ width: 1, color: '#E0C097' })
              .margin({ bottom: 12 })
            }, (client: { id: number; name: string }) => client.id.toString())
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E1')
  }

  private getLevelColor(level: string): ResourceColor {
    switch (level) {
      case 'A':
        return '#FF7043';
      case 'B':
        return '#FFB74D';
      default:
        return '#FFD54F';
    }
  }
}
