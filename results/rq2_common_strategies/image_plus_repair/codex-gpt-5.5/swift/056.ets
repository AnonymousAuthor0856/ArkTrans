@Entry
@Component
struct DietLogApp {
  @State private selectedTab: number = 0

  private readonly primary: string = '#0EA5E9'
  private readonly secondary: string = '#6366F1'
  private readonly backgroundColorToken: string = '#F1F5F9'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#E2E8F0'
  private readonly outlineColorToken: string = '#D1D5DB'
  private readonly textColor: string = '#1E293B'

  build() {
    Column() {
      Column() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 35, bottom: 35 })
      }
      .width('100%')
      .backgroundColor('#E6EDF6')

      Column() {
        Row() {
          this.tabButton('Meals', 0)
          this.tabButton('Chat', 1)
          this.tabButton('Stats', 2)
        }
        .width('100%')
        .height(86)

        Row() {
          Blank()
            .width('33.33%')
          if (this.selectedTab === 1) {
            Blank().width('33.33%')
          } else if (this.selectedTab === 2) {
            Blank().width('66.66%')
          }
        }
        .height(3)
        .backgroundColor(this.primary)
        .width('100%')
      }
      .width('100%')
      .backgroundColor(this.surface)

      if (this.selectedTab === 0) {
        this.mealsPage()
      } else if (this.selectedTab === 1) {
        this.chatPage()
      } else {
        this.statsPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColorToken)
  }

  @Builder
  private tabButton(label: string, index: number) {
    Button(label, { type: ButtonType.Normal })
      .fontSize(20)
      .fontColor(this.selectedTab === index ? this.primary : this.textColor)
      .backgroundColor(Color.Transparent)
      .layoutWeight(1)
      .height('100%')
      .onClick(() => {
        this.selectedTab = index
      })
  }

  @Builder
  private mealsPage() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 22 })

      this.mealCard('Meal 1')
      this.mealCard('Meal 2')
      this.mealCard('Meal 3')

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 35, bottom: 20 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private mealCard(label: string) {
    Stack() {
      Text(label)
        .fontSize(16)
        .fontColor(this.textColor)
    }
    .width('100%')
    .height(80)
    .backgroundColor(this.surface)
    .border({
      width: 1,
      color: this.outlineColorToken,
      radius: 16
    })
    .margin({ bottom: 22 })
  }

  @Builder
  private chatPage() {
    Column() {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row() {
          if (item % 2 === 0) {
            Text(`Message ${item + 1}`)
              .fontSize(14)
              .fontColor(this.textColor)
              .padding(12)
              .backgroundColor(this.surfaceVariant)
              .borderRadius(12)
            Blank()
          } else {
            Blank()
            Text(`Message ${item + 1}`)
              .fontSize(14)
              .fontColor(Color.White)
              .padding(12)
              .backgroundColor(this.primary)
              .borderRadius(12)
          }
        }
        .width('100%')
        .margin({ bottom: 8 })
      })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }

  @Builder
  private statsPage() {
    Column() {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (item: number) => {
        Stack() {
          Row()
            .width(`${30 + item * 10}%`)
            .height('100%')
            .backgroundColor(this.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(8)
        .margin({ bottom: 12 })
      })

      Blank()
        .height(16)

      Button('Share Report', { type: ButtonType.Normal })
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor(this.secondary)
        .width('60%')
        .height(48)
        .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
