class AppTokens {
  static Colors = {
    primary: '#A0C4FF',
    secondary: '#B7E4C7',
    tertiary: '#FFDDC1',
    background: '#F8F7FF',
    surface: '#FFFFFF',
    surfaceVariant: '#F0F0F5',
    outline: '#D9D9E3',
    success: '#B4E4C7',
    warning: '#FFDDC1',
    error: '#FFB4AB',
    onPrimary: '#001D3D',
    onSecondary: '#003720',
    onTertiary: '#3E2800',
    onBackground: '#1B1B1F',
    onSurface: '#1B1B1F'
  }

  static TypographyTokens = {
    display: { size: 45, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.SemiBold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12,
    circle: 999
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static ElevationMapping = {
    level1: { elevation: 1, radius: 2, dy: 1, opacity: 0.08 },
    level2: { elevation: 3, radius: 4, dy: 2, opacity: 0.10 },
    level3: { elevation: 6, radius: 8, dy: 4, opacity: 0.12 }
  }
}

@Component
struct AnnotationToolButton {
  @Prop icon: string
  @Prop toolName: string
  @Prop selectedTool: string
  onClick: () => void = () => {}

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.icon)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .width(40)
    .height(40)
    .backgroundColor(this.toolName === this.selectedTool ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .borderRadius(20)
    .onClick(() => {
      this.onClick()
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
        Stack()
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .onClick(() => {
          })

        Blank()

        Text('Document.pdf')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        Text('Share')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
          .onClick(() => {
          })
      }
      .width('100%')
      .height(56)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)

      Row({ space: AppTokens.Spacing.md }) {
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Stack({ alignContent: Alignment.Center }) {
                Text(page.toString())
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .fontColor(this.selectedPage === page ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
              }
              .width('100%')
              .aspectRatio(0.7)
              .backgroundColor(this.selectedPage === page ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: this.selectedPage === page ? 2 : 0,
                color: AppTokens.Colors.primary,
                radius: AppTokens.Shapes.medium
              })
              .onClick(() => {
                this.selectedPage = page
              })
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.sm)
        .rowsGap(AppTokens.Spacing.sm)
        .width(150)
        .height('100%')
        .padding(AppTokens.Spacing.sm)

        Stack({ alignContent: Alignment.Center }) {
          Stack({ alignContent: Alignment.Center }) {
            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: 'rgba(0, 0, 0, 0.08)',
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })

          Row() {
            Column({ space: AppTokens.Spacing.sm }) {
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
            .padding(AppTokens.Spacing.sm)
            .backgroundColor('rgba(255, 255, 255, 0.8)')
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 1,
              color: AppTokens.Colors.outline,
              radius: AppTokens.Shapes.large
            })

            Blank()
          }
          .width('100%')
          .height('100%')
          .padding(AppTokens.Spacing.md)
        }
        .layoutWeight(1)
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}