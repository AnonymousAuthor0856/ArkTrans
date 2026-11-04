class StepColors {
  static readonly primary: string = '#111827';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];

  @Builder
  Tabs() {
    Row() {
      ForEach(this.tabs, (title: string, index: number) => {
        Button(title)
          .height(48)
          .fontSize(14)
          .fontColor(this.selectedTab === index ? StepColors.primary : StepColors.onSurface)
          .backgroundColor(StepColors.surface)
          .borderRadius(0)
          .layoutWeight(1)
          .border({ width: { bottom: this.selectedTab === index ? 3 : 1 }, color: this.selectedTab === index ? StepColors.primary : StepColors.outline })
          .onClick(() => {
            this.selectedTab = index;
          })
      }, (title: string) => title)
    }
    .width('100%')
  }

  @Builder
  OverviewPage() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(StepColors.onSurface)
        .margin({ top: 16, bottom: 24 })

      Button('Sync Device')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(StepColors.onPrimary)
        .backgroundColor(StepColors.primary)
        .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  RankingPage() {
    Column() {
      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text('User ' + (index + 1).toString())
            .fontSize(14)
            .fontColor(StepColors.onSurface)
            .layoutWeight(1)
          Text((9000 - index * 500).toString() + ' steps')
            .fontSize(14)
            .fontColor(StepColors.onSurface)
        }
        .width('100%')
        .padding(12)
        .backgroundColor(StepColors.surfaceVariant)
        .borderRadius(12)
        .margin({ bottom: 8 })
      }, (index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }

  @Builder
  StatBar(index: number) {
    Stack({ alignContent: Alignment.Start }) {
      Text('')
        .width('100%')
        .height(20)
        .backgroundColor(StepColors.surfaceVariant)
        .borderRadius(8)
      Text('')
        .width(Math.min(100, 30 + index * 10).toString() + '%')
        .height(20)
        .backgroundColor(StepColors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .height(20)
  }

  @Builder
  StatsPage() {
    Column() {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(StepColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Column() {
          this.StatBar(index)
        }
        .margin({ bottom: 8 })
      }, (index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(StepColors.onBackground)
        .width('100%')
        .padding(16)
        .textAlign(TextAlign.Center)

      this.Tabs()

      if (this.selectedTab === 0) {
        this.OverviewPage()
      } else if (this.selectedTab === 1) {
        this.RankingPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[StepColors.surfaceVariant, 0.0], [StepColors.surface, 1.0]]
    })
    .backgroundColor(StepColors.background)
  }
}
