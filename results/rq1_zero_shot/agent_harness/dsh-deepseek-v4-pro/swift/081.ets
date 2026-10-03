// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: TaskDashboardApp

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    TaskDashboardScreen()
  }
}

// MARK: - Main Screen
@Component
struct TaskDashboardScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        TopHeader()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        Scroll() {
          Column() {
            Blank().height(16)
            WelcomeSection()
            Blank().height(32)
            CategorySelector()
            Blank().height(24)
            RecentTasksList()
            Blank().height(80)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#FFFFFF')
          .width(56)
          .height(56)
          .backgroundColor('#212121')
          .borderRadius(28)
          .shadow({ radius: 4, offsetY: 4 })
      }
      .onClick(() => {})
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - Header
@Component
struct TopHeader {
  build() {
    Row() {
      Button() {
        Text('☰')
          .fontColor('#000000')
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
      }
      .onClick(() => {})

      Blank()

      Button() {
        Text('🔍')
          .fontColor('#000000')
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
      }
      .onClick(() => {})
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
        .fontColor('#000000')

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategorySelector {
  categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === 'All' ? '#FFFFFF' : '#000000')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === 'All' ? '#212121' : '#F5F5F5')
            .borderRadius(50)
        }, (category: string) => category)
      }
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecentTasksList {
  build() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      TaskItem({ title: 'Team Meeting', time: '10:00 AM - 11:30 AM', tag: 'Work', tagColor: '#E3F2FD', tagTextColor: '#1565C0', isChecked: true, icon: '📅' })
      TaskItem({ title: 'Design Review', time: '02:00 PM - 03:00 PM', tag: 'Design', tagColor: '#F3E5F5', tagTextColor: '#7B1FA2', isChecked: false, icon: '📅' })
      TaskItem({ title: 'Grocery Shopping', time: '05:30 PM', tag: 'Personal', tagColor: '#E8F5E9', tagTextColor: '#2E7D32', isChecked: false, icon: '😊' })
      TaskItem({ title: 'Read Documentation', time: '08:00 PM', tag: 'Study', tagColor: '#FFF3E0', tagTextColor: '#EF6C00', isChecked: false, icon: '📅' })
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Components
@Component
struct TaskItem {
  title: string = ''
  time: string = ''
  tag: string = ''
  tagColor: string = '#FFFFFF'
  tagTextColor: string = '#000000'
  @State isChecked: boolean = false
  icon: string = ''

  build() {
    Row({ space: 16 }) {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor('#000000')
          .width(24)
          .height(24)
      }
      .width(48)
      .height(48)
      .backgroundColor('#FFFFFF')
      .borderRadius(14)

      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#808080' : '#000000')
          .decoration({ type: this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None, color: '#808080' })

        Row({ space: 8 }) {
          Text(this.time)
            .fontSize(12)
            .fontColor('#808080')

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
        Text(this.isChecked ? '☑' : '□')
          .fontSize(24)
          .fontColor(this.isChecked ? '#000000' : '#808080')
          .width(24)
          .height(24)
      }
      .onClick(() => { this.isChecked = !this.isChecked })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}
