@Entry
@Component
struct Index {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Tab 1', 'Tab 2', 'Tab 3']

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        // Header Text
        Text('Course Catalog')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')

        // TabRow Simulation
        Row({ space: 16 }) {
          ForEach(this.tabs, (tab: string, index: number) => {
            Text(tab)
              .fontSize(index === this.selectedTabIndex ? 20 : 16)
              .fontWeight(index === this.selectedTabIndex ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(index === this.selectedTabIndex ? '#6750A4' : '#444444')
              .onClick(() => {
                this.selectedTabIndex = index
              })
          })
        }.width('100%').padding({ left: 16, right: 16 })

        // HorizontalPager Simulation (Switching content based on selectedTabIndex)
        if (this.selectedTabIndex === 0) {
          this.CourseListComponent(0)
        } else if (this.selectedTabIndex === 1) {
          this.CourseListComponent(1)
        } else {
          this.CourseListComponent(2)
        }
      }.width('100%').height('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 }).backgroundColor('#F5F5F5')
    }.width('100%').height('100%')
  }

  @Builder
  CourseListComponent(pageIndex: number) {
    Column({ space: 12 }) {
      Text(`Title for Page ${pageIndex + 1}`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#444444')

      // Card Component
      Column() {
        Row({ space: 0 }) {
          Column({ space: 8 }) {
            Text(`Course ${pageIndex + 1}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111111')
            
            Text(`Duration: ${5 + pageIndex} hrs`)
              .fontSize(14)
              .fontColor('#444444')
          }
          
          Blank()

          // View Button
          Stack({ alignContent: Alignment.Center }) {
            Text('View')
              .fontSize(14)
              .fontColor('#FFFFFF')
          }
          .height(24)
          .backgroundColor('#6750A4')
          .borderRadius(12)
          .padding({ left: 12, right: 12 })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding(12)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
    }
  }
}