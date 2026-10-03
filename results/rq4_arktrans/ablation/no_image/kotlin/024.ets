@Entry
@Component
struct Index {
  @State Clear: string = '0'
  @State Red: string = '0'
  @State Yellow: string = '0'
  @State Green: string = '0'
  @State RetroWhiteboard: string = '0'

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Box ===
        Stack({ alignContent: Alignment.Center }) {
          // === Canvas ===
          Canvas().width('100%').height('100%')
        }.width('100%').height('100%').padding(16).backgroundColor('#FFFCF2')

        // === FloatingActionButton ===
        Button() {
          Text('Clear')
        }
        .type(ButtonType.Circle)
        .backgroundColor('#FFD166')
        .fontColor('#1E1E1E')
        .onClick(() => {
          this.Clear = '0'
        })

        // === Surface ===
        Column() {
          // === Row ===
          Row({ space: 0 }) {
            // === Button (Red) ===
            Button() {
              Text('Red')
            }
            .backgroundColor('#FF5252')
            .fontColor('#FFFFFF')
            .borderRadius(8)
            .onClick(() => {
              this.Red = 'selected'
            })

            // === Button (Yellow) ===
            Button() {
              Text('Yellow')
            }
            .backgroundColor('#FFC107')
            .fontColor('#000000')
            .borderRadius(8)
            .onClick(() => {
              this.Yellow = 'selected'
            })

            // === Button (Green) ===
            Button() {
              Text('Green')
            }
            .backgroundColor('#4CAF50')
            .fontColor('#FFFFFF')
            .borderRadius(8)
            .onClick(() => {
              this.Green = 'selected'
            })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceEvenly)
          .width('100%')
          .padding(12)
        }
        .shadow({ radius: 4, color: '#1A000000' })
        .backgroundColor('#FFFFFF')

        // === CenterAlignedTopAppBar ===
        Row() {
          Text('Retro Whiteboard')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E1E1E')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFCF2')
      }
    }
    .width('100%')
    .height('100%')
  }
}