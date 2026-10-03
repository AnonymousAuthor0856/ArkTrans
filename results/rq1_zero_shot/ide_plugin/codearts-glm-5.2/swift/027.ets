class AppTokens {
  static readonly Colors = {
    primary: '#FFA0C4FF',
    secondary: '#FFB7E4C7',
    tertiary: '#FFFFDDC1',
    background: '#FFF8F7FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF0F0F5',
    outline: '#FFD9D9E3',
    success: '#FFB4E4C7',
    warning: '#FFFFDDC1',
    error: '#FFFFB4AB',
    onPrimary: '#FF001D3D',
    onSecondary: '#FF003720',
    onTertiary: '#FF3E2800',
    onBackground: '#FF1B1B1F',
    onSurface: '#FF1B1B1F',
    surface80: '#CCFFFFFF'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  }
}

@Component
struct AnnotationToolButton {
  @Prop icon: string
  @Prop isSelected: boolean

  build() {
    Text(this.icon)
      .fontSize(17)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .textAlign(TextAlign.Center)
  }
}

@Entry
@Component
struct GlassDocReader {
  @State selectedPage: number = 1
  @State selectedTool: string = 'pen'

  build() {
    Column() {
      Row() {
        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Blank()

        Text('Document.pdf')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        Text('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(4)
          .backgroundColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor(AppTokens.Colors.surface)

      Row() {
        Scroll() {
          Column() {
            ForEach([0, 2, 4, 6, 8, 10], (startIndex: number) => {
              Row() {
                Column() {
                  Text(`${startIndex + 1}`)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedPage === startIndex + 1 ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                }
                .layoutWeight(1)
                .aspectRatio(0.7)
                .borderRadius(8)
                .backgroundColor(this.selectedPage === startIndex + 1 ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .onClick(() => {
                  this.selectedPage = startIndex + 1
                })

                Column() {
                  Text(`${startIndex + 2}`)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selectedPage === startIndex + 2 ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                }
                .layoutWeight(1)
                .aspectRatio(0.7)
                .borderRadius(8)
                .backgroundColor(this.selectedPage === startIndex + 2 ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .margin({ left: 8 })
                .onClick(() => {
                  this.selectedPage = startIndex + 2
                })
              }
              .width('100%')
              .margin({ bottom: 8 })
            })
          }
          .padding(8)
        }
        .width(150)
        .layoutWeight(0)
        .scrollBar(BarState.Off)

        Stack() {
          Column() {
            Text(`Page ${this.selectedPage}`)
              .fontSize(24)
              .fontWeight(FontWeight.Semibold)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height('100%')
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 4, color: '#14000000', offsetX: 0, offsetY: 1 })
          .justifyContent(FlexAlign.Center)

          Column() {
            AnnotationToolButton({ icon: 'P', isSelected: this.selectedTool === 'pen' })
              .onClick(() => { this.selectedTool = 'pen' })
            AnnotationToolButton({ icon: 'H', isSelected: this.selectedTool === 'highlighter' })
              .onClick(() => { this.selectedTool = 'highlighter' })
              .margin({ top: 8 })
            AnnotationToolButton({ icon: 'T', isSelected: this.selectedTool === 'text' })
              .onClick(() => { this.selectedTool = 'text' })
              .margin({ top: 8 })
            AnnotationToolButton({ icon: 'S', isSelected: this.selectedTool === 'shape' })
              .onClick(() => { this.selectedTool = 'shape' })
              .margin({ top: 8 })
          }
          .padding(8)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.surface80)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .position({ x: 12, y: 12 })
        }
        .layoutWeight(1)
        .height('100%')
        .margin({ left: 12 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}