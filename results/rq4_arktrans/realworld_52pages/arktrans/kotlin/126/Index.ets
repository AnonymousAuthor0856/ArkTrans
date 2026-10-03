@Entry
@Component
struct Index {
  @State showBack: boolean = true

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header
        Row() {
          if (this.showBack) {
            Row() {
              Text('←')
                .fontSize(20)
                .fontColor('#1F1B24')
                .margin({ right: 8 })
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor('#E6E0F3')
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .onClick(() => {
              this.showBack = !this.showBack
            })
          } else {
            Blank().width(40).height(40)
          }

          Text('Backup')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1F1B24')
            .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 24, top: 50, bottom: 40 })

        // Export Section
        Column() {
          Row() {
            Text('📤')
              .fontSize(24)
              .margin({ right: 16 })

            Column() {
              Text('Export')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F1B24')
              
              Text('Save all your data as a JSON file')
                .fontSize(16)
                .fontColor('#49454F')
                .margin({ top: 4 })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          Button() {
            Row() {
              Text('▶')
                .fontSize(16)
                .margin({ right: 8 })
              Text('Export')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('80%')
          .height(56)
          .backgroundColor('#6750A4')
          .borderRadius(28)
          .margin({ top: 24 })
          .fontColor('#FFFFFF')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })

        // Restore Section
        Column() {
          Row() {
            Text('⬇')
              .fontSize(24)
              .margin({ right: 16 })

            Column() {
              Text('Restore')
                .fontSize(22)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F1B24')
              
              Text('Restore data from a backup file')
                .fontSize(16)
                .fontColor('#49454F')
                .margin({ top: 4 })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          Button() {
            Row() {
              Text('▶')
                .fontSize(16)
                .margin({ right: 8 })
              Text('Restore')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('80%')
          .height(56)
          .backgroundColor('#6750A4')
          .borderRadius(28)
          .margin({ top: 24 })
          .fontColor('#FFFFFF')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 40 })
        
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FCF2FF')
    }
    .width('100%')
    .height('100%')
  }
}