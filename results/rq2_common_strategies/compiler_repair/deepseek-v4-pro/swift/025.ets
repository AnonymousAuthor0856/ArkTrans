@Entry
@Component
struct RootScreen {
  @State nodeIndices: number[] = [0, 1, 2]
  @State currentColor: string = '#FF00FFFF'

  build() {
    Stack() {
      // Background
      Column() {}.width('100%').height('100%').backgroundColor('#FF0D0D0D')

      // Main layout column
      Column({ space: 0 }) {
        // Top bar
        Column() {
          Text('Neon Mind Map')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#FF00FFFF')
            .padding({ top: 16, bottom: 16 })
            .width('100%')
            .textAlign(TextAlign.Center)
            .backgroundColor('#FF0D0D0D')
        }.width('100%')

        // Node display area using Grid
        Grid() {
          ForEach(this.nodeIndices, (index: number) => {
            GridItem() {
              Button() {}
                .width(40)
                .height(40)
                .borderRadius(20)
                .backgroundColor(this.currentColor)
                .margin({ left: 8, right: 8, top: 8, bottom: 8 })
            }
          })
        }.columnsTemplate('1fr 1fr 1fr').columnsGap(12).rowsGap(12)
        .width('100%')
        .layoutWeight(1)
        .padding(16)

        // Bottom bar with color buttons
        Column() {
          Row({ space: 12 }) {
            Button() {
              Text('Cyan')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF000000')
            }
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor('#FF00FFFF')
              .borderRadius(15)
              .onClick(() => {
                this.currentColor = '#FF00FFFF'
              })

            Button() {
              Text('Green')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF000000')
            }
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor('#FF00FF88')
              .borderRadius(15)
              .onClick(() => {
                this.currentColor = '#FF00FF88'
              })

            Button() {
              Text('Purple')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF000000')
            }
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .backgroundColor('#FFBB86FC')
              .borderRadius(15)
              .onClick(() => {
                this.currentColor = '#FFBB86FC'
              })
          }
          .padding(12)
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#FF2E2E2E')
          .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
        }
      }.width('100%').height('100%')

      // Floating Action Button (FAB) to add node
      Row() {
        Blank()
        Button() {
          Text('+')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF000000')
        }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#FF00FF88')
          .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
          .onClick(() => {
            this.nodeIndices.push(this.nodeIndices.length)
          })
          .margin({ right: 16, bottom: 16 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .position({ x: 0, y: 'calc(100% - 72px)' })
    }
    .width('100%')
    .height('100%')
  }
}