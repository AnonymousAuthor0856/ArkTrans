interface ClipboardItem {
  id: number
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
  static readonly outline: string = '#DEE2E6'
  static readonly success: string = '#28A745'
  static readonly warning: string = '#FFC107'
  static readonly error: string = '#DC3545'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#212529'
  static readonly onSurface: string = '#212529'

  static readonly fontDisplay: number = 36
  static readonly fontHeadline: number = 28
  static readonly fontTitle: number = 22
  static readonly fontBody: number = 16
  static readonly fontLabel: number = 14

  static readonly radiusSmall: number = 4
  static readonly radiusMedium: number = 8
  static readonly radiusLarge: number = 12

  static readonly spacingXs: number = 4
  static readonly spacingSm: number = 8
  static readonly spacingMd: number = 12
  static readonly spacingLg: number = 16
  static readonly spacingXl: number = 24
}

@Entry
@Component
struct ClipboardHistoryApp {
  @State private sliderValue: number = 24

  private clipboardItems: ClipboardItem[] = [
    {
      id: 1,
      content: 'https://www.example.com/modern-design',
      type: 'Link',
      timestamp: '5 min ago',
      progress: 0.2
    },
    {
      id: 2,
      content: 'Final project review notes have been updated.',
      type: 'Text',
      timestamp: '23 min ago',
      progress: 0.5
    },
    {
      id: 3,
      content: '#007BFF',
      type: 'Color',
      timestamp: '1 hour ago',
      progress: 0.8
    },
    {
      id: 4,
      content: 'Meeting at 3 PM with the design team.',
      type: 'Text',
      timestamp: '3 hours ago',
      progress: 0.9
    },
    {
      id: 5,
      content: 'Shared file: \'Q3_Report.pdf\'',
      type: 'File',
      timestamp: 'Yesterday',
      progress: 1.0
    }
  ]

  build() {
    Column() {
      this.TopAppBar()

      Scroll() {
        Column({ space: AppTokens.spacingMd }) {
          ForEach(
            this.clipboardItems,
            (item: ClipboardItem) => {
              this.ClipboardCard(item)
            },
            (item: ClipboardItem) => item.id.toString()
          )
        }
        .width('100%')
        .padding({
          left: AppTokens.spacingLg,
          right: AppTokens.spacingLg,
          top: AppTokens.spacingMd,
          bottom: AppTokens.spacingMd
        })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.background)
      .scrollBar(BarState.Off)

      this.SettingsPane()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }

  @Builder
  private TopAppBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Clipboard History')
        .fontSize(AppTokens.fontTitle)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onBackground)

      Row() {
        Blank()

        Text('Clear')
          .fontSize(AppTokens.fontLabel)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
          .padding({
            top: AppTokens.spacingSm,
            bottom: AppTokens.spacingSm,
            left: AppTokens.spacingMd,
            right: AppTokens.spacingMd
          })
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(AppTokens.radiusMedium)
          .onClick(() => {
            console.info('Clear button tapped')
          })
      }
      .width('100%')
      .padding({ right: AppTokens.spacingMd })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.surface)
    .shadow({
      radius: 1,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  private ClipboardCard(item: ClipboardItem) {
    Column() {
      Row() {
        Row({ space: AppTokens.spacingSm }) {
          Row()
            .width(24)
            .height(24)
            .backgroundColor(AppTokens.primary)
            .borderRadius(AppTokens.radiusSmall)

          Text(item.type)
            .fontSize(AppTokens.fontLabel)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.primary)
        }

        Blank()

        Text(item.timestamp)
          .fontSize(AppTokens.fontLabel)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.secondary)
      }
      .width('100%')
      .height(24)
      .margin({ bottom: AppTokens.spacingSm })

      Text(item.content)
        .width('100%')
        .fontSize(AppTokens.fontBody)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: AppTokens.spacingMd })

      this.LinearProgressBar(item.progress)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppTokens.spacingMd)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.radiusLarge)
    .border({
      width: 1,
      color: AppTokens.surfaceVariant,
      radius: AppTokens.radiusLarge
    })
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  private LinearProgressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(4)
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(AppTokens.radiusSmall)

      Row()
        .width(`${progress * 100}%`)
        .height(4)
        .backgroundColor(AppTokens.tertiary)
        .borderRadius(AppTokens.radiusSmall)
    }
    .width('100%')
    .height(4)
  }

  @Builder
  private SettingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTokens.fontLabel)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)

        Blank()

        Text(this.sliderValue.toFixed(0))
          .fontSize(AppTokens.fontBody)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.onSurface)
      }
      .width('100%')
      .margin({ bottom: AppTokens.spacingSm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1
      })
        .width('100%')
        .selectedColor(AppTokens.primary)
        .trackColor(AppTokens.surfaceVariant)
        .blockColor(AppTokens.surface)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height(90)
    .padding(AppTokens.spacingLg)
    .backgroundColor(AppTokens.surface)
    .shadow({
      radius: 6,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}