const ColorPrimary: string = '#A0C4FF'
const ColorSecondary: string = '#B7E4C7'
const ColorTertiary: string = '#FFDDC1'
const ColorBackground: string = '#F8F7FF'
const ColorSurface: string = '#FFFFFF'
const ColorSurfaceVariant: string = '#F0F0F5'
const ColorOutline: string = '#D9D9E3'
const ColorSuccess: string = '#B4E4C7'
const ColorWarning: string = '#FFDDC1'
const ColorError: string = '#FFB4AB'
const ColorOnPrimary: string = '#001D3D'
const ColorOnSecondary: string = '#003720'
const ColorOnTertiary: string = '#3E2800'
const ColorOnBackground: string = '#1B1B1F'
const ColorOnSurface: string = '#1B1B1F'

const SpacingXs: number = 4
const SpacingSm: number = 8
const SpacingMd: number = 12
const SpacingLg: number = 16
const SpacingXl: number = 24

@Component
struct AnnotationToolButton {
  icon: string = ''
  toolName: string = ''
  @Link selectedTool: string
  onToolClick: () => void = () => {}

  build() {
    Button() {
      Text(this.icon)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? ColorOnSecondary : ColorOnSurface)
    }
    .width(40)
    .height(40)
    .backgroundColor(this.toolName === this.selectedTool ? ColorSecondary : ColorSurfaceVariant)
    .borderRadius(20)
    .onClick(() => {
      this.onToolClick()
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Circle()
            .width(24)
            .height(24)
            .fill(ColorSurfaceVariant)
        }
        .backgroundColor(Color.Transparent)
        .width(24)
        .height(24)

        Blank()

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorOnBackground)

        Blank()

        Button() {
          Text('Share')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorOnPrimary)
            .padding({
              top: SpacingXs,
              bottom: SpacingXs,
              left: SpacingSm,
              right: SpacingSm
            })
        }
        .backgroundColor(ColorPrimary)
        .borderRadius(4)
      }
      .width('100%')
      .height(56)
      .padding(SpacingMd)
      .backgroundColor(ColorSurface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Row({ space: SpacingMd }) {
        // Left side: Page grid
        Scroll() {
          Grid() {
            ForEach(
              [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
              (page: number) => {
                GridItem() {
                  Button() {
                    Stack() {
                      Column()
                        .width('100%')
                        .aspectRatio(0.7)
                        .backgroundColor(this.selectedPage === page ? ColorPrimary : ColorSurfaceVariant)
                        .borderRadius(8)
                        .border(this.selectedPage === page ?
                          { width: 2, color: ColorPrimary, radius: 8 } :
                          { width: 0, color: ColorSurfaceVariant, radius: 8 })

                      Text(page.toString())
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.selectedPage === page ? ColorOnPrimary : ColorOnSurface)
                    }
                    .width('100%')
                    .aspectRatio(0.7)
                  }
                  .backgroundColor(Color.Transparent)
                  .width('100%')
                  .aspectRatio(0.7)
                  .onClick(() => {
                    this.selectedPage = page
                  })
                }
              },
              (page: number) => page.toString()
            )
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(SpacingSm)
          .rowsGap(SpacingSm)
          .width('100%')
          .padding(SpacingSm)
        }
        .width(150)
        .height('100%')
        .scrollBar(BarState.Off)

        // Right side: Document view
        Stack({ alignContent: Alignment.Center }) {
          // Main document card
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(ColorOnSurface)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(ColorSurface)
          .borderRadius(12)
          .shadow({ radius: 2, color: '#14000000', offsetX: 0, offsetY: 1 })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          // Annotation tools
          Column({ space: SpacingSm }) {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'pen'
              }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'highlighter'
              }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'text'
              }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: $selectedTool,
              onToolClick: () => {
                this.selectedTool = 'shape'
              }
            })
          }
          .padding(SpacingSm)
          .backgroundColor('#CCffffff')
          .borderRadius(12)
          .border({ width: 1, color: ColorOutline, radius: 12 })
          .alignSelf(ItemAlign.Start)
          .margin({ left: SpacingMd, top: SpacingMd, bottom: SpacingMd })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: SpacingMd, right: SpacingMd })
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorBackground)
  }
}