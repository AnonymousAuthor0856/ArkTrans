@Entry
@Component
struct ClientDetailApp {
  @State selectedId: number | null = null
  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column().width('100%').height('100%').backgroundColor('#FFF8E1')
      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Text('Client Detail')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#3E2723')
            .padding({ top: 12, bottom: 12 })
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFF8E1')

        List({ space: 12 }) {
          ListItem() {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FFFFFF')
              .width('100%')
              .height(200)
              .textAlign(TextAlign.Center)
              .padding({ top: 80 })
              .backgroundColor('#FFB74D')
              .borderRadius(16)
          }

          ListItem() {
            Stack({ alignContent: Alignment.TopStart }) {
              Column()
                .width('100%')
                .height(360)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .border({ width: 1, color: '#E0C097' })

              Divider().width('100%').height(1).color('#FFECB3').position({ x: 16, y: 48 })
              Divider().width('100%').height(1).color('#FFECB3').position({ x: 16, y: 96 })
              Divider().width('100%').height(1).color('#FFECB3').position({ x: 16, y: 144 })
              Divider().width('100%').height(1).color('#FFECB3').position({ x: 16, y: 192 })
              Divider().width('100%').height(1).color('#FFECB3').position({ x: 16, y: 240 })
              Divider().width(1).height('100%').color('#FFECB3').position({ x: 64, y: 16 })
              Divider().width(1).height('100%').color('#FFECB3').position({ x: 128, y: 16 })
              Divider().width(1).height('100%').color('#FFECB3').position({ x: 192, y: 16 })
              Divider().width(1).height('100%').color('#FFECB3').position({ x: 256, y: 16 })

              ForEach(this.clients, (client: Client) => {
                Stack({ alignContent: Alignment.TopStart }) {
                  Column()
                    .width(this.selectedId === client.id ? 28 : 22)
                    .height(this.selectedId === client.id ? 28 : 22)
                    .borderRadius(this.selectedId === client.id ? 14 : 11)
                    .backgroundColor(this.getMarkerColor(client.level))
                    .border({ width: 2, color: '#FFFFFF' })
                    .onClick(() => {
                      this.selectedId = this.selectedId === client.id ? null : client.id
                    })
                  Text(client.name)
                    .fontSize(12)
                    .foregroundColor('#3E2723')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#FFECB3')
                    .borderRadius(8)
                    .border({ width: 1, color: '#E0C097' })
                    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
                    .position({ x: 20, y: -4 })
                }
                .position({ x: 360 * client.x, y: 360 * client.y })
              })
            }
            .width('100%')
            .aspectRatio(0.9)
            .height(360)
          }

          ForEach(this.clients, (client: Client) => {
            ListItem() {
              Stack({ alignContent: Alignment.TopStart }) {
                Column()
                  .width('100%')
                  .height(72)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(12)
                  .border({ width: 1, color: '#E0C097' })
                  .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

                Row({ space: 0 }) {
                  Column({ space: 4 }) {
                    Text(client.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#3E2723')
                    Text(client.region)
                      .fontSize(14)
                      .foregroundColor('#3E2723')
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Text('Level ' + client.level)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#FF7043')
                    .alignSelf(ItemAlign.Center)
                }
                .padding(16)
                .width('100%')
              }
              .width('100%')
              .height(72)
            }
          })

          ListItem() {
            Column()
              .height(32)
              .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  getMarkerColor(level: string): string {
    switch (level) {
      case 'A': return '#FF7043'
      case 'B': return '#FFB74D'
      default: return '#FFD54F'
    }
  }
}

interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}