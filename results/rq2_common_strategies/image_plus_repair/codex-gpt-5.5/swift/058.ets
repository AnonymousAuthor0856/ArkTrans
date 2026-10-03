class Colors {
  static readonly primary: string = '#111827'
  static readonly onSurface: string = '#1F2937'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
}

class Spacing {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
  static readonly extraLarge: number = 24
}

@Entry
@Component
struct StepChallengeApp {
  @State selectedTabIndex: number = 0

  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding(Spacing.large)

      Column() {
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Button(tab, { type: ButtonType.Normal, stateEffect: true })
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTabIndex === index ? Colors.primary : Colors.onSurface)
              .backgroundColor(Colors.surface)
              .borderRadius(0)
              .layoutWeight(1)
              .height(60)
              .onClick(() => {
                this.selectedTabIndex = index
              })
          }, (tab: string) => tab)
        }
        .width('100%')
        .height(60)

        Row() {
          ForEach(this.tabs, (_tab: string, index: number) => {
            Blank()
              .layoutWeight(1)
              .height(index === this.selectedTabIndex ? 2 : 0)
              .backgroundColor(Colors.primary)
          }, (_tab: string, index: number) => index.toString())
        }
        .width('100%')
        .height(2)
      }
      .width('100%')
      .backgroundColor(Colors.surface)

      if (this.selectedTabIndex === 0) {
        this.overviewPage()
      } else if (this.selectedTabIndex === 1) {
        this.rankingPage()
      } else {
        this.statsPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.surface)
  }

  @Builder
  overviewPage() {
    Column({ space: Spacing.medium }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)

      Blank()
        .height(36)

      Button('Sync Device', { type: ButtonType.Normal, stateEffect: true })
        .fontSize(16)
        .fontColor('#FFFFFF')
        .backgroundColor(Colors.primary)
        .borderRadius(16)
        .width('60%')
        .height(48)
        .onClick(() => {
          // Device synchronization can be connected here.
        })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(Spacing.large)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  rankingPage() {
    Column({ space: Spacing.small }) {
      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text(`User ${index + 1}`)
            .fontSize(14)
            .fontColor(Colors.onSurface)

          Blank()
            .layoutWeight(1)

          Text(`${9000 - index * 500} steps`)
            .fontSize(14)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .height(48)
        .padding(Spacing.medium)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(12)
      }, (index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(Spacing.large)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  statsPage() {
    Column({ space: Spacing.small }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Stack() {
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(8)

          Row()
            .width(`${Math.min(100, 30 + index * 10)}%`)
            .height(20)
            .backgroundColor(Colors.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(20)
      }, (index: number) => index.toString())

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(Spacing.large)
    .alignItems(HorizontalAlign.Start)
  }
}
