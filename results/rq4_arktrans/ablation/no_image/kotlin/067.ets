@Entry
@Component
struct Index {
  @State clients: Client[] = [
    { id: 1, name: 'Client A', region: 'North', level: 3, x: 0.2, y: 0.3 },
    { id: 2, name: 'Client B', region: 'South', level: 5, x: 0.7, y: 0.6 },
    { id: 3, name: 'Client C', region: 'East', level: 2, x: 0.8, y: 0.2 }
  ]
  @State selectedId: number | null = null

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
        .linearGradient({
          direction: GradientDirection.RightBottom,
          colors: [['#FFB74D', 0], ['#FF9800', 1]]
        })
        .borderRadius(16)

        // Map Container (BoxWithConstraints equivalent)
        Stack({ alignContent: Alignment.TopStart }) {
          // Grid Overlay
          Column({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Divider().color('#FFECB3').width('100%')
            }.width('100%').height(1)
          }.width('100%').height('100%').padding(16)

          Row({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Divider().color('#FFECB3').height('100%')
            }.width(1).height('100%')
          }.width('100%').height('100%').padding(16)

          // Markers
          ForEach(this.clients, (client: Client) => {
            Stack({ alignContent: Alignment.TopStart }) {
              // Marker Dot
              Stack({ alignContent: Alignment.Center }) {
                Circle()
                  .width(this.selectedId === client.id ? 28 : 22)
                  .height(this.selectedId === client.id ? 28 : 22)
                  .fill(this.selectedId === client.id ? '#FF9800' : '#FFE0B2')
                  .border({ width: 2, color: this.selectedId === client.id ? '#FFF' : '#FFB74D' })
              }
              .onClick(() => {
                this.selectedId = this.selectedId === client.id ? null : client.id
              })

              // Detail Card
              if (this.selectedId === client.id) {
                Column() {
                  Text(client.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#3E2723')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                }
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .shadow({ radius: 4, color: '#1A000000' })
                .border({ width: 1, color: '#FFCC80' })
                .position({ x: 20, y: -4 })
              }
            }
            .position({
              x: 16 + (client.x * (getWindowSize().width - 32)),
              y: 16 + (client.y * (getWindowSize().height - 32))
            })
          })
        }
        .width('100%')
        .height(360)
        .backgroundColor('#FFF8E1')
        .borderRadius(16)
        .border({ width: 1, color: '#FFCC80' })

        // List Section
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
                      .fontColor('#3E2723')
                  }
                  Blank()
                  Text(`Level ${client.level}`)
                    .fontSize(14)
                    .fontColor('#FF7043')
                }
                .alignItems(VerticalAlign.Center)
                .width('100%')
                .padding(16)
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000' })
              .border({ width: 1, color: '#FFCC80' })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // Top App Bar
      Row() {
        Text('Client Detail')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFF8E1')
    }
    .width('100%')
    .height('100%')
  }
}

interface Client {
  id: number;
  name: string;
  region: string;
  level: number;
  x: number;
  y: number;
}

interface WindowSize {
  width: number;
  height: number;
}

function getWindowSize(): WindowSize {
  return { width: 375, height: 812 }; // Placeholder for actual window size logic
}