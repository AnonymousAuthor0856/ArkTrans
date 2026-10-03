@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    Column() {
      // === Top Bar ===
      Row() {
        // Back Icon Placeholder
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#F0F0F5')
          .margin({ right: 8 })

        Blank()

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1B1B1F')

        Blank()

        Button('Share')
          .backgroundColor('#A0C4FF')
          .fontColor('#001D3D')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(999)
          .padding({ left: 24, right: 24, top: 10, bottom: 10 })
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // === Main Content ===
      Row() {
        // === Left Sidebar (Grid) ===
        Grid() {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (page: number) => {
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? '#001D3D' : '#1B1B1F')
              }
              .justifyContent(FlexAlign.Center)
              .width('100%')
              .aspectRatio(0.7)
              .borderRadius(8)
              .backgroundColor(this.selectedPage === page ? '#A0C4FF' : '#F0F0F5')
              .onClick(() => {
                this.selectedPage = page
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(8)
        .columnsGap(8)
        .width(150)
        .layoutWeight(0) // Fixed width logic handled by width property, but layoutWeight 0 ensures it doesn't shrink/grow unexpectedly in some contexts, though explicit width is primary here.
        .margin({ right: 16 })

        // === Right Content (Viewer + Tools) ===
        Stack() {
          // Viewer Card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1B1B1F')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(12)
          .backgroundColor('#FFF')
          .shadow({ radius: 2, color: '#14000000', offsetY: 1 }) // Approximation of elevation level1

          // Floating Tool Panel
          Column({ space: 8 }) {
            // Pen
            this.ToolButton('P', 'pen')
            // Highlighter
            this.ToolButton('H', 'highlighter')
            // Text
            this.ToolButton('T', 'text')
            // Shape
            this.ToolButton('S', 'shape')
          }
          .width(64)
          .padding(8)
          .borderRadius(12)
          .backgroundColor('#FFF')
          .opacity(0.8)
          .border({ width: 1, color: '#D9D9E3', radius: 12 })
          .position({ x: 16, y: '50%' })
          .translate({ y: -50 })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F7FF')
  }

  @Builder
  ToolButton(icon: string, toolName: string) {
    Button() {
      Text(icon)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedTool === toolName ? '#003720' : '#1B1B1F')
    }
    .width(40)
    .height(40)
    .borderRadius(20)
    .backgroundColor(this.selectedTool === toolName ? '#B7E4C7' : '#F0F0F5')
    .onClick(() => {
      this.selectedTool = toolName
    })
  }
}