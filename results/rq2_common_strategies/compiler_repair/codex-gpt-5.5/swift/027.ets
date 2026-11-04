class PageItem {
  page: number

  constructor(page: number) {
    this.page = page
  }
}

class ToolItem {
  icon: string
  name: string

  constructor(icon: string, name: string) {
    this.icon = icon
    this.name = name
  }
}

@Entry
@Component
struct Index {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  private cPrimary: string = '#A0C4FF'
  private cSecondary: string = '#B7E4C7'
  private cTertiary: string = '#FFDDC1'
  private cBackground: string = '#F8F7FF'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#F0F0F5'
  private cOutline: string = '#D9D9E3'
  private cText: string = '#1B1B1F'
  private pages: PageItem[] = [
    new PageItem(1), new PageItem(2), new PageItem(3), new PageItem(4),
    new PageItem(5), new PageItem(6), new PageItem(7), new PageItem(8),
    new PageItem(9), new PageItem(10), new PageItem(11), new PageItem(12)
  ]
  private tools: ToolItem[] = [
    new ToolItem('P', 'pen'),
    new ToolItem('H', 'highlighter'),
    new ToolItem('T', 'text'),
    new ToolItem('S', 'shape')
  ]

  @Builder
  ToolButton(tool: ToolItem) {
    Button(tool.icon)
      .width(40)
      .height(40)
      .fontSize(17)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === tool.name ? '#003720' : this.cText)
      .backgroundColor(this.selectedTool === tool.name ? this.cSecondary : this.cSurfaceVariant)
      .borderRadius(20)
      .margin({ bottom: 8 })
      .onClick(() => {
        this.selectedTool = tool.name
      })
  }

  @Builder
  PageThumb(item: PageItem) {
    Button(item.page.toString())
      .width('100%')
      .aspectRatio(0.7)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedPage === item.page ? '#001D3D' : this.cText)
      .backgroundColor(this.selectedPage === item.page ? this.cPrimary : this.cSurfaceVariant)
      .border({ width: this.selectedPage === item.page ? 2 : 0, color: this.cPrimary, radius: 8 })
      .onClick(() => {
        this.selectedPage = item.page
      })
  }

  build() {
    Column() {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(this.cSurfaceVariant)
        Blank()
        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
        Blank()
        Button('Share')
          .height(30)
          .padding({ left: 8, right: 8 })
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#001D3D')
          .backgroundColor(this.cPrimary)
          .borderRadius(4)
      }
      .height(56)
      .width('100%')
      .padding(12)
      .backgroundColor(this.cSurface)

      Row() {
        Scroll() {
          Grid() {
            ForEach(this.pages, (item: PageItem) => {
              GridItem() {
                this.PageThumb(item)
              }
            }, (item: PageItem) => item.page.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .padding(8)
        }
        .width(150)
        .height('100%')

        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width('100%')
            .height('100%')
            .radius(12)
            .fill(this.cSurface)
          Text('Page ' + this.selectedPage.toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
          Row() {
            Column() {
              ForEach(this.tools, (tool: ToolItem) => {
                this.ToolButton(tool)
              }, (tool: ToolItem) => tool.name)
            }
            .padding(8)
            .backgroundColor('#CCFFFFFF')
            .border({ width: 1, color: this.cOutline, radius: 12 })
            Blank()
          }
          .width('100%')
          .height('100%')
          .padding(12)
        }
        .layoutWeight(1)
        .height('100%')
        .shadow({ radius: 2, color: '#14000000', offsetY: 1 })
        .margin({ left: 12 })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
