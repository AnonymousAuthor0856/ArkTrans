@Entry
@Component
struct TaskDashboardScreen {
  @State selectedCategory: string = 'All'
  @State taskStates: boolean[] = [true, false, false, false]

  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top Header
        Row() {
          this.TopHeader()
        }
        .margin({ top: 48, left: 24, right: 24, bottom: 16 })

        // Scrollable Content
        Scroll() {
          Column() {
            Column() {
              this.WelcomeSection()
            }
            .margin({ top: 16 })

            Column() {
              this.CategorySelector()
            }
            .margin({ top: 32 })

            Column() {
              this.RecentTasksList()
            }
            .margin({ top: 24 })

            Blank()
              .height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // FAB
      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .shadow({ radius: 4, offsetY: 4, color: '#40000000' })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopHeader() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .type(ButtonType.Normal)

      Blank()

      Button() {
        Text('\u{1F50D}')
          .fontSize(18)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .type(ButtonType.Normal)
    }
    .width('100%')
  }

  @Builder
  WelcomeSection() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#888888')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  CategorySelector() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedCategory === category ? Color.White : Color.Black)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(this.selectedCategory === category ? '#212121' : '#F5F5F5')
            .borderRadius(999)
            .onClick(() => {
              this.selectedCategory = category
            })
        }, (category: string) => category)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  RecentTasksList() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Column() {
        this.TaskItem(0, 'Team Meeting', '10:00 AM - 11:30 AM', 'Work', '#E3F2FD', '#1565C0', '\u{1F4C5}')
      }
      .margin({ top: 16 })
      .width('100%')

      Column() {
        this.TaskItem(1, 'Design Review', '02:00 PM - 03:00 PM', 'Design', '#F3E5F5', '#7B1FA2', '\u{1F4C5}')
      }
      .margin({ top: 16 })
      .width('100%')

      Column() {
        this.TaskItem(2, 'Grocery Shopping', '05:30 PM', 'Personal', '#E8F5E9', '#2E7D32', '\u{1F60A}')
      }
      .margin({ top: 16 })
      .width('100%')

      Column() {
        this.TaskItem(3, 'Read Documentation', '08:00 PM', 'Study', '#FFF3E0', '#EF6C00', '\u{1F4C5}')
      }
      .margin({ top: 16 })
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  TaskItem(index: number, title: string, time: string, tag: string, tagBgColor: string, tagTextColor: string, icon: string) {
    Row() {
      // Icon Box
      Stack({ alignContent: Alignment.Center }) {
        Text(icon)
          .fontSize(22)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.White)
      .borderRadius(14)

      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.taskStates[index] ? '#888888' : Color.Black)
          .decoration({ type: this.taskStates[index] ? TextDecorationType.LineThrough : TextDecorationType.None, color: '#888888' })

        Row() {
          Text(time)
            .fontSize(12)
            .fontColor('#888888')

          Text(tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(tagBgColor)
            .borderRadius(4)
            .margin({ left: 8 })
        }
        .margin({ top: 4 })
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })
      .layoutWeight(1)

      // Checkbox Button
      Button() {
        Text(this.taskStates[index] ? '☑' : '☐')
          .fontSize(24)
          .fontColor(this.taskStates[index] ? Color.Black : '#888888')
      }
      .width(24)
      .height(24)
      .backgroundColor(Color.Transparent)
      .type(ButtonType.Normal)
      .onClick(() => {
        this.taskStates[index] = !this.taskStates[index]
      })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}
