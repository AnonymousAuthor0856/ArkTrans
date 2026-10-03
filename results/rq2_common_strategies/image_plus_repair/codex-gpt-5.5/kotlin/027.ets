interface AppColors {
  primary: string
  secondary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  onPrimary: string
  onSecondary: string
  onSurface: string
}

const COLORS: AppColors = {
  primary: '#A0C4FF',
  secondary: '#B7E4C7',
  background: '#F8F7FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F0F0F5',
  outline: '#D9D9E3',
  onPrimary: '#001D3D',
  onSecondary: '#003720',
  onSurface: '#1B1B1F'
}

@Entry
@Component
struct MainPage {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    Column() {
      Row() {
        Row()
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(COLORS.surfaceVariant)

        Text('Document.pdf')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Share')
          .width(164)
          .height(80)
          .borderRadius(40)
          .backgroundColor(COLORS.primary)
          .fontSize(25)
          .fontColor(COLORS.onPrimary)
          .fontWeight(FontWeight.Medium)
          .margin({ right: 24 })
      }
      .width('100%')
      .height(128)
      .padding({ left: 32 })
      .alignItems(VerticalAlign.Center)

      Row() {
        Scroll() {
          Grid() {
            ForEach(this.pageNumbers(), (page: number) => {
              GridItem() {
                Text(page.toString())
                  .fontSize(23)
                  .fontColor(page === this.selectedPage ? COLORS.onPrimary : COLORS.onSurface)
                  .fontWeight(FontWeight.Medium)
              }
              .width(126)
              .height(180)
              .borderRadius(15)
              .backgroundColor(page === this.selectedPage ? COLORS.primary : COLORS.surfaceVariant)
              .border({
                width: page === this.selectedPage ? 2 : 0,
                color: COLORS.primary,
                style: BorderStyle.Solid
              })
              .onClick(() => {
                this.selectedPage = page
              })
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(16)
          .columnsGap(16)
          .padding(8)
        }
        .width(300)
        .height('100%')
        .scrollBar(BarState.Off)

        Stack() {
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(46)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLORS.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(COLORS.surface)
          .borderRadius(24)
          .shadow({
            radius: 4,
            color: '#22000000',
            offsetX: 0,
            offsetY: 2
          })

          Column() {
            this.annotationTool('P', 'pen')
            this.annotationTool('H', 'highlighter')
            this.annotationTool('T', 'text')
            this.annotationTool('S', 'shape')
          }
          .width(112)
          .height(400)
          .padding(8)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor('#CCFFFFFF')
          .border({
            width: 2,
            color: COLORS.outline,
            style: BorderStyle.Solid
          })
          .borderRadius(24)
          .position({ x: 24, y: 'center' })
        }
        .layoutWeight(1)
        .height('100%')
        .margin({ left: 16, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 32, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  annotationTool(icon: string, toolName: string) {
    Button(icon)
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(toolName === this.selectedTool ? COLORS.secondary : COLORS.surfaceVariant)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(toolName === this.selectedTool ? COLORS.onSecondary : COLORS.onSurface)
      .onClick(() => {
        this.selectedTool = toolName
      })
  }

  pageNumbers(): Array<number> {
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  }
}
