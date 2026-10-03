@Entry
@Component
struct Index {
  @State totalValue: number = 2411.25

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content (LazyColumn) ===
      List({ space: 16 }) {
        ListItem() {
          // === PieChart ===
          Stack({ alignContent: Alignment.Center }) {
            // Simulated Pie Chart Background
            Canvas().width('100%').height('100%')
            
            Column({ space: 0 }) {
              Text('Total Spent')
                .fontSize(14)
                .fontColor('#718096')
                .fontWeight(FontWeight.Medium)
              
              Text('$' + this.totalValue.toLocaleString(undefined, { minimumFractionDigits: 2 }))
                .fontSize(24)
                .fontColor('#4A5568')
                .fontWeight(FontWeight.Bold)
            }.alignItems(HorizontalAlign.Center)
          }
          .width(240)
          .height(240)
          .borderRadius(120)
          .backgroundColor('#F7FAFC')
          // Visual simulation of the pie chart ring using border/background logic for UI skeleton
          .border({ width: 30, color: '#4A90E2', style: BorderStyle.Solid }) 
        }

        ListItem() {
          Column() {
            Blank().height(24)
          }
        }

        // === Card 1: Housing ===
        ListItem() {
          Column() {
            Row({ space: 0 }) {
              Row({ space: 16 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle().width(20).height(20).fill('#4A90E2')
                }
                Text('Housing')
                  .fontSize(16)
                  .fontColor('#1A202C')
              }.alignItems(VerticalAlign.Center)
              
              Text('$1,250.00')
                .fontSize(18)
                .fontColor('#1A202C')
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding({ top: 16, bottom: 16, left: 16, right: 16 })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        }

        // === Card 2: Food ===
        ListItem() {
          Column() {
            Row({ space: 0 }) {
              Row({ space: 16 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle().width(20).height(20).fill('#48C9B0')
                }
                Text('Food')
                  .fontSize(16)
                  .fontColor('#1A202C')
              }.alignItems(VerticalAlign.Center)
              
              Text('$480.50')
                .fontSize(18)
                .fontColor('#1A202C')
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding({ top: 16, bottom: 16, left: 16, right: 16 })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        }

        // === Card 3: Transport ===
        ListItem() {
          Column() {
            Row({ space: 0 }) {
              Row({ space: 16 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle().width(20).height(20).fill('#5D6DFF')
                }
                Text('Transport')
                  .fontSize(16)
                  .fontColor('#1A202C')
              }.alignItems(VerticalAlign.Center)
              
              Text('$210.00')
                .fontSize(18)
                .fontColor('#1A202C')
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .padding({ top: 16, bottom: 16, left: 16, right: 16 })
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        }

        ListItem() {
          Column() {
            Blank().height(48)
          }
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .backgroundColor('#F7FAFC')

      // === Top App Bar ===
      Column() {
        Text('Monthly Budget')
          .fontSize(24)
          .fontColor('#4A5568')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .padding({ top: 40, bottom: 10 })
      .backgroundColor('#F7FAFC')

      // === Floating Action Button ===
      Button() {
        Text('+')
          .fontSize(32)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Normal)
      }
      .width(56)
      .height(56)
      .backgroundColor('#4A5568')
      .borderRadius(28)
      .shadow({ radius: 8, color: '#3F000000', offsetX: 0, offsetY: 4 })
      .position({ x: 'calc(100% - 72px)', y: 'calc(100% - 140px)' })

      // === Bottom Navigation Bar ===
      Column() {
        Row({ space: 0 }) {
          // Home
          Column({ space: 4 }) {
            Stack({ alignContent: Alignment.Center }) {
               Circle().width(24).height(24).fill('#4A5568').opacity(0.2)
            }
            Text('Home')
              .fontSize(12)
              .fontColor('#4A5568')
              .fontWeight(FontWeight.Medium)
          }.alignItems(HorizontalAlign.Center)

          // Reports
          Column({ space: 4 }) {
            Stack({ alignContent: Alignment.Center }) {
               Circle().width(24).height(24).fill('#A0AEC0').opacity(0.2)
            }
            Text('Reports')
              .fontSize(12)
              .fontColor('#A0AEC0')
              .fontWeight(FontWeight.Medium)
          }.alignItems(HorizontalAlign.Center)

          // Spacer
          Blank().layoutWeight(1)

          // Goals
          Column({ space: 4 }) {
            Stack({ alignContent: Alignment.Center }) {
               Circle().width(24).height(24).fill('#A0AEC0').opacity(0.2)
            }
            Text('Goals')
              .fontSize(12)
              .fontColor('#A0AEC0')
              .fontWeight(FontWeight.Medium)
          }.alignItems(HorizontalAlign.Center)

          // Settings
          Column({ space: 4 }) {
            Stack({ alignContent: Alignment.Center }) {
               Circle().width(24).height(24).fill('#A0AEC0').opacity(0.2)
            }
            Text('Settings')
              .fontSize(12)
              .fontColor('#A0AEC0')
              .fontWeight(FontWeight.Medium)
          }.alignItems(HorizontalAlign.Center)
        }
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: 8, right: 8, top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .position({ x: 0, y: 'calc(100% - 80px)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7FAFC')
  }
}