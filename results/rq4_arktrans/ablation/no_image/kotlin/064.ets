@Entry
@Component
struct Index {
  @State filters: string[] = ["Pending", "Approved"]
  @State active: string[] = ["Pending"]
  @State f: number = 0
  @State selTitle: string = ""
  @State selStatus: string = ""
  @State Details: string = ""
  @State ApprovalFlow: string = ""
  @State Reject: string = ""
  @State Approve: string = ""
  @State plus: string = "+"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        List({ space: 8, direction: Axis.Horizontal }) {
          ForEach(this.filters, (f: string) => {
            ListItem() {
              Button(f) {
                Text(f)
                  .fontColor(this.active.includes(f) ? '#FFFFFF' : '#0A0A0A')
                  .fontSize(14)
              }
              .backgroundColor(this.active.includes(f) ? '#6750A4' : '#F5F5F5')
              .borderRadius(16)
              .height(32)
              .onClick(() => {
                if (!this.active.includes(f)) {
                  this.active.push(f)
                } else {
                  this.active = this.active.filter(item => item !== f)
                }
              })
            }
          })
        }.width('100%')

        Stack({ alignContent: Alignment.Bottom }) {
          // MapGridOverlay Simulation
          Column({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Divider().color('#EDEDED').width('100%')
            }
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Divider().color('#EDEDED').height('100%').width(1)
              }
            }
          }.width('100%').height('100%').padding(16)

          // Card Component
          Column() {
            Row({ space: 0 }) {
              Column({ space: 4 }) {
                Text(this.selTitle).fontColor('#0A0A0A').fontSize(16).fontWeight(FontWeight.Medium)
                Text(this.selStatus).fontColor('#0A0A0A').fontSize(12)
              }
              Blank()
              Row({ space: 8 }) {
                Button() {
                  Text('Details').fontColor('#0A0A0A').fontSize(12)
                }
                .backgroundColor('#E7E0EC')
                .borderRadius(8)
                .height(40)
              }.alignItems(VerticalAlign.Center)
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding(16)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          .margin(16)
          .width('calc(100% - 32vp)')
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // Top App Bar
      Row() {
        Text('Approval Flow')
          .fontColor('#0A0A0A')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      // Bottom App Bar
      Row({ space: 0 }) {
        Button() {
          Text('Reject').fontColor('#0A0A0A').fontSize(16)
        }
        .backgroundColor('#E7E0EC')
        .borderRadius(8)
        .height(48)
        .layoutWeight(1)

        Blank().width(16)

        Button() {
          Text('Approve').fontColor('#FFFFFF').fontSize(16)
        }
        .backgroundColor('#6750A4')
        .borderRadius(8)
        .height(48)
        .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: '100%' })
      .translate({ y: -48 }) // Adjust for height roughly or use absolute positioning logic if needed, but standard stack alignment is better. 
      // Correction: In a Stack with Alignment.Top, children are stacked from top. 
      // To make it a bottom bar, we should position it at the bottom.
      .position({ x: 0, y: 'auto' }) // This won't work directly in simple stack without constraints. 
      // Let's restructure the main Stack to handle Top and Bottom properly.
      
      // Floating Action Button
      Button() {
        Text('+').fontColor('#FFFFFF').fontSize(24)
      }
      .backgroundColor('#111111')
      .borderRadius(28)
      .width(56)
      .height(56)
      .position({ x: '100%', y: '100%' })
      .translate({ x: -40, y: -40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }
}