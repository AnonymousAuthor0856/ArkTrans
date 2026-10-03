@Entry
@Component
struct MetroPlannerApp {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private bottomBarHeight: number = 56
  private fabSize: number = 56

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main content Column
      Column({ space: 16 }) {
        // Header
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#00FFFF')
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 16, top: 16 })

        // Metro line visualization (simplified straight line with circles)
        Stack({ alignContent: Alignment.Center }) {
          // The line
          Divider()
            .width('100%')
            .height(6)
            .color('#00B4FF')
          // Station circles
          Row({ space: 0 }) {
            ForEach(this.stations, (station: string, index: number) => {
              // Outer circle (primary color)
              Button() {
                // Inner circle (background color)
                Button() {
                  Text(station)
                    .fontSize(12)
                    .foregroundColor('#00FFFF')
                    .textAlign(TextAlign.Center)
                }
                .width(12)
                .height(12)
                .borderRadius(6)
                .backgroundColor('#0A0A1A')
              }
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#00FFFF')
              .margin({ left: index === 0 ? 0 : (320 / (this.stations.length - 1) - 32) }) // simulate equal spacing
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .height(260)
        .padding(10)
        .backgroundColor('#1E1E4A')
        .borderRadius(22)
        .margin({ left: 16, right: 16 })

        // Next Departures Card
        List({ space: 6 }) {
          ListItem() {
            Column({ space: 6 }) {
              Text('Next Departures')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#00B4FF')
              ForEach(['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3'], (departure: string) => {
                Row({ space: 0 }) {
                  Text(departure)
                    .fontSize(14)
                    .foregroundColor('#FFFFFF')
                  Blank()
                  Text('On Time')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#00FFAA')
                }
                .width('100%')
              })
            }
            .padding(16)
            .backgroundColor('#141436')
            .borderRadius(22)
            .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .layoutWeight(1)

        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#0A0A1A')
      .padding({ bottom: this.bottomBarHeight })

      // Bottom App Bar
      Row({ space: 0 }) {
        Text('Routes')
          .fontSize(14)
          .foregroundColor('#00B4FF')
        Blank()
        Text('Planner')
          .fontSize(14)
          .foregroundColor('#FFFFFF')
        Blank()
        Text('Tickets')
          .fontSize(14)
          .foregroundColor('#FFFFFF')
        Blank()
        Text('Profile')
          .fontSize(14)
          .foregroundColor('#FFFFFF')
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor('#141436')
      .padding({ left: 16, right: 16 })
      .position({ x: 0, y: '100%' }) // position at bottom

      // Floating Action Button (FAB)
      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#0A0A1A')
          .textAlign(TextAlign.Center)
      }
      .width(this.fabSize)
      .height(this.fabSize)
      .borderRadius(this.fabSize / 2)
      .backgroundColor('#00FFFF')
      .position({ x: '100%', y: '100%' })
      .margin({ right: 16, bottom: this.bottomBarHeight + 16 }) // offset from bottom bar
    }
    .width('100%')
    .height('100%')
  }
}