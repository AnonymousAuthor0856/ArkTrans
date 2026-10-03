@Entry
@Component
struct TaskDashboardScreen {
  @State isChecked1: boolean = true
  @State isChecked2: boolean = false
  @State isChecked3: boolean = false
  @State isChecked4: boolean = false

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

      // Main content
      Column() {
        // Top Header
        TopHeader()
          .padding({ top: 48, left: 24, right: 24, bottom: 16 })

        // Scrollable content
        Scroll() {
          Column({ space: 0 }) {
            // Welcome Section
            WelcomeSection()
              .margin({ top: 16 })

            // Category Selector
            CategorySelector()
              .margin({ top: 32 })

            // Recent Tasks List
            RecentTasksList(
              isChecked1: this.isChecked1,
              isChecked2: this.isChecked2,
              isChecked3: this.isChecked3,
              isChecked4: this.isChecked4,
              onToggle1: () => { this.isChecked1 = !this.isChecked1 },
              onToggle2: () => { this.isChecked2 = !this.isChecked2 },
              onToggle3: () => { this.isChecked3 = !this.isChecked3 },
              onToggle4: () => { this.isChecked4 = !this.isChecked4 }
            )
              .margin({ top: 24 })

            // Bottom padding for FAB
            Blank()
              .height(80)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // FAB
      Button() {
        // Action
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .shadow({ radius: 8, color: '#40000000', offsetY: 4 })
      .margin({ right: 24, bottom: 24 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .margin({ right: 24, bottom: 24 })
        .width(56)
        .height(56)
        .textAlign(TextAlign.Center)
        .translate({ y: -14 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Button() {
        // Menu action
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text('☰')
        .fontSize(20)
        .fontColor('#000000')
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
        .translate({ y: -14 })

      Blank()
        .layoutWeight(1)

      Button() {
        // Search action
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Text('🔍')
        .fontSize(18)
        .fontColor('#000000')
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
        .translate({ y: -14 })
    }
    .width('100%')
  }
}

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
    .width('100%')
  }
}

@Component
struct CategorySelector {
  @State selectedCategory: string = 'All'
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(category === this.selectedCategory ? '#FFFFFF' : '#000000')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(category === this.selectedCategory ? '#212121' : '#F5F5F5')
            .borderRadius(24)
            .onClick(() => {
              this.selectedCategory = category
            })
        })
      }
      .padding({ left: 4, right: 4 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct RecentTasksList {
  @Prop isChecked1: boolean
  @Prop isChecked2: boolean
  @Prop isChecked3: boolean
  @Prop isChecked4: boolean
  onToggle1: () => void = () => {}
  onToggle2: () => void = () => {}
  onToggle3: () => void = () => {}
  onToggle4: () => void = () => {}

  build() {
    Column({ space: 16 }) {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      TaskItem(
        title: 'Team Meeting',
        time: '10:00 AM - 11:30 AM',
        tag: 'Work',
        tagColor: '#E3F2FD',
        tagTextColor: '#1565C0',
        isChecked: this.isChecked1,
        icon: '📅',
        onToggle: () => { this.onToggle1() }
      )

      TaskItem(
        title: 'Design Review',
        time: '02:00 PM - 03:00 PM',
        tag: 'Design',
        tagColor: '#F3E5F5',
        tagTextColor: '#7B1FA2',
        isChecked: this.isChecked2,
        icon: '📅',
        onToggle: () => { this.onToggle2() }
      )

      TaskItem(
        title: 'Grocery Shopping',
        time: '05:30 PM',
        tag: 'Personal',
        tagColor: '#E8F5E9',
        tagTextColor: '#2E7D32',
        isChecked: this.isChecked3,
        icon: '😊',
        onToggle: () => { this.onToggle3() }
      )

      TaskItem(
        title: 'Read Documentation',
        time: '08:00 PM',
        tag: 'Study',
        tagColor: '#FFF3E0',
        tagTextColor: '#EF6C00',
        isChecked: this.isChecked4,
        icon: '📅',
        onToggle: () => { this.onToggle4() }
      )
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct TaskItem {
  title: string = ''
  time: string = ''
  tag: string = ''
  tagColor: string = '#E3F2FD'
  tagTextColor: string = '#1565C0'
  @Prop isChecked: boolean = false
  icon: string = '📅'
  onToggle: () => void = () => {}

  build() {
    Row({ space: 16 }) {
      // Icon Box
      Column() {
        Text(this.icon)
          .fontSize(22)
      }
      .width(48)
      .height(48)
      .backgroundColor('#FFFFFF')
      .borderRadius(14)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // Title and details
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

      // Checkbox
      Button() {
        this.onToggle()
      }
      .width(24)
      .height(24)
      .backgroundColor('#00000000')

      Text(this.isChecked ? '☑' : '☐')
        .fontSize(24)
        .fontColor(this.isChecked ? '#000000' : '#808080')
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .translate({ y: -12 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .alignItems(VerticalAlign.Center)
  }
}