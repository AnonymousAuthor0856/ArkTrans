class DietColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#6366F1';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E293B';
  static readonly onSurface: string = '#1E293B';
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  @Builder
  Tabs() {
    Row() {
      ForEach(this.tabs, (title: string, index: number) => {
        Button(title)
          .height(48)
          .fontSize(14)
          .fontColor(this.selectedTab === index ? DietColors.primary : DietColors.onSurface)
          .backgroundColor(DietColors.surface)
          .borderRadius(0)
          .layoutWeight(1)
          .border({ width: { bottom: this.selectedTab === index ? 3 : 1 }, color: this.selectedTab === index ? DietColors.primary : DietColors.outline })
          .onClick(() => {
            this.selectedTab = index;
          })
      }, (title: string) => title)
    }
    .width('100%')
  }

  @Builder
  MealsPage() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(DietColors.onSurface)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach([0, 1, 2], (index: number) => {
        Text('Meal ' + (index + 1).toString())
          .width('100%')
          .height(80)
          .fontSize(16)
          .fontColor(DietColors.onSurface)
          .textAlign(TextAlign.Center)
          .backgroundColor(DietColors.surface)
          .borderRadius(12)
          .border({ width: 1, color: DietColors.outline })
          .margin({ bottom: 12 })
      }, (index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }

  @Builder
  ChatPage() {
    Column() {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(DietColors.onSurface)
        .width('100%')
        .margin({ bottom: 8 })

      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          Text('Message ' + (index + 1).toString())
            .fontSize(14)
            .fontColor(index % 2 === 0 ? DietColors.onSurface : DietColors.onPrimary)
            .padding(12)
            .backgroundColor(index % 2 === 0 ? DietColors.surfaceVariant : DietColors.primary)
            .borderRadius(12)
        }
        .width('100%')
        .justifyContent(index % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
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
        .height(24)
        .backgroundColor(DietColors.surfaceVariant)
        .borderRadius(8)
      Text('')
        .width(Math.min(100, 30 + index * 10).toString() + '%')
        .height(24)
        .backgroundColor(DietColors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .height(24)
  }

  @Builder
  StatsPage() {
    Column() {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(DietColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Column() {
          this.StatBar(index)
        }
        .margin({ bottom: 12 })
      }, (index: number) => index.toString())

      Button('Share Report')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DietColors.onSecondary)
        .backgroundColor(DietColors.secondary)
        .borderRadius(16)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }

  build() {
    Column() {
      Text('Diet Log')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(DietColors.onBackground)
        .width('100%')
        .padding(16)
        .textAlign(TextAlign.Center)

      this.Tabs()

      if (this.selectedTab === 0) {
        this.MealsPage()
      } else if (this.selectedTab === 1) {
        this.ChatPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
    .backgroundColor(DietColors.background)
  }
}
