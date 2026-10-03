@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0
  private tabController: TabsController = new TabsController()

  build() {
    Stack() {
      Column() {
        Text('Course Catalog')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 16 })

        Row() {
          ForEach(['All', 'Enrolled', 'Completed'], (item: string, index: number) => {
            Button() {
              Text(item)
                .fontSize(16)
                .fontWeight(this.selectedTabIndex === index ? FontWeight.Medium : FontWeight.Normal)
                .fontColor(this.selectedTabIndex === index ? '#111111' : '#4F4F4F')
            }
            .layoutWeight(1)
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .borderWidth(this.selectedTabIndex === index ? 2 : 0)
            .borderColor('#111111')
            .borderRadius(4)
            .onClick(() => {
              this.selectedTabIndex = index
              this.tabController.changeIndex(index)
            })
          })
        }
        .width('100%')
        .height(44)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .margin({ top: 16, bottom: 16 })

        Tabs({ controller: this.tabController, barPosition: BarPosition.End }) {
          ForEach(['All Courses', 'Enrolled Courses', 'Completed Courses'], (item: string, index: number) => {
            TabContent() {
              Scroll() {
                Column() {
                  Text(item)
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#4F4F4F')
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .margin({ bottom: 16 })

                  ForEach(Array.from({ length: 6 }, (_, i: number): number => i), (i: number) => {
                    CourseCard({ courseNumber: i + 1 })
                  })
                }
                .padding({ left: 16, right: 16 })
              }
            }
            .tabBar(TabItem().icon('').title(item))
          })
        }
        .width('100%')
        .layoutWeight(1)
        .barMode(BarMode.Fixed)
        .onChange((index: number) => {
          this.selectedTabIndex = index
        })
      }
      .width('100%')
      .height('100%')
      .padding({ top: 50, left: 16, right: 16 })
      .backgroundColor('#F5F5F5')
    }.width('100%').height('100%')
  }
}

@Component
struct CourseCard {
  @Prop courseNumber: number = 1

  build() {
    Row() {
      Column() {
        Text(`Course ${this.courseNumber}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111111')
        
        Text(`Duration: ${this.courseNumber + 4} hrs`)
          .fontSize(14)
          .fontColor('#4F4F4F')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .layoutWeight(1)

      Button('View')
        .backgroundColor('#111111')
        .fontColor('#FFFFFF')
        .borderRadius(20)
        .height(32)
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
    .margin({ bottom: 12 })
  }
}