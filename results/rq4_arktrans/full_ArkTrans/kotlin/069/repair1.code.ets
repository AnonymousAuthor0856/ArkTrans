@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'

  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Area ===
      List({ space: 24 }) {
        ListItem() {
          // === Filter Chips Row ===
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.filters, (filter: string) => {
              Button(filter)
                .type(ButtonType.Normal)
                .backgroundColor(this.activeFilter === filter ? '#C67C33' : '#2D241E')
                .fontColor('#FBEFE0')
                .borderRadius(12)
                .margin({ right: 12 })
                .onClick(() => {
                  this.activeFilter = filter
                })
            }, (item: string) => item)
          }.width('100%')
        }

        ListItem() {
          // === Cargo Grid Section ===
          Column() {
            Text('Cargo grid')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FBEFE0')
              .margin({ bottom: 20 })

            // === Grid Layout ===
            CustomGridRow() {
              CustomGridCol() {
                this.CargoCard('Copper stack', 'SH-014', 'Fill 78%')
              }
              CustomGridCol() {
                this.CargoCard('Fiber reels', 'SH-022', 'Fill 64%')
              }
            }
            CustomGridRow() {
              CustomGridCol() {
                this.CargoCard('Steel beams', 'SH-055', 'Fill 92%')
              }
              CustomGridCol() {
                this.CargoCard('Grain silos', 'SH-019', 'Fill 45%')
              }
            }
          }
        }

        ListItem() {
          // === Route Manifest Section ===
          Column() {
            Text('Route manifest')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FBEFE0')
              .margin({ bottom: 20 })

            // === Manifest Item ===
            Row() {
              Column() {
                Text('Port A → Port B')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FBEFE0')
                Text('In flight')
                  .fontSize(14)
                  .fontColor('#4CAF50') // Success color
                  .margin({ top: 4 })
              }
              Blank()
              Button('Details')
                .type(ButtonType.Normal)
                .backgroundColor('#C67C33')
                .fontColor('#100C08')
                .borderRadius(12)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#2D241E')
            .borderRadius(16)
          }
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24, top: 100, bottom: 120 }) // Space for header and footer
      .backgroundColor('#100C08')

      // === Header (Top App Bar) ===
      Column() {
        Row() {
          // Left Icon Placeholder
          Circle().width(40).height(40).fill('#2D241E')
          
          Column() {
            Text('SupplyHub')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FBEFE0')
            Text('Logistics grid')
              .fontSize(14)
              .fontColor('#A0A0A0')
              .margin({ top: 2 })
          }
          
          // Right Icon Placeholder
          Circle().width(40).height(40).fill('#2D241E')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 24, right: 24, top: 50, bottom: 20 })
      }
      .position({ x: 0, y: 0 })
      .width('100%')
      .zIndex(10)

      // === Footer (Bottom Sheet) ===
      Column() {
        Row() {
          Column() {
            Text('Manifest filter')
              .fontSize(14)
              .fontColor('#A0A0A0')
            Text(this.activeFilter)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FBEFE0')
              .margin({ top: 4 })
          }
          Blank()
          Button('Dispatch')
            .type(ButtonType.Normal)
            .backgroundColor('#C67C33')
            .fontColor('#100C08')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .borderRadius(24)
            .width(140)
            .height(50)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 24, right: 24, top: 20, bottom: 20 })
      }
      .position({ x: 0, y: -100 }) // Adjust based on screen height if needed, or use absolute positioning relative to bottom
      .width('100%')
      .backgroundColor('#19110D')
      .shadow({ radius: 10, color: '#000000', offsetY: -5 })
      .zIndex(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#100C08')
  }

  @Builder
  CargoCard(title: string, id: string, fill: string) {
    Column() {
      // Image Placeholder
      Stack({ alignContent: Alignment.Center }) {
        Rect().width('100%').height('100%').fill('#1A1410').borderRadius(12)
        Circle().width(60).height(60).fill('#5C4A3D')
      }
      .width('100%')
      .height(100)
      .margin({ bottom: 16 })

      Text(title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FBEFE0')
      
      Text(id)
        .fontSize(16)
        .fontColor('#A0A0A0')
        .margin({ top: 4 })

      Text(fill)
        .fontSize(14)
        .fontColor('#4CAF50') // Success color
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#2D241E')
    .borderRadius(20)
  }
}

// Helper components for Grid layout since ArkTS doesn't have built-in GridRow/GridCol in all versions
// Using Flex for simplicity and compatibility
@Component
struct CustomGridRow {
  @BuilderParam content: () => void

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween }) {
      this.content()
    }.width('100%').margin({ bottom: 16 })
  }
}

@Component
struct CustomGridCol {
  @BuilderParam content: () => void

  build() {
    Column() {
      this.content()
    }.layoutWeight(1).margin({ right: 8 })
  }
}