const NAME: string = '028_PDFAnnotator_en'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Soft Pastel'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const PRIMARY: string = '#A0C4FF'
const SECONDARY: string = '#B7E4C7'
const TERTIARY: string = '#FFDDC1'
const BACKGROUND: string = '#F8F7FF'
const SURFACE: string = '#FFFFFF'
const SURFACE_80: string = '#CCFFFFFF'
const SURFACE_VARIANT: string = '#F0F0F5'
const OUTLINE: string = '#D9D9E3'
const SUCCESS: string = '#B4E4C7'
const WARNING: string = '#FFDDC1'
const ERROR: string = '#FFB4AB'
const ON_PRIMARY: string = '#001D3D'
const ON_SECONDARY: string = '#003720'
const ON_TERTIARY: string = '#3E2800'
const ON_BACKGROUND: string = '#1B1B1F'
const ON_SURFACE: string = '#1B1B1F'

@Entry
@Component
struct Index {
  @State private selectedPage: number = 1
  @State private selectedTool: string = 'pen'

  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  @Builder
  private TopBar() {
    Stack() {
      Text('')
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(SURFACE_VARIANT)
        .align(Alignment.Start)
        .margin({ left: 32 })

      Text('Document.pdf')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_BACKGROUND)
        .textAlign(TextAlign.Center)
        .align(Alignment.Center)

      Text('Share')
        .width(164)
        .height(80)
        .borderRadius(40)
        .backgroundColor(PRIMARY)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_PRIMARY)
        .textAlign(TextAlign.Center)
        .align(Alignment.End)
        .margin({ right: 24 })
        .onClick(() => {
        })
    }
    .width('100%')
    .height(128)
    .backgroundColor(BACKGROUND)
  }

  @Builder
  private AnnotationToolButton(icon: string, toolName: string) {
    Text(icon)
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor(this.selectedTool === toolName ? SECONDARY : SURFACE_VARIANT)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === toolName ? ON_SECONDARY : ON_SURFACE)
      .textAlign(TextAlign.Center)
      .onClick(() => {
        this.selectedTool = toolName
      })
  }

  build() {
    Column() {
      this.TopBar()

      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Text(page.toString())
                .width('100%')
                .height('100%')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedPage === page ? ON_PRIMARY : ON_SURFACE)
                .textAlign(TextAlign.Center)
            }
            .height(180)
            .borderRadius(12)
            .backgroundColor(this.selectedPage === page ? PRIMARY : SURFACE_VARIANT)
            .border({
              width: this.selectedPage === page ? 2 : 0,
              color: PRIMARY
            })
            .onClick(() => {
              this.selectedPage = page
            })
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .padding(16)
        .width(300)
        .height('100%')
        .scrollBar(BarState.Off)

        Blank()
          .width(24)

        Stack() {
          Stack() {
            Text('Page ' + this.selectedPage.toString())
              .fontSize(46)
              .fontWeight(FontWeight.Bold)
              .fontColor(ON_SURFACE)
              .textAlign(TextAlign.Center)
              .align(Alignment.Center)
          }
          .width('100%')
          .height('100%')
          .borderRadius(24)
          .backgroundColor(SURFACE)
          .border({
            width: 1,
            color: '#E5E5EC'
          })
          .shadow({
            radius: 4,
            color: '#22000000',
            offsetX: 0,
            offsetY: 2
          })

          Column({ space: 16 }) {
            this.AnnotationToolButton('P', 'pen')
            this.AnnotationToolButton('H', 'highlighter')
            this.AnnotationToolButton('T', 'text')
            this.AnnotationToolButton('S', 'shape')
          }
          .padding(16)
          .borderRadius(20)
          .backgroundColor(SURFACE_80)
          .border({
            width: 2,
            color: OUTLINE
          })
          .align(Alignment.Start)
          .margin({ left: 24 })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: 24,
        right: 24,
        top: 24,
        bottom: 24
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}