@Entry
@Component
struct Index {
  @State selectedIndex: number = -1
  @State reviewed: boolean = false
  @State progress: number = 0.25

  private cPrimary: string = '#7C3AED'
  private cSecondary: string = '#22C55E'
  private cTertiary: string = '#F97316'
  private cPageBg: string = '#FAFAFF'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#F1F5F9'
  private cLine: string = '#E2E8F0'
  private cText: string = '#0B1220'
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']

  private selectedText(): string {
    return this.selectedIndex >= 0 ? this.options[this.selectedIndex] : 'None'
  }

  @Builder
  OptionButton(option: string, index: number) {
    Button(option)
      .width('100%')
      .height(40)
      .padding({ left: 16, right: 16 })
      .fontSize(this.selectedIndex === index ? 14 : 12)
      .fontWeight(this.selectedIndex === index ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedIndex === index ? Color.White : this.cText)
      .backgroundColor(this.selectedIndex === index ? this.cPrimary : this.cSurface)
      .border({ width: 1, color: this.cLine, radius: 8 })
      .margin({ top: 6, bottom: 6 })
      .onClick(() => {
        this.selectedIndex = index
      })
  }

  @Builder
  AssistChip(label: string, active: boolean) {
    Button(label)
      .height(36)
      .padding({ left: 14, right: 14 })
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? '#0F172A' : this.cText)
      .backgroundColor(active ? this.cSecondary : this.cSurface)
      .border({ width: 1, color: this.cLine, radius: 6 })
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width(140)
        .height(6)
        .radius(3)
        .fill(this.cSurfaceVariant)
      Rect()
        .width(35)
        .height(6)
        .radius(3)
        .fill(this.cPrimary)
      Circle()
        .width(6)
        .height(6)
        .fill(this.cPrimary)
        .margin({ left: 32 })
    }
    .width(140)
    .height(6)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Blank()
          Rect()
            .width(20)
            .height(20)
            .radius(6)
            .fill(this.cPrimary)
            .margin({ right: 4 })
          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
          Blank()
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 24, bottom: 16 })

        Scroll() {
          Column() {
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Rect()
                  .width('100%')
                  .height(120)
                  .radius(8)
                  .fill(this.cSurfaceVariant)
                Text('Question 1/4')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.cText)
              }
              .width('100%')

              Text('Which planet is known as the Red Planet?')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.cText)
                .width('100%')
                .margin({ top: 8, bottom: 8 })

              Column() {
                ForEach(this.options, (option: string, index: number) => {
                  this.OptionButton(option, index)
                }, (option: string) => option)
              }
              .width('100%')
            }
            .width('100%')
            .padding(8)
            .backgroundColor(this.cSurface)
            .border({ width: 1, color: this.cLine, radius: 12 })
            .shadow({ radius: 3, color: '#14000000', offsetY: 1 })

            Row() {
              Column() {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.cText)
                  .width('100%')
                Text(this.selectedText())
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.cText)
                  .width('100%')
                  .margin({ top: 2 })
              }
              .layoutWeight(1)

              this.AssistChip('Skip', false)
            }
            .width('100%')
            .margin({ top: 8 })

            Blank().height(120)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cPageBg)

      Row() {
        Column() {
          Text('Progress')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
            .width('100%')
          Column() {
            this.ProgressBar()
          }
          .margin({ top: 4 })
        }
        .width(150)

        Blank()

        Button('Review')
          .height(36)
          .padding({ left: 14, right: 14 })
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.reviewed ? '#0F172A' : this.cText)
          .backgroundColor(this.reviewed ? this.cSecondary : this.cSurface)
          .border({ width: 1, color: this.cLine, radius: 6 })
          .margin({ right: 8 })
          .onClick(() => {
            this.reviewed = !this.reviewed
          })

        Button('Next')
          .width(140)
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .backgroundColor(this.cPrimary)
          .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('#A6FAFAFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cPageBg)
  }
}
