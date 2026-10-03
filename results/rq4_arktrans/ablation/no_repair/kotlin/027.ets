@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Top App Bar ===
      Row() {
        // Left Icon (Placeholder)
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24).height(24).objectFit(ImageFit.Contain)
          }
        }.backgroundColor('#F0F0F0').borderRadius(12).width(40).height(40).margin({ right: 8 })

        Blank().layoutWeight(1)

        // Title
        Text('Document.pdf')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')

        Blank().layoutWeight(1)

        // Share Button
        Button() {
          Text('Share')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .backgroundColor('#93B5FF')
        .borderRadius(20)
        .width(100)
        .height(40)
        .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // === Main Content Area ===
      Row() {
        // === Left Sidebar (Grid) ===
        Grid() {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], (page: number) => {
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(16)
                  .fontColor(this.selectedPage === page ? '#FFFFFF' : '#1C1B1F')
              }
              .justifyContent(FlexAlign.Center)
              .width('100%')
              .aspectRatio(0.7)
              .backgroundColor(this.selectedPage === page ? '#93B5FF' : '#F0F0F0')
              .borderRadius(12)
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
        .layoutWeight(0) // Fixed width logic handled by width property
        .margin({ top: 16, bottom: 16, left: 16 })

        // Spacer
        Blank().width(12)

        // === Right Content (Viewer) ===
        Stack({ alignContent: Alignment.Center }) {
          // Background Card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1C1B1F')
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

          // Floating Tool Panel
          Column({ space: 8 }) {
            // Pen
            this.ToolButton('P', 'pen', '#A8E6CF')
            // Highlighter
            this.ToolButton('H', 'highlighter', '#FFF')
            // Text
            this.ToolButton('T', 'text', '#FFF')
            // Shape
            this.ToolButton('S', 'shape', '#FFF')
          }
          .padding(8)
          .backgroundColor('#F0F0F0')
          .borderRadius(20)
          .border({ width: 1, color: '#DADCE0' })
          .position({ x: 16, y: -50 }) // Offset to match screenshot visual
        }
        .layoutWeight(1)
        .margin({ top: 16, bottom: 16, right: 16 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F7FF')
  }

  @Builder
  ToolButton(icon: string, toolName: string, activeColor: string) {
    Button() {
      Text(icon)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedTool === toolName ? '#1C1B1F' : '#5F6368')
    }
    .backgroundColor(this.selectedTool === toolName ? activeColor : '#F0F0F0')
    .borderRadius(20)
    .width(40)
    .height(40)
    .onClick(() => {
      this.selectedTool = toolName
    })
  }
}