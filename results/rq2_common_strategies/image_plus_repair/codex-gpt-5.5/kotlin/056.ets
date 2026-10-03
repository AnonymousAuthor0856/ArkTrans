@Entry
@Component
struct DietLogPage {
  @State private selectedIndex: number = 0;

  private readonly tabs: string[] = ['Meals', 'Chat', 'Stats'];
  private readonly primary: string = '#0EA5E9';
  private readonly secondary: string = '#6366F1';
  private readonly backgroundTop: string = '#E0F2FE';
  private readonly backgroundBottom: string = '#E8EDFF';
  private readonly surface: string = '#FFFFFF';
  private readonly surfaceVariant: string = '#E2E8F0';
  private readonly borderLineColor: string = '#D1D5DB';
  private readonly textColor: string = '#1E293B';

  @Builder
  TabItem(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(28)
        .fontWeight(this.selectedIndex === index ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.selectedIndex === index ? this.primary : this.textColor)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .width('33.3333%')
    .height(96)
    .backgroundColor(this.surface)
    .border({
      width: { bottom: this.selectedIndex === index ? 6 : 1 },
      color: { bottom: this.selectedIndex === index ? this.primary : this.borderLineColor }
    })
    .onClick(() => {
      this.selectedIndex = index;
    })
  }

  @Builder
  MealsPage() {
    Column() {
      Text("Today's Meals")
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .width('100%')
        .margin({ bottom: 25 })

      ForEach([1, 2, 3], (item: number) => {
        Row() {
          Text(`Meal ${item}`)
            .fontSize(32)
            .fontColor(this.textColor)
        }
        .width('100%')
        .height(158)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(this.surface)
        .borderRadius(22)
        .border({ width: 2, color: this.borderLineColor })
        .margin({ bottom: 26 })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 32 })
  }

  @Builder
  ChatPage() {
    Column() {
      Text('Diet Chat')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach([1, 2, 3, 4, 5], (item: number) => {
        Row() {
          Text(`Message ${item}`)
            .fontSize(28)
            .fontColor(item % 2 === 1 ? this.textColor : '#FFFFFF')
            .padding({ left: 24, right: 24, top: 18, bottom: 18 })
            .backgroundColor(item % 2 === 1 ? this.surfaceVariant : this.primary)
            .borderRadius(18)
        }
        .width('100%')
        .justifyContent(item % 2 === 1 ? FlexAlign.Start : FlexAlign.End)
        .margin({ top: 8, bottom: 8 })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 32 })
  }

  @Builder
  StatsPage() {
    Column() {
      Text('Weekly Calories')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ bottom: 20 })

      ForEach([0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], (value: number, index?: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(24)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(8)

          Row()
            .width(`${value * 100}%`)
            .height(24)
            .backgroundColor(this.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
        .margin({ bottom: 24 })
      }, (value: number) => value.toString())

      Blank()
        .height(16)

      Button('Share Report')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor(this.secondary)
        .borderRadius(24)
        .width('60%')
        .height(48)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 32 })
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Text('Diet Log')
          .fontSize(54)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(130)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(this.backgroundTop)

      Row() {
        ForEach(this.tabs, (title: string, index?: number) => {
          this.TabItem(title, index as number)
        }, (title: string) => title)
      }
      .width('100%')
      .height(96)
      .backgroundColor(this.surface)

      Stack() {
        if (this.selectedIndex === 0) {
          this.MealsPage()
        } else if (this.selectedIndex === 1) {
          this.ChatPage()
        } else {
          this.StatsPage()
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[this.backgroundTop, 0.0], [this.backgroundBottom, 1.0]]
    })
  }
}
