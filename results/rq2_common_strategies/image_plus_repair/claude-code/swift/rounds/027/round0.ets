@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = "pen"

  build() {
    Column() {
      // Top Bar
      Row() {
        // Left navigation icon
        Circle({ width: 24, height: 24 })
          .fill('#F0F0F5')

        Spacer()

        Text("Document.pdf")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1B1B1F')

        Spacer()

        // Share button
        Text("Share")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#001D3D')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .background('#A0C4FF')
          .borderRadius(4)
      }
      .padding(12)
      .background('#FFFFFF')
      .height(56)

      // Main content row
      Row() {
        // Left: page grid
        Grid() {
          ForEach(Array.from({ length: 12 }, (_, i) => i + 1), (page: number) => {
            GridItem() {
              Column() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? '#001D3D' : '#1B1B1F')
              }
              .width('100%')
              .aspectRatio(0.7)
              .justifyContent(FlexAlign.Center)
              .background(this.selectedPage === page ? '#A0C4FF' : '#F0F0F5')
              .borderRadius(8)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: '#A0C4FF'
              })
              .onClick(() => {
                this.selectedPage = page
              })
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(8)
        .columnsGap(8)
        .padding(8)
        .width(150)
        .layoutWeight(0)

        // Right: document view with annotation tools
        Stack({ alignContent: Alignment.CenterStart }) {
          // Main document card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#1B1B1F')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .background('#FFFFFF')
          .borderRadius(12)
          .shadow({
            radius: 2,
            color: 'rgba(0, 0, 0, 0.08)',
            offsetY: 1
          })

          // Annotation tools column
          Column() {
            this.AnnotationToolButton("P", "pen")
            this.AnnotationToolButton("H", "highlighter")
            this.AnnotationToolButton("T", "text")
            this.AnnotationToolButton("S", "shape")
          }
          .padding(8)
          .margin(12)
          .background('rgba(255, 255, 255, 0.8)')
          .borderRadius(12)
          .border({
            width: 1,
            color: '#D9D9E3'
          })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .padding({ left: 12, right: 12 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .background('#F8F7FF')
  }

  @Builder
  AnnotationToolButton(icon: string, toolName: string) {
    Column() {
      Text(icon)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedTool === toolName ? '#003720' : '#1B1B1F')
    }
    .width(40)
    .height(40)
    .justifyContent(FlexAlign.Center)
    .background(this.selectedTool === toolName ? '#B7E4C7' : '#F0F0F5')
    .borderRadius(20)
    .margin({ bottom: 8 })
    .onClick(() => {
      this.selectedTool = toolName
    })
  }
}
