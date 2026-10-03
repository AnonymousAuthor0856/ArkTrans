const COLOR_PRIMARY: string = '#0EA5E9'
const COLOR_SECONDARY: string = '#6366F1'
const COLOR_BACKGROUND: string = '#F1F5F9'
const COLOR_SURFACE: string = '#FFFFFF'
const COLOR_SURFACE_VARIANT: string = '#E2E8F0'
const COLOR_OUTLINE: string = '#D1D5DB'
const COLOR_ON_PRIMARY: string = '#FFFFFF'
const COLOR_ON_SECONDARY: string = '#FFFFFF'
const COLOR_ON_BACKGROUND: string = '#1E293B'
const COLOR_ON_SURFACE: string = '#1E293B'
const COLOR_PRIMARY_10: string = '#1A0EA5E9'
const COLOR_SECONDARY_10: string = '#1A6366F1'
const COLOR_TRANSPARENT: string = '#00000000'

const SPACE_SM: number = 8
const SPACE_MD: number = 12
const SPACE_LG: number = 16

@Entry
@Component
struct Index {
  @State private currentPage: number = 0

  private readonly tabs: string[] = ['Meals', 'Chat', 'Stats']
  private readonly meals: number[] = [1, 2, 3]
  private readonly messages: number[] = [1, 2, 3, 4, 5]
  private readonly calorieBars: number[] = [0, 1, 2, 3, 4, 5, 6]
  private swiperController: SwiperController = new SwiperController()

  private calorieWidth(index: number): string {
    const value: number = Math.min(100, 30 + index * 10)
    return `${value}%`
  }

  @Builder
  private Header() {
    Column() {
      Text('Diet Log')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_BACKGROUND)
    }
    .width('100%')
    .height(65)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private TabItem(title: string, index: number) {
    Column() {
      Column() {
        Text(title)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.currentPage === index ? COLOR_PRIMARY : COLOR_ON_SURFACE)
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank()
        .width('100%')
        .height(3)
        .backgroundColor(this.currentPage === index ? COLOR_PRIMARY : COLOR_TRANSPARENT)
    }
    .width('33.3333%')
    .height('100%')
    .onClick(() => {
      this.currentPage = index
      this.swiperController.changeIndex(index, true)
    })
  }

  @Builder
  private TabBar() {
    Row() {
      ForEach(this.tabs, (title: string, index: number) => {
        this.TabItem(title, index)
      }, (title: string) => title)
    }
    .width('100%')
    .height(48)
    .backgroundColor(COLOR_SURFACE)
  }

  @Builder
  private MealCard(index: number) {
    Stack({ alignContent: Alignment.Center }) {
      Text(`Meal ${index}`)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(COLOR_ON_SURFACE)
    }
    .width('100%')
    .height(80)
    .backgroundColor(COLOR_SURFACE)
    .border({
      width: 1,
      color: COLOR_OUTLINE
    })
    .borderRadius(12)
  }

  @Builder
  private MealsPage() {
    Column({ space: SPACE_MD }) {
      Text('Today\'s Meals')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)

      ForEach(this.meals, (item: number) => {
        this.MealCard(item)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding({
      left: SPACE_LG,
      right: SPACE_LG,
      top: SPACE_LG,
      bottom: SPACE_LG
    })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private ChatBubble(index: number) {
    Row() {
      Text(`Message ${index + 1}`)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(index % 2 === 0 ? COLOR_ON_SURFACE : COLOR_ON_PRIMARY)
        .padding(SPACE_MD)
        .backgroundColor(index % 2 === 0 ? COLOR_SURFACE_VARIANT : COLOR_PRIMARY)
        .borderRadius(12)
    }
    .width('100%')
    .padding({
      top: SPACE_SM,
      bottom: SPACE_SM
    })
    .justifyContent(index % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
  }

  @Builder
  private ChatPage() {
    Column({ space: SPACE_SM }) {
      Text('Diet Chat')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)

      ForEach(this.messages, (item: number, index: number) => {
        this.ChatBubble(index)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding({
      left: SPACE_LG,
      right: SPACE_LG,
      top: SPACE_LG,
      bottom: SPACE_LG
    })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private CalorieBar(index: number) {
    Stack({ alignContent: Alignment.Start }) {
      Blank()
        .width('100%')
        .height(24)
        .backgroundColor(COLOR_SURFACE_VARIANT)
        .borderRadius(8)

      Blank()
        .width(this.calorieWidth(index))
        .height(24)
        .backgroundColor(COLOR_PRIMARY)
        .borderRadius(8)
    }
    .width('100%')
    .height(24)
    .clip(true)
  }

  @Builder
  private StatsPage() {
    Column({ space: SPACE_MD }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_ON_SURFACE)

      ForEach(this.calorieBars, (item: number, index: number) => {
        this.CalorieBar(index)
      }, (item: number) => item.toString())

      Blank()
        .width('100%')
        .height(SPACE_LG)

      Button('Share Report', {
        type: ButtonType.Normal,
        stateEffect: true
      })
        .width('60%')
        .height(48)
        .borderRadius(16)
        .backgroundColor(COLOR_SECONDARY)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SECONDARY)
    }
    .width('100%')
    .height('100%')
    .padding({
      left: SPACE_LG,
      right: SPACE_LG,
      top: SPACE_LG,
      bottom: SPACE_LG
    })
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      this.Header()
      this.TabBar()

      Swiper(this.swiperController) {
        this.MealsPage()
        this.ChatPage()
        this.StatsPage()
      }
      .width('100%')
      .layoutWeight(1)
      .index(this.currentPage)
      .indicator(false)
      .loop(false)
      .onChange((index: number) => {
        this.currentPage = index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .linearGradient({
      angle: 180,
      colors: [
        [COLOR_PRIMARY_10, 0.0],
        [COLOR_SECONDARY_10, 1.0]
      ]
    })
  }
}