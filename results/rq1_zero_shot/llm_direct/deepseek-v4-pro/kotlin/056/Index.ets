import { display, window } from '@kit.ArkUI';

@Entry
@Component
struct MainPage {
  @State currentPage: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];
  private controller: TabsController = new TabsController();

  @Builder
  MealsPage() {
    Column({ space: 12 }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .width('100%')

      ForEach([1, 2, 3], (item: number) => {
        Row() {
          Text(`Meal ${item}`)
            .fontSize(14)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .border({ width: 1, color: '#D1D5DB' })
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }

  @Builder
  ChatPage() {
    Column({ space: 8 }) {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .width('100%')

      ForEach([1, 2, 3, 4, 5], (item: number) => {
        Row() {
          Text(`Message ${item}`)
            .fontSize(14)
            .fontColor(item % 2 === 0 ? '#FFFFFF' : '#1E293B')
            .padding(12)
            .backgroundColor(item % 2 === 0 ? '#0EA5E9' : '#E2E8F0')
            .borderRadius(12)
        }
        .width('100%')
        .justifyContent(item % 2 === 0 ? FlexAlign.End : FlexAlign.Start)
        .padding({ top: 8, bottom: 8 })
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }

  @Builder
  StatsPage() {
    Column({ space: 12 }) {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#1E293B')
        .width('100%')
        .textAlign(TextAlign.Center)

      ForEach([0, 1, 2, 3, 4, 5, 6], (item: number) => {
        Row() {
          Row()
            .width(`${(30 + item * 10) > 100 ? 100 : (30 + item * 10)}%`)
            .height('100%')
            .backgroundColor('#0EA5E9')
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
        .backgroundColor('#E2E8F0')
        .borderRadius(8)
      })

      Blank().height(16)

      Button('Share Report')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#6366F1')
        .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      // Header
      Row() {
        Text("Diet Log")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)

      // Tabs
      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        TabContent() {
          this.MealsPage()
        }
        .tabBar(this.TabBuilder(0))

        TabContent() {
          this.ChatPage()
        }
        .tabBar(this.TabBuilder(1))

        TabContent() {
          this.StatsPage()
        }
        .tabBar(this.TabBuilder(2))
      }
      .width('100%')
      .layoutWeight(1)
      .barHeight(48)
      .barBackgroundColor('#F1F5F9')
      .onChange((index: number) => {
        this.currentPage = index;
      })
      .scrollable(true)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
    .linearGradient({
      angle: 180,
      colors: [['#0EA5E9', 0.1], ['#6366F1', 0.1]]
    })
  }

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(this.tabs[index])
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentPage === index ? '#0EA5E9' : '#1E293B')
        .padding({ top: 12, bottom: 12 })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}