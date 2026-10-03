@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  private tabs: string[] = ['All', 'Enrolled', 'Completed']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        Text('Course Catalog')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .margin({ bottom: 8 })

        // Tab Row
        Row() {
          ForEach(this.tabs, (tab: string, index: number) => {
            Text(tab)
              .fontSize(18)
              .fontWeight(this.selectedTab === index ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.selectedTab === index ? '#111111' : '#444444')
              .backgroundColor(this.selectedTab === index ? '#E0E0E0' : '#FFFFFF')
              .borderRadius(4)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.selectedTab = index
              })
          })
        }
        .width('100%')
        .borderWidth({ bottom: 1 })
        .borderColor('#E0E0E0')

        // Content Area
        Column({ space: 12 }) {
          Text('All Courses')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#444444')

          // Course List
          ForEach(Array.from({ length: 6 }, (_, i: number): number => i), (index: number) => {
            Column() {
              Row() {
                Column({ space: 4 }) {
                  Text(`Course ${index + 1}`)
                    .fontSize(22)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111111')
                  
                  Text(`Duration: ${5 + index} hrs`)
                    .fontSize(16)
                    .fontColor('#444444')
                }
                .layoutWeight(1)

                Button('View')
                  .backgroundColor('#111111')
                  .fontColor('#FFFFFF')
                  .borderRadius(20)
                  .height(36)
                  .width(80)
                  .fontSize(16)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.SpaceBetween)
              .padding(16)
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          })
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}