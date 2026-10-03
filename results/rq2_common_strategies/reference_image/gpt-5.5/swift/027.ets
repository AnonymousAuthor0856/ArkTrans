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

class AppShape {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 12
}

class AppElevation {
  static readonly level1Radius: number = 2
  static readonly level1Dy: number = 1
  static readonly level1Color: string = '#14000000'
}

@Component
struct AnnotationToolButton {
  @Link selectedTool: string
  icon: string = ''
  toolName: string = ''

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.icon)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selectedTool === this.toolName ? AppColors.onSecondary : AppColors.onSurface)
    }
    .width(40)
    .height(40)
    .borderRadius(20)
    .backgroundColor(this.selectedTool === this.toolName ? AppColors.secondary : AppColors.surfaceVariant)
    .onClick(() => {
      this.selectedTool = this.toolName
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

  build() {
    Column() {
      Row() {
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Stack()
              .width(24)
              .height(24)
              .borderRadius(12)
              .backgroundColor(AppColors.surfaceVariant)
          }
          .width(40)
          .height(40)
          .onClick(() => {
          })
        }
        .width(92)
        .height('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        Text('Document.pdf')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onBackground)
          .maxLines(1)

        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Text('Share')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .width(68)
          .height(32)
          .borderRadius(AppShape.small)
          .backgroundColor(AppColors.primary)
          .onClick(() => {
          })
        }
        .width(92)
        .height('100%')
        .justifyContent(FlexAlign.End)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
      .backgroundColor(AppColors.surface)

      Row() {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Stack({ alignContent: Alignment.Center }) {
                Text(page.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
              }
              .width('100%')
              .aspectRatio(0.7)
              .borderRadius(AppShape.medium)
              .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: AppColors.primary,
                radius: AppShape.medium
              })
              .onClick(() => {
                this.selectedPage = page
              })
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.sm)
        .rowsGap(AppSpacing.sm)
        .width(150)
        .height('100%')
        .padding(AppSpacing.sm)
        .scrollBar(BarState.Off)
        .margin({ right: AppSpacing.md })

        Stack({ alignContent: Alignment.Center }) {
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(AppShape.large)
          .backgroundColor(AppColors.surface)
          .shadow({
            radius: AppElevation.level1Radius,
            color: AppElevation.level1Color,
            offsetX: 0,
            offsetY: AppElevation.level1Dy
          })

          Row() {
            Column({ space: AppSpacing.sm }) {
              AnnotationToolButton({
                icon: 'P',
                toolName: 'pen',
                selectedTool: $selectedTool
              })

              AnnotationToolButton({
                icon: 'H',
                toolName: 'highlighter',
                selectedTool: $selectedTool
              })

              AnnotationToolButton({
                icon: 'T',
                toolName: 'text',
                selectedTool: $selectedTool
              })

              AnnotationToolButton({
                icon: 'S',
                toolName: 'shape',
                selectedTool: $selectedTool
              })
            }
            .padding(AppSpacing.sm)
            .borderRadius(AppShape.large)
            .backgroundColor('#CCFFFFFF')
            .border({
              width: 1,
              color: AppColors.outline,
              radius: AppShape.large
            })

            Blank()
              .layoutWeight(1)
          }
          .width('100%')
          .height('100%')
          .padding(AppSpacing.md)
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}