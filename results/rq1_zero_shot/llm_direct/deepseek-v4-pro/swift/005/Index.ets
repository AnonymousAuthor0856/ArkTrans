@Entry
@Component
struct QuizApp {
  @State selected: number = -1
  @State reviewed: boolean = false
  @State progress: number = 0.25
  private options: string[] = ["Earth", "Mars", "Venus", "Jupiter"]

  // Design Tokens
  private colors = {
    primary: '#7C3AED',
    secondary: '#22C55E',
    tertiary: '#F97316',
    background: '#FAFAFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#111827',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  }

  @Builder
  AssistChip(label: string, isOn: boolean, onTap: () => void) {
    Button() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(isOn ? this.colors.onSecondary : this.colors.onSurface)
        .padding({ top: 10, bottom: 10, left: 14, right: 14 })
        .backgroundColor(isOn ? this.colors.secondary : this.colors.surface)
        .borderRadius(6)
        .border({ width: 1, color: this.colors.outline })
    }
    .onClick(() => {
      onTap()
    })
    .backgroundColor(Color.Transparent)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width(140)
            .height(6)
            .borderRadius(3)
            .backgroundColor(this.colors.surfaceVariant)

          Row()
            .width(140 * Math.max(0, Math.min(1, this.progress)))
            .height(6)
            .borderRadius(3)
            .backgroundColor(this.colors.primary)

          Circle()
            .width(6)
            .height(6)
            .fill(this.colors.primary)
            .offset({ x: 140 * Math.max(0, Math.min(1, this.progress)) - 3, y: 0 })
        }
        .width(140)
        .height(6)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      this.AssistChip('Review', this.reviewed, () => {
        this.reviewed = !this.reviewed
      })

      Button() {
        Text('Next')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onPrimary)
          .width(140)
          .height(44)
          .textAlign(TextAlign.Center)
      }
      .width(140)
      .height(44)
      .backgroundColor(this.colors.primary)
      .borderRadius(12)
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor('#FAFAFFA6')
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top App Bar
        Row({ space: 4 }) {
          Row()
            .width(20)
            .height(20)
            .borderRadius(6)
            .backgroundColor(this.colors.primary)

          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 24, bottom: 16, left: 8, right: 8 })

        // Scrollable content
        Scroll() {
          Column({ space: 8 }) {
            // Card
            Column({ space: 8 }) {
              Row()
                .width('100%')
                .height(120)
                .borderRadius(8)
                .backgroundColor(this.colors.surfaceVariant)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

              Text('Question 1/4')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)
                .position({ x: '50%', y: 60 })
                .markAnchor({ x: '50%', y: '50%' })

              Text('Which planet is known as the Red Planet?')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(this.colors.onSurface)

              Column({ space: 4 }) {
                ForEach(this.options, (option: string, index: number) => {
                  Button() {
                    Text(option)
                      .fontSize(this.selected === index ? 14 : 12)
                      .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
                      .fontColor(this.selected === index ? this.colors.onPrimary : this.colors.onSurface)
                      .width('100%')
                      .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                      .textAlign(TextAlign.Start)
                  }
                  .width('100%')
                  .backgroundColor(this.selected === index ? this.colors.primary : this.colors.surface)
                  .borderRadius(8)
                  .border({ width: 1, color: this.colors.outline })
                  .onClick(() => {
                    this.selected = index
                  })
                  .margin({ top: 6, bottom: 6 })
                }, (option: string, index: number) => option + index.toString())
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(8)
            .backgroundColor(this.colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: this.colors.outline })
            .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
            .padding({ left: 8, right: 8 })

            // Selected + Skip
            Row() {
              Column({ space: 2 }) {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.colors.onSurface)
                Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              this.AssistChip('Skip', false, () => {})
            }
            .width('100%')
            .padding({ left: 8, right: 8 })
          }
          .width('100%')
          .padding({ top: 6, bottom: 120 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.colors.background)

      // Bottom Bar overlay
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}