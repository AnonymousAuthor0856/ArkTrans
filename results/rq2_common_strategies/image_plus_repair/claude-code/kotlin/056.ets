@Entry
@Component
struct DietLogApp {
  @State currentIndex: number = 0;
  private tabs: string[] = ["Meals", "Chat", "Stats"];
  private swiperController: SwiperController = new SwiperController();

  build() {
    Column() {
      Column() {
        Text("Diet Log")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor("#1E293B")
      }
      .width("100%")
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          Column() {
            Text(title)
              .fontSize(16)
              .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.currentIndex === index ? "#0EA5E9" : "#1E293B")
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 12, bottom: 12 })
          .onClick(() => {
            this.currentIndex = index;
            this.swiperController.changeIndex(index);
          })
        })
      }
      .width("100%")

      Stack() {
        Row()
          .width("100%")
          .height(3)
          .backgroundColor("#D1D5DB")
          .position({ y: 0 })

        Row()
          .width(`${100 / this.tabs.length}%`)
          .height(3)
          .backgroundColor("#0EA5E9")
          .translate({ x: this.currentIndex * (100 / this.tabs.length) + "%" })
          .position({ y: 0 })
          .animation({ duration: 200, curve: Curve.EaseInOut })
      }
      .width("100%")
      .height(3)

      Swiper(this.swiperController) {
        MealsPage()
        ChatPage()
        StatsPage()
      }
      .index(this.currentIndex)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .layoutWeight(1)
      .width("100%")
    }
    .width("100%")
    .height("100%")
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [["#0EA5E9", 0.1], ["#6366F1", 0.1]]
    })
  }
}

@Component
struct MealsPage {
  build() {
    Column() {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor("#1E293B")
        .margin({ bottom: 12 })

      ForEach([1, 2, 3], (i: number) => {
        Row() {
          Text(`Meal ${i}`)
            .fontSize(14)
            .fontColor("#1E293B")
        }
        .width("100%")
        .height(80)
        .backgroundColor("#FFFFFF")
        .borderRadius(12)
        .border({ width: 1, color: "#D1D5DB" })
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 12 })
      })
    }
    .width("100%")
    .height("100%")
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatPage {
  build() {
    Column() {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor("#1E293B")
        .margin({ bottom: 8 })

      ForEach([1, 2, 3, 4, 5], (i: number) => {
        Row() {
          Text(`Message ${i}`)
            .fontSize(14)
            .fontColor(i % 2 === 1 ? "#1E293B" : "#FFFFFF")
            .padding(12)
            .backgroundColor(i % 2 === 1 ? "#E2E8F0" : "#0EA5E9")
            .borderRadius(12)
        }
        .width("100%")
        .justifyContent(i % 2 === 1 ? FlexAlign.Start : FlexAlign.End)
        .margin({ top: 4, bottom: 4 })
      })
    }
    .width("100%")
    .height("100%")
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StatsPage {
  build() {
    Column() {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor("#1E293B")
        .margin({ bottom: 12 })

      ForEach([0, 1, 2, 3, 4, 5, 6], (i: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width("100%")
            .height(24)
            .backgroundColor("#E2E8F0")
            .borderRadius(8)

          Row()
            .width(`${Math.min(30 + i * 10, 100)}%`)
            .height(24)
            .backgroundColor("#0EA5E9")
            .borderRadius(8)
        }
        .width("100%")
        .height(24)
        .margin({ bottom: 12 })
      })

      Blank()
        .height(16)

      Button("Share Report")
        .width("60%")
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor("#FFFFFF")
        .backgroundColor("#6366F1")
        .borderRadius(16)
    }
    .width("100%")
    .height("100%")
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }
}
