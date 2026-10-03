@Entry
@Component
struct RootScreen {
  @State pointsX: number[] = []
  @State pointsY: number[] = []
  @State currentColor: string = '#FFEF476F'
  private buttonHeight: number = 44
  private fabSize: number = 56

  build() {
    Stack() {
      // Background
      Column() {}.width('100%').height('100%').backgroundColor('#FFFCF2')

      // Drawing area placeholder (cannot use Canvas due to component restrictions)
      Column() {
        Text('Draw here')
          .fontSize(14)
          .foregroundColor('#1E1E1E')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding({ top: 54, bottom: 80 })

      // Top bar
      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#1E1E1E')
          .padding({ top: 12, bottom: 12 })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFFCF2')
      }
      .width('100%')
      .position({ x: 0, y: 0 })

      // Bottom color selection bar
      Column() {
        Row({ space: 12 }) {
          Button() {
            Text('Red')
              .fontSize(14)
              .foregroundColor('#FFFFFF')
          }
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor('#FFEF476F')
            .borderRadius(6)
            .onClick(() => {
              this.currentColor = '#FFEF476F'
            })

          Button() {
            Text('Yellow')
              .fontSize(14)
              .foregroundColor('#1E1E1E')
          }
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor('#FFFFD166')
            .borderRadius(6)
            .onClick(() => {
              this.currentColor = '#FFFFD166'
            })

          Button() {
            Text('Green')
              .fontSize(14)
              .foregroundColor('#1E1E1E')
          }
            .height(this.buttonHeight)
            .layoutWeight(1)
            .backgroundColor('#FF06D6A0')
            .borderRadius(6)
            .onClick(() => {
              this.currentColor = '#FF06D6A0'
            })
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 2, color: '#1F000000', offsetY: 2 })
      }
      .width('100%')
      .position({ x: 0, y: 'calc(100% - 68px)' })

      // Floating Action Button (Clear)
      Row() {
        Blank()
        Button() {
          Text('Clear')
            .fontSize(12)
            .foregroundColor('#1E1E1E')
        }
          .width(this.fabSize)
          .height(this.fabSize)
          .borderRadius(this.fabSize / 2)
          .backgroundColor('#FFFFD166')
          .shadow({ radius: 2, color: '#1F000000', offsetY: 2 })
          .onClick(() => {
            this.pointsX = []
            this.pointsY = []
          })
          .margin({ right: 24, bottom: 24 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .position({ x: 0, y: 'calc(100% - 80px)' })
    }
    .width('100%')
    .height('100%')
  }
}