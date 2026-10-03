@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Column() {
      // Header
      Text('Diet Log')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 40, bottom: 20 })
        .backgroundColor('#DBEAFE')

      // Tabs
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(18)
              .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.currentIndex === index ? '#0EA5E9' : '#1E293B')
              .margin({ left: 20, right: 20 })
          }
          .layoutWeight(1)
          .onClick(() => {
            this.currentIndex = index
          })
        }, (item: string) => item)
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Bottom)
      .borderWidth({ bottom: this.currentIndex !== -1 ? 3 : 0 })
      .borderColor({ bottom: '#0EA5E9' })
      .borderRadius({ bottomLeft: 0, bottomRight: 0 })
      .backgroundColor('#FFFFFF')

      // Content Area
      if (this.currentIndex === 0) {
        this.MealsPage()
      } else if (this.currentIndex === 1) {
        this.ChatPage()
      } else {
        this.StatsPage()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#DBEAFE')
  }

  @Builder
  MealsPage() {
    Column({ space: 16 }) {
      Text("Today's Meals")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .alignSelf(ItemAlign.Start)
        .margin({ left: 20, top: 20 })

      Column({ space: 16 }) {
        ForEach([1, 2, 3], (num: number) => {
          Text(`Meal ${num}`)
            .fontSize(24)
            .fontColor('#1E293B')
            .textAlign(TextAlign.Center)
            .width('90%')
            .height(100)
            .backgroundColor('#FFFFFF')
            .borderRadius(20)
            .border({ width: 1, color: '#CBD5E1' })
        }, (item: number) => item.toString())
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  ChatPage() {
    Column({ space: 12 }) {
      Text("Diet Chat")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .alignSelf(ItemAlign.Start)
        .margin({ left: 20, top: 20 })

      Column({ space: 12 }) {
        ForEach([1, 2, 3, 4], (num: number) => {
          Text(`Message ${num}`)
            .fontSize(16)
            .fontColor(num % 2 === 0 ? '#1E293B' : '#FFFFFF')
            .textAlign(TextAlign.Start)
            .width(num % 2 === 0 ? '70%' : '60%')
            .padding(16)
            .backgroundColor(num % 2 === 0 ? '#F1F5F9' : '#0EA5E9')
            .borderRadius(16)
            .alignSelf(num % 2 === 0 ? ItemAlign.Start : ItemAlign.End)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .layoutWeight(1)
  }

  @Builder
  StatsPage() {
    Column({ space: 20 }) {
      Text("Weekly Calories")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .alignSelf(ItemAlign.Start)
        .margin({ left: 20, top: 20 })

      Column({ space: 10 }) {
        ForEach([0.3, 0.5, 0.7, 0.9, 0.4], (val: number) => {
          Row() {
            Text(`${Math.round(val * 100)}%`)
              .fontSize(12)
              .fontColor('#64748B')
              .width(40)
            
            Row() {
              Blank().layoutWeight(1)
              Row() {
                // Background bar
                Row().width('100%').height(24).backgroundColor('#E2E8F0').borderRadius(12)
                // Foreground bar
                Row().width(`${val * 100}%`).height(24).backgroundColor('#0EA5E9').borderRadius(12)
              }
              .width('80%')
              .position({ x: 0, y: 0 })
            }
            .width('80%')
            .position({ x: 0, y: 0 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .padding({ left: 20, right: 20 })

      Button('Share Report')
        .width('60%')
        .height(48)
        .backgroundColor('#0EA5E9')
        .borderRadius(24)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Medium)
        .margin({ top: 20 })
    }
    .width('100%')
    .layoutWeight(1)
  }
}