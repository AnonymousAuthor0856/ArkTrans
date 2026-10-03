@Entry
@Component
struct Index {
  @State DietLog: string = '0'
  @State title: string = '0'
  @State TodaysMeals: string = '0'
  @State it: number = 0
  @State DietChat: string = '0'
  @State WeeklyCalories: string = '0'
  @State ShareReport: string = '0'

  // Define interface for tab items to satisfy ArkTS strict typing rules
  private tabsIndexed: Array<TabItem> = [
    new TabItem('Meals'),
    new TabItem('Chat'),
    new TabItem('Stats')
  ]

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Column ===
        Column({ space: 0 }) {
          // === Box (Header) ===
          Stack({ alignContent: Alignment.Center }) {
            Text('Diet Log').fontColor('#1E293B').fontSize(36).fontWeight(FontWeight.Bold)
          }.width('100%').padding(16)

          // === TabRow ===
          Row() {
            ForEach(this.tabsIndexed, (item: TabItem, index: number) => {
              Button(item.title) {
                Text(item.title)
                  .fontColor(index === 0 ? '#0EA5E9' : '#1E293B')
                  .textAlign(TextAlign.Center)
              }
              .layoutWeight(1)
              .backgroundColor(Color.Transparent)
              .onClick(() => {
                // Simulate tab switch logic if needed, currently static
              })
            })
          }.width('100%')

          // === HorizontalPager Content (Simulated with conditional rendering or just showing first page as per skeleton structure) ===
          // The skeleton implies a pager, but in ArkTS without a specific library, we often use conditional rendering or a Swiper.
          // Given the strict "Implement every child" rule and the structure, I will render the content of the pages sequentially 
          // or use a Swiper if appropriate. However, the skeleton shows them as children of HorizontalPager.
          // To strictly follow the visual hierarchy provided in the skeleton while making it compilable:
          
          // MealsPage
          Column({ space: 12 }) {
            Text("Today's Meals").fontColor('#1E293B').fontSize(24).fontWeight(FontWeight.Medium)
            
            // === Box (Meal Item) ===
            Stack({ alignContent: Alignment.Center }) {
              Text(`Meal ${this.it + 1}`).fontColor('#1E293B')
            }
            .width('100%')
            .height(80)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .border({ width: 1, color: '#CBD5E1', radius: 8 })
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .layoutWeight(1)

          // ChatPage
          Column({ space: 8 }) {
            Text('Diet Chat').fontColor('#1E293B').fontSize(24).fontWeight(FontWeight.Medium)
            
            // === Row (Message Bubble) ===
            Row({ space: 0 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text(`Message ${this.it + 1}`)
                  .fontColor(this.it % 2 === 0 ? '#1E293B' : '#FFFFFF')
              }
              .backgroundColor(this.it % 2 === 0 ? '#F1F5F9' : '#0EA5E9')
              .borderRadius(8)
              .padding(12)
              .layoutWeight(1)
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .layoutWeight(1)

          // StatsPage
          Column({ space: 12 }) {
            Text('Weekly Calories').fontColor('#1E293B').fontSize(24).fontWeight(FontWeight.Medium)
            
            // === Row (Progress Bar Background) ===
            Row({ space: 0 }) {
              // === Box (Progress Fill) ===
              Stack({ alignContent: Alignment.Center }) {
                // Empty fill
              }
              .width(`${Math.min(30 + this.it * 10, 100)}%`)
              .backgroundColor('#0EA5E9')
              .borderRadius(4)
            }
            .width('100%')
            .height(24)
            .backgroundColor('#E2E8F0')
            .borderRadius(4)

            Blank().height(16)

            // === Button ===
            Button() {
              Text('Share Report').fontColor('#FFFFFF').fontSize(16)
            }
            .width('60%')
            .height(48)
            .backgroundColor('#0EA5E9')
            .borderRadius(12)
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .height('100%')
          .padding(16)
          .layoutWeight(1)

        }
        .width('100%')
        .height('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#0EA5E9', 0.1], ['#8B5CF6', 0.1]]
        })
      }
    }.width('100%').height('100%')
  }
}

// Explicit class definition for TabItem to satisfy ArkTS type requirements
class TabItem {
  title: string;

  constructor(title: string) {
    this.title = title;
  }
}