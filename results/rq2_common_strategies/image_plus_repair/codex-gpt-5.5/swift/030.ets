interface ClipboardItem {
  content: string
  type: string
  timestamp: string
  progress: number
}

class AppTokens {
  static readonly primary: string = '#007BFF'
  static readonly secondary: string = '#6C757D'
  static readonly tertiary: string = '#17A2B8'
  static readonly background: string = '#F8F9FA'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E9ECEF'
  static readonly text: string = '#212529'
}

@Entry
@Component
struct ClipboardHistoryApp {
  @State private sliderValue: number = 24
  @State private items: ClipboardItem[] = [
    {
      content: 'https://www.example.com/modern-design',
      type: 'Link',
      timestamp: '5 min ago',
      progress: 0.2
    },
    {
      content: 'Final project review notes have been updated.',
      type: 'Text',
      timestamp: '23 min ago',
      progress: 0.5
    },
    {
      content: '#007BFF',
      type: 'Color',
      timestamp: '1 hour ago',
      progress: 0.8
    },
    {
      content: 'Meeting at 3 PM with the design team.',
      type: 'Text',
      timestamp: '3 hours ago',
      progress: 0.9
    },
    {
      content: "Shared file: 'Q3_Report.pdf'",
      type: 'File',
      timestamp: 'Yesterday',
      progress: 1.0
    }
  ]

  @Builder
  private progressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppTokens.surfaceVariant)

      Row()
        .width(`${Math.max(0, Math.min(progress, 1)) * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppTokens.tertiary)
    }
    .width('100%')
    .height(8)
  }

  @Builder
  private clipboardCard(item: ClipboardItem) {
    Column() {
      Row() {
        Row()
          .width(48)
          .height(48)
          .borderRadius(8)
          .backgroundColor(AppTokens.primary)

        Text(item.type)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.primary)
          .margin({ left: 16 })

        Blank()
          .layoutWeight(1)

        Text(item.timestamp)
          .fontSize(27)
          .fontColor(AppTokens.secondary)
      }
      .width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)

      Text(item.content)
        .fontSize(31)
        .fontColor(AppTokens.text)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .lineHeight(40)
        .margin({ top: 16, bottom: 22 })

      this.progressBar(item.progress)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .backgroundColor(AppTokens.surface)
    .borderRadius(24)
    .border({
      width: 1,
      color: AppTokens.surfaceVariant
    })
    .shadow({
      radius: 10,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  private settingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.text)

        Blank()
          .layoutWeight(1)

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.text)
      }
      .width('100%')
      .height(40)
      .margin({ bottom: 12 })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(32)
        .blockColor(AppTokens.surface)
        .trackColor(AppTokens.surfaceVariant)
        .selectedColor(AppTokens.primary)
        .onChange((value: number) => {
          this.sliderValue = value
        })
    }
    .width('100%')
    .height(180)
    .padding({ left: 32, right: 32, top: 32, bottom: 24 })
    .backgroundColor(AppTokens.surface)
    .shadow({
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -4
    })
    .position({ bottom: 0 })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Clipboard History')
          .fontSize(44)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.text)

        Button('Clear', { type: ButtonType.Normal })
          .fontSize(28)
          .fontColor(AppTokens.text)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(18)
          .height(66)
          .padding({ left: 24, right: 24 })
          .position({ right: 24 })
          .onClick(() => {
            this.items = []
          })
      }
      .width('100%')
      .height(112)
      .backgroundColor(AppTokens.surface)

      Stack() {
        Scroll() {
          Column({ space: 24 }) {
            ForEach(this.items, (item: ClipboardItem) => {
              this.clipboardCard(item)
            }, (item: ClipboardItem) => item.content)
          }
          .width('100%')
          .padding({ left: 32, right: 32, top: 24, bottom: 24 })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')

        this.settingsPane()
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}
