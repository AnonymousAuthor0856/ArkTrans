const Colors = {
  primary: '#0EA5E9',
  secondary: '#6366F1',
  tertiary: '#06B6D4',
  background: '#F1F5F9',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#D1D5DB',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#0F172A',
  onBackground: '#1E293B',
  onSurface: '#1E293B'
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Column() {
      Row() {
        Text('Diet Log')
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
        this.MealsPage()
        this.ChatPage()
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
      colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
  }

  @Builder
  MealsPage() {
    Column({ space: 12 }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
      ForEach(Array.from({ length: 3 }, (v, i) => i), (i: number) => {
        Stack({ alignContent: Alignment.Center }) {
          Text('Meal ' + (i + 1))
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(Colors.surface)
        .borderRadius(12)
        .border({ width: 1, color: Colors.outline })
      }, (i: number) => i.toString())
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  ChatPage() {
    Column({ space: 8 }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
      ForEach(Array.from({ length: 5 }, (v, i) => i), (i: number) => {
        Row() {
          Text('Message ' + (i + 1))
            .fontSize(14)
            .fontColor(i % 2 === 0 ? Colors.onSurface : Colors.onPrimary)
            .padding(12)
            .backgroundColor(i % 2 === 0 ? Colors.surfaceVariant : Colors.primary)
            .borderRadius(12)
        }
        .width('100%')
        .padding({ top: 8, bottom: 8 })
        .justifyContent(i % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
      }, (i: number) => i.toString())
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column({ space: 12 }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onSurface)
      ForEach(Array.from({ length: 7 }, (v, i) => i), (i: number) => {
        Row() {
          Stack()
            .width(Math.round((0.3 + i * 0.1) * 100) + '%')
            .height('100%')
            .backgroundColor(Colors.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(8)
      }, (i: number) => i.toString())
      Blank().height(16)
      Button('Share Report', { type: ButtonType.Normal })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(Colors.secondary)
        .fontColor(Colors.onSecondary)
        .borderRadius(16)
        .width('60%')
        .height(48)
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
