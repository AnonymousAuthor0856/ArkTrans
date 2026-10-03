@Entry
@Component
struct Index {
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header
        Stack() {
          Text('Asset Inventory')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1C1B1F')
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ top: 40, bottom: 20 })
        }
        .height(86)
        .backgroundColor('#FFFFFF')

        // Scrollable Content
        Scroll() {
          Column() {
            // Category Chips
            Row() {
              Button('Warehouse')
                .type(ButtonType.Normal)
                .backgroundColor('#1C1B1F')
                .fontColor('#FFFFFF')
                .borderRadius(12)
                .margin({ right: 12 })
              
              Button('Device')
                .type(ButtonType.Normal)
                .backgroundColor('#1C1B1F')
                .fontColor('#FFFFFF')
                .borderRadius(12)
                .margin({ right: 12 })

              Button('Office')
                .type(ButtonType.Normal)
                .backgroundColor('#1C1B1F')
                .fontColor('#FFFFFF')
                .borderRadius(12)
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 16 })

            // Main Form & Map Area
            Row() {
              // Left Column (Inputs)
              Column() {
                TextInput({ placeholder: 'Asset Name' })
                  .backgroundColor('#E5E5E5')
                  .borderRadius(12)
                  .height(48)
                  .margin({ bottom: 12 })
                  .padding({ left: 16 })
                  .placeholderColor('#9E9E9E')
                  .textAlign(TextAlign.Start)

                TextInput({ placeholder: 'Asset Code' })
                  .backgroundColor('#E5E5E5')
                  .borderRadius(12)
                  .height(48)
                  .margin({ bottom: 12 })
                  .padding({ left: 16 })
                  .placeholderColor('#9E9E9E')
                  .textAlign(TextAlign.Start)

                TextInput({ text: this.assetType })
                  .backgroundColor('#E5E5E5')
                  .borderRadius(12)
                  .height(48)
                  .margin({ bottom: 16 })
                  .padding({ left: 16 })
                  .textAlign(TextAlign.Start)

                // Selected Info Card
                Column() {
                  Text('Selected')
                    .fontSize(14)
                    .fontColor('#757575')
                    .margin({ bottom: 4 })
                  
                  Text(this.selectedId === null ? 'None' : 'Item Selected')
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1C1B1F')
                }
                .width('100%')
                .padding(20)
                .backgroundColor('#FFFFFF')
                .borderRadius(20)
                .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
              }
              .layoutWeight(1)
              .margin({ right: 16 })

              // Right Column (Map Placeholder)
              Column() {
                // Simulated Map Grid Background
                GridRow() {
                  GridCol().width('25%').height(1).backgroundColor('#E0E0E0')
                  GridCol().width('25%').height(1).backgroundColor('#E0E0E0')
                  GridCol().width('25%').height(1).backgroundColor('#E0E0E0')
                  GridCol().width('25%').height(1).backgroundColor('#E0E0E0')
                }.width('100%')
                
                // Vertical Lines simulation
                Column() {
                  Divider().vertical(true).color('#E0E0E0').layoutWeight(1)
                  Divider().vertical(true).color('#E0E0E0').layoutWeight(1)
                  Divider().vertical(true).color('#E0E0E0').layoutWeight(1)
                  Divider().vertical(true).color('#E0E0E0').layoutWeight(1)
                }.width('100%').height('100%')
              }
              .width('45%')
              .height(350)
              .backgroundColor('#FAFAFA')
              .borderRadius(24)
              .border({ width: 1, color: '#E0E0E0' })
              .position({ x: 10, y: -10 }) // Slight offset for visual style
            }
            .width('100%')
            .padding({ left: 24, right: 24, bottom: 24 })
            .alignItems(VerticalAlign.Top)

          }
        }
        .layoutWeight(1)
        .backgroundColor('#F5F5F5')

        // Bottom Action Bar
        Column() {
          Row() {
            Button('Reset')
              .type(ButtonType.Normal)
              .backgroundColor('#EEEEEE')
              .fontColor('#1C1B1F')
              .borderRadius(16)
              .height(56)
              .layoutWeight(1)
              .margin({ right: 16 })

            Button('Save Asset')
              .type(ButtonType.Normal)
              .backgroundColor('#1C1B1F')
              .fontColor('#FFFFFF')
              .borderRadius(16)
              .height(56)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 16, bottom: 32 })
          
          Rect()
            .width('100%')
            .height(1)
            .backgroundColor('#E0E0E0')
        }
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}