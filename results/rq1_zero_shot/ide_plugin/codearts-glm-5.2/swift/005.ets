class QuizTokens {
  static readonly Colors = {
    primary: '#FF7C3AED',
    secondary: '#FF22C55E',
    tertiary: '#FFF97316',
    background: '#FFFAFAFF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1F5F9',
    outline: '#FFE2E8F0',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FF111827',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220'
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }
}

@Entry
@Component
struct QuizRootView {
  @State selected: number = -1
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']

  build() {
    Column() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(6)
          .backgroundColor(QuizTokens.Colors.primary)
        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizTokens.Colors.onSurface)
          .margin({ left: 4 })
      }
      .width('100%')
      .padding({ top: 24, bottom: 16, left: 8, right: 8 })

      Scroll() {
        Column() {
          Column() {
            Row() {
              Text('Question 1/4')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .width('100%')
            .height(120)
            .borderRadius(8)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            Text('Which planet is known as the Red Planet?')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(QuizTokens.Colors.onSurface)
              .margin({ top: 8 })

            ForEach(this.options, (option: string, index: number) => {
              Text(option)
                .fontSize(this.selected === index ? 14 : 12)
                .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.selected === index ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
                .width('100%')
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                .borderRadius(8)
                .backgroundColor(this.selected === index ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
                .border({ width: 1, color: QuizTokens.Colors.outline })
                .margin({ top: 6 })
                .onClick(() => {
                  this.selected = index
                })
            })
          }
          .width('100%')
          .padding(8)
          .borderRadius(12)
          .backgroundColor(QuizTokens.Colors.surface)
          .border({ width: 1, color: QuizTokens.Colors.outline })
          .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
          .alignItems(HorizontalAlign.Start)

          Row() {
            Column() {
              Text('Selected')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
              Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text('Skip')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(QuizTokens.Colors.onSurface)
              .padding({ left: 14, right: 14, top: 10, bottom: 10 })
              .borderRadius(6)
              .backgroundColor(QuizTokens.Colors.surface)
              .border({ width: 1, color: QuizTokens.Colors.outline })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 120 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizTokens.Colors.background)
  }
}

@Component
struct BottomBar {
  @State reviewed: boolean = false
  @State progress: number = 0.25

  build() {
    Row() {
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizTokens.Colors.onSurface)
        Stack() {
          Row()
            .width('100%')
            .height(6)
            .borderRadius(3)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)
          Row()
            .width('25%')
            .height(6)
            .borderRadius(3)
            .backgroundColor(QuizTokens.Colors.primary)
        }
        .width(140)
        .height(6)
        .alignContent(Alignment.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('Review')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.reviewed ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
        .padding({ left: 14, right: 14, top: 10, bottom: 10 })
        .borderRadius(6)
        .backgroundColor(this.reviewed ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
        .border({ width: 1, color: QuizTokens.Colors.outline })
        .onClick(() => {
          this.reviewed = !this.reviewed
        })

      Text('Next')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizTokens.Colors.onPrimary)
        .width(140)
        .height(44)
        .textAlign(TextAlign.Center)
        .borderRadius(12)
        .backgroundColor(QuizTokens.Colors.primary)
        .margin({ left: 8 })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .alignItems(VerticalAlign.Center)
  }
}