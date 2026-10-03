@Entry
@Component
struct Index {
  @State selectedPinId: string | null = null

  build() {
    Stack() {
      Column() {
        Column() {
          Text('Approval Flow')
            .fontColor('#000000')
            .fontSize(24)
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            Scroll() {
              Row() {
                ForEach(['Filter 1', 'Filter 2'], (item: string) => {
                  Button() {
                    Text(item)
                      .fontColor(this.selectedPinId === item ? '#FFFFFF' : '#000000')
                      .fontSize(this.selectedPinId === item ? 16 : 14)
                      .padding({ top: 8, bottom: 8, left: 12, right: 12 })
                  }
                  .type(ButtonType.Normal)
                  .backgroundColor(this.selectedPinId === item ? '#6750A4' : '#F5F5F5')
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedPinId = item
                  })
                })
              }
            }
            .width('100%')
            .height(50)
            .padding({ top: 16, left: 24, right: 24 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)

        Column() {
          Row() {
            Button('Approve')
              .type(ButtonType.Capsule)
              .backgroundColor('#6750A4')
              .fontColor('#FFFFFF')
              .enabled(this.selectedPinId !== null)
            
            Blank()
            
            Button('Reject')
              .type(ButtonType.Capsule)
              .backgroundColor('#B39DDB')
              .fontColor('#FFFFFF')
              .enabled(this.selectedPinId !== null)
          }
          .width('100%')
          .padding({ top: 16, bottom: 16, left: 24, right: 24 })
        }
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 8, color: '#1F000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      Column() {
        Blank()
        Row() {
          Blank()
          Button('Submit')
            .type(ButtonType.Capsule)
            .backgroundColor('#6750A4')
            .fontColor('#FFFFFF')
            .padding(24)
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
  }
}