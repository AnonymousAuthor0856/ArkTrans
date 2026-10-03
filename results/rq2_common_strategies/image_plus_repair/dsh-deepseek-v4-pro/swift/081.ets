// SwiftUI -> ArkTS translation of Task Dashboard App
// The @main App + ContentView scaffolding is folded into the single @Entry page:
// an @Entry component's build() must have one container component as its root node.

@Entry
@Component
struct TaskDashboardApp {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)

      Column({ space: 0 }) {
        // Top Header
        TopHeader()
          .padding({ top: 48 }) // Matching Android padding logic roughly for safe area
          .padding({ left: 24, right: 24 })
          .padding({ bottom: 16 })

        // Content
        Scroll() {
          Column({ space: 0 }) {
            Blank().height(16)

            WelcomeSection()

            Blank().height(32)

            CategorySelector()

            Blank().height(24)

            RecentTasksList()

            Blank().height(80) // Bottom padding for FAB
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // FAB
      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .shadow({ radius: 4, offsetY: 4 })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }
}

// MARK: - Header
@Component
struct TopHeader {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)

      Blank()

      Button() {
        Text('🔍')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
    }
    .width('100%')
  }
}

// MARK: - Sections
@Component
struct WelcomeSection {
  build() {
    Column({ space: 8 }) {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategorySelector {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design'];

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          CategoryChip({ category: category })
        }, (category: string) => category)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct CategoryChip {
  @Prop category: string;

  build() {
    Text(this.category)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.category === 'All' ? Color.White : Color.Black)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(this.category === 'All' ? '#212121' : '#F5F5F5')
      .borderRadius(21)
  }
}

@Component
struct RecentTasksList {
  build() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .padding({ bottom: 0 }) // Padding handled by spacing in VStack

      TaskItem({
        title: 'Team Meeting',
        time: '10:00 AM - 11:30 AM',
        tag: 'Work',
        tagColor: '#E3F2FD',
        tagTextColor: '#1565C0',
        isChecked: true,
        icon: '📅'
      })

      TaskItem({
        title: 'Design Review',
        time: '02:00 PM - 03:00 PM',
        tag: 'Design',
        tagColor: '#F3E5F5',
        tagTextColor: '#7B1FA2',
        isChecked: false,
        icon: '📅'
      })

      TaskItem({
        title: 'Grocery Shopping',
        time: '05:30 PM',
        tag: 'Personal',
        tagColor: '#E8F5E9',
        tagTextColor: '#2E7D32',
        isChecked: false,
        icon: '😊' // Approx for Face
      })

      TaskItem({
        title: 'Read Documentation',
        time: '08:00 PM',
        tag: 'Study',
        tagColor: '#FFF3E0',
        tagTextColor: '#EF6C00',
        isChecked: false,
        icon: '📅'
      })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Components
@Component
struct TaskItem {
  @Prop title: string;
  @Prop time: string;
  @Prop tag: string;
  @Prop tagColor: string;
  @Prop tagTextColor: string;
  @Prop isChecked: boolean;
  @Prop icon: string;

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Column()
          .width(48)
          .height(48)
          .borderRadius(14)
          .backgroundColor(Color.White)

        Text(this.icon)
          .fontSize(24)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
          .fontColor(Color.Black)
      }

      Column({ space: 4 }) {
        if (this.isChecked) {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .decoration({ type: TextDecorationType.LineThrough, color: Color.Gray })
        } else {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }

        Row({ space: 8 }) {
          Text(this.time)
            .fontSize(12)
            .fontColor(Color.Gray)

          Text(this.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tagTextColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.tagColor)
            .borderRadius(4)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text(this.isChecked ? '☑' : '☐')
          .fontSize(24)
          .fontColor(this.isChecked ? Color.Black : Color.Gray)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .onClick(() => {
        this.isChecked = !this.isChecked;
      })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}
