@Entry
@Component
struct DietLogPage {
  @State private currentIndex: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      Stack() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
      }
      .width('100%')
      .padding(16)

      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Text(title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(index === this.currentIndex ? '#0EA5E9' : '#1E293B')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .onClick(() => {
              this.currentIndex = index
              this.swiperController.changeIndex(index)
            })
        }, (title: string) => title)
      }
      .width('100%')
      .height(48)

      Swiper(this.swiperController) {
        MealsPage()
        ChatPage()
        StatsPage()
      }
      .index(this.currentIndex)
      .loop(false)
      .indicator(false)
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['rgba(14, 165, 233, 0.1)', 0], ['rgba(99, 102, 241, 0.1)', 1]]
    })
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: 12 }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')

      ForEach([0, 1, 2], (item: number) => {
        Stack() {
          Text('Meal ' + (item + 1))
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB' })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: 8 }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')

      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row() {
          Stack() {
            Text('Message ' + (item + 1))
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(item % 2 === 0 ? '#1E293B' : '#FFFFFF')
          }
          .backgroundColor(item % 2 === 0 ? '#E2E8F0' : '#0EA5E9')
          .borderRadius(12)
          .padding(12)
        }
        .width('100%')
        .padding({ top: 8, bottom: 8 })
        .justifyContent(item % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}

@Component
struct StatsPage {
  build() {
    Column({ space: 12 }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')

      ForEach([0, 1, 2, 3, 4, 5, 6], (item: number) => {
        Row() {
          Row()
            .width(`${Math.round(Math.min(0.3 + item * 0.1, 1.0) * 100)}%`)
            .height('100%')
            .backgroundColor('#0EA5E9')
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
        .backgroundColor('#E2E8F0')
        .borderRadius(8)
      }, (item: number) => item.toString())

      Blank()
        .height(16)

      Button('Share Report')
        .width('60%')
        .height(48)
        .borderRadius(16)
        .backgroundColor('#6366F1')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
