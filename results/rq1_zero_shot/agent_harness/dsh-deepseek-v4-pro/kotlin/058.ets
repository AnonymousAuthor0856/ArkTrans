const Colors = {
  primary: '#111827',
  secondary: '#374151',
  tertiary: '#6B7280',
  background: '#F9FAFB',
  surface: '#FFFFFF',
  surfaceVariant: '#E5E7EB',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#111827',
  onBackground: '#111827',
  onSurface: '#1F2937'
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      Row() {
        Text('Step Challenge')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)

      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Text(title)
            .fontSize(16)
            .fontWeight(this.currentPage === index ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(this.currentPage === index ? Colors.primary : Colors.onSurface)
            .padding({ left: 14, right: 14, top: 10, bottom: 10 })
            .onClick(() => {
              this.currentPage = index
            })
        }, (title: string) => title)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      Swiper(this.currentPage) {
        this.OverviewPage()
        this.RankingPage()
        this.StatsPage()
      }
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentPage = index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#E5E7EB', 0.0], ['#FFFFFF', 1.0]]
    })
  }

  @Builder
  OverviewPage() {
    Column({ space: 12 }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
      Blank().height(16)
      Button('Sync Device', { type: ButtonType.Normal })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(Colors.primary)
        .fontColor(Colors.onPrimary)
        .borderRadius(16)
        .width('60%')
        .height(48)
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  RankingPage() {
    Column({ space: 8 }) {
      ForEach(Array.from({ length: 5 }, (v, i) => i), (i: number) => {
        Row() {
          Text('User ' + (i + 1)).fontColor(Colors.onSurface)
          Text((9000 - i * 500) + ' steps').fontColor(Colors.onSurface)
        }
        .width('100%')
        .padding(12)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(12)
      }, (i: number) => i.toString())
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column({ space: 8 }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
      ForEach(Array.from({ length: 7 }, (v, i) => i), (i: number) => {
        Row() {
          Stack()
            .width(Math.round(Math.min(0.3 + i * 0.1, 1) * 100) + '%')
            .height('100%')
            .backgroundColor(Colors.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(20)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(8)
      }, (i: number) => i.toString())
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
