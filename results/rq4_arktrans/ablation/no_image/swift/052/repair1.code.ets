@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Tab 1', 'Tab 2', 'Tab 3']

  build() {
    Stack() {
      Stack() {
        Column({ space: 16 }) {
          Text('Course Catalog')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#FF111111')
            .fontSize(28)

          Row({ space: 0 }) {
            ForEach(this.tabs.map((_, i) => i), (index: number) => {
              Button() {
                Text(this.tabs[index])
                  .fontColor(this.selectedTabIndex === index ? '#6750A4' : '#79747E')
                  .fontWeight(this.selectedTabIndex === index ? FontWeight.Bold : FontWeight.Normal)
              }
              .onClick(() => {
                this.selectedTabIndex = index
              })
              .backgroundColor(Color.Transparent)
              .borderRadius(8)
              .padding(12)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)

          TabRow() {
            ForEach(this.tabs.map((_, i) => i), (index: number) => {
              TabContent()
            })
          }
          .selected(this.selectedTabIndex)
          .onChange((index: number) => {
            this.selectedTabIndex = index
          })
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }
    }.width('100%').height('100%')
  }
}

@Component
struct CourseCard {
  @Prop courseNumber: number = 1

  build() {
    Column() {
      Text(`Course ${this.courseNumber}`)
        .fontSize(16)
        .fontColor('#1C1B1F')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1F000000', offsetY: 1 })
  }
}