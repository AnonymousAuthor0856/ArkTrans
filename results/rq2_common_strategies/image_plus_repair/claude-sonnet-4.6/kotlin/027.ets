// Color constants
const colorPrimary: string = '#A0C4FF'
const colorSecondary: string = '#B7E4C7'
const colorBackground: string = '#F8F7FF'
const colorSurface: string = '#FFFFFF'
const colorSurfaceVariant: string = '#F0F0F5'
const colorOutline: string = '#D9D9E3'
const colorOnPrimary: string = '#001D3D'
const colorOnSecondary: string = '#003720'
const colorOnSurface: string = '#1B1B1F'

@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fill(colorSurfaceVariant)
        }
        .width(48)
        .height(48)
        .margin({ left: 8 })

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnPrimary)
          .backgroundColor(colorPrimary)
          .borderRadius(20)
          .height(40)
          .margin({ right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(colorSurface)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Row() {
        // Page Grid
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Stack() {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? colorOnPrimary : colorOnSurface)
              }
              .width('100%')
              .height('100%')
              .backgroundColor(this.selectedPage === page ? colorPrimary : colorSurfaceVariant)
              .borderRadius(8)
              .border(this.selectedPage === page ? { width: 2, color: colorPrimary } : { width: 0, color: 'transparent' })
              .onClick(() => {
                this.selectedPage = page
              })
            }
            .aspectRatio(0.7)
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .padding(8)
        .width(150)
        .height('100%')

        // Spacer
        Blank().width(12)

        // Main Document View
        Stack() {
          // Document Card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(colorOnSurface)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(colorSurface)
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .shadow({ radius: 2, color: '#14000000', offsetX: 0, offsetY: 1 })

          // Annotation Tools
          Column({ space: 8 }) {
            this.AnnotationToolButton('P', 'pen')
            this.AnnotationToolButton('H', 'highlighter')
            this.AnnotationToolButton('T', 'text')
            this.AnnotationToolButton('S', 'shape')
          }
          .padding(8)
          .backgroundColor('#CCffffff')
          .borderRadius(12)
          .border({ width: 1, color: colorOutline })
          .alignSelf(ItemAlign.Start)
          .margin({ left: 12, top: 0 })
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .height('100%')
        .alignContent(Alignment.TopStart)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(12)
      .backgroundColor(colorBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }

  @Builder
  AnnotationToolButton(icon: string, toolName: string) {
    Button(icon)
      .width(40)
      .height(40)
      .borderRadius(20)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === toolName ? colorOnSecondary : colorOnSurface)
      .backgroundColor(this.selectedTool === toolName ? colorSecondary : colorSurfaceVariant)
      .padding(0)
      .onClick(() => {
        this.selectedTool = toolName
      })
  }
}