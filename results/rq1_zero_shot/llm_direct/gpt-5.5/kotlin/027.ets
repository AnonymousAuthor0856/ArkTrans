const NAME: string = '028_PDFAnnotator_en'
const UI_TYPE: string = 'Productivity'
const STYLE_THEME: string = 'Soft Pastel'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#A0C4FF'
  static readonly secondary: string = '#B7E4C7'
  static readonly tertiary: string = '#FFDDC1'
  static readonly background: string = '#F8F7FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F0F0F5'
  static readonly outline: string = '#D9D9E3'
  static readonly success: string = '#B4E4C7'
  static readonly warning: string = '#FFDDC1'
  static readonly error: string = '#FFB4AB'
  static readonly onPrimary: string = '#001D3D'
  static readonly onSecondary: string = '#003720'
  static readonly onTertiary: string = '#3E2800'
  static readonly onBackground: string = '#1B1B1F'
  static readonly onSurface: string = '#1B1B1F'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class AppRadius {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 12
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 1, 0.08)
  static readonly level2: ShadowSpec = new ShadowSpec(3, 4, 2, 0.10)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 8, 4, 0.12)
}

@Component
struct AnnotationToolButton {
  icon: string = ''
  toolName: string = ''
  selectedTool: string = ''
  onClick: () => void = () => {
  }

  build() {
    Button() {
      Text(this.icon)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? AppColors.onSecondary : AppColors.onSurface)
    }
    .width(40)
    .height(40)
    .padding(0)
    .borderRadius(20)
    .backgroundColor(this.toolName === this.selectedTool ? AppColors.secondary : AppColors.surfaceVariant)
    .onClick(() => {
      this.onClick()
    })
  }
}

@Entry
@Component
struct RootScreen {
  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  @Builder
  TopAppBar() {
    Row() {
      Button() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .padding(0)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
      })

      Blank()
        .layoutWeight(1)

      Text('Document.pdf')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Blank()
        .layoutWeight(1)

      Button() {
        Text('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(AppColors.onPrimary)
      }
      .height(40)
      .padding({ left: 16, right: 16, top: 0, bottom: 0 })
      .borderRadius(20)
      .backgroundColor(AppColors.primary)
      .onClick(() => {
      })

      Blank()
        .width(AppSpacing.sm)
    }
    .width('100%')
    .height(64)
    .padding({ left: 4, right: 4 })
    .backgroundColor(AppColors.background)
  }

  @Builder
  PageThumbnail(page: number) {
    Stack({ alignContent: Alignment.Center }) {
      Text(page.toString())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.5)
        .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
    }
    .width('100%')
    .aspectRatio(0.7)
    .borderRadius(AppRadius.medium)
    .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
    .border({
      width: this.selectedPage === page ? 2 : 0,
      color: AppColors.primary,
      radius: AppRadius.medium
    })
    .onClick(() => {
      this.selectedPage = page
    })
  }

  build() {
    Column() {
      this.TopAppBar()

      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              this.PageThumbnail(page)
            }
          }, (page: number) => page.toString())
        }
        .width(150)
        .height('100%')
        .padding(AppSpacing.sm)
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.sm)
        .rowsGap(AppSpacing.sm)

        Blank()
          .width(AppSpacing.md)

        Stack({ alignContent: Alignment.CenterStart }) {
          Stack({ alignContent: Alignment.Center }) {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .height('100%')
          .borderRadius(AppRadius.large)
          .backgroundColor(AppColors.surface)
          .shadow({
            radius: AppElevation.level1.radius,
            color: 'rgba(0, 0, 0, 0.08)',
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })

          Column({ space: AppSpacing.sm }) {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'pen'
              }
            })

            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'highlighter'
              }
            })

            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'text'
              }
            })

            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: this.selectedTool,
              onClick: () => {
                this.selectedTool = 'shape'
              }
            })
          }
          .padding(AppSpacing.sm)
          .margin({ left: AppSpacing.md })
          .borderRadius(AppRadius.large)
          .backgroundColor('rgba(255, 255, 255, 0.80)')
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppRadius.large
          })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.md)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}