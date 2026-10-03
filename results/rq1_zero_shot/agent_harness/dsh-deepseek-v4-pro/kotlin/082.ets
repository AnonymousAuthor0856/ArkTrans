@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        TopHeader()
        Column() {
          Blank().height(16)
          WelcomeSection()
          Blank().height(32)
          CategorySelector()
          Blank().height(24)
          RecentTasksList()
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Button({ type: ButtonType.Circle }) {
        Text('+').fontSize(24).fontColor('#FFFFFF')
      }
      .width(56).height(56)
      .backgroundColor('#212121')
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('≡').fontSize(24).fontColor('#000000')
      }
      .width(48).height(48)
      .backgroundColor('#F5F5F5')

      Button({ type: ButtonType.Circle }) {
        Text('🔍').fontSize(24).fontColor('#000000')
      }
      .width(48).height(48)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct WelcomeSection {
  build() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Blank().height(8)
      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#888888')
    }
  }
}

@Component
struct CategorySelector {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Scroll() {
      Row() {
        ForEach(this.categories, (category: string) => {
          Text(category)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(category == 'All' ? '#FFFFFF' : '#000000')
            .backgroundColor(category == 'All' ? '#212121' : '#F5F5F5')
            .borderRadius(25)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }, (category: string) => category)
      }
      .space(12)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct RecentTasksList {
  build() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Column() {
        TaskItem({ title: 'Team Meeting', time: '10:00 AM - 11:30 AM', tag: 'Work', tagColor: '#E3F2FD', tagTextColor: '#1565C0', isChecked: true })
        TaskItem({ title: 'Design Review', time: '02:00 PM - 03:00 PM', tag: 'Design', tagColor: '#F3E5F5', tagTextColor: '#7B1FA2', isChecked: false })
        TaskItem({ title: 'Grocery Shopping', time: '05:30 PM', tag: 'Personal', tagColor: '#E8F5E9', tagTextColor: '#2E7D32', isChecked: false })
        TaskItem({ title: 'Read Documentation', time: '08:00 PM', tag: 'Study', tagColor: '#FFF3E0', tagTextColor: '#EF6C00', isChecked: false })
        Blank().height(80)
      }
      .space(16)
    }
  }
}

@Component
struct TaskItem {
  @Prop title: string = ''
  @Prop time: string = ''
  @Prop tag: string = ''
  @Prop tagColor: string = '#000000'
  @Prop tagTextColor: string = '#000000'
  @Prop isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.tag == 'Personal' ? '☺' : '🗓')
            .fontSize(24)
            .fontColor('#000000')
        }
        .width(48).height(48)
        .borderRadius(14)
        .backgroundColor('#FFFFFF')
        .alignContent(Alignment.Center)

        Blank().width(16)

        Column() {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? '#888888' : '#000000')
          Blank().height(4)
          Row() {
            Text(this.time)
              .fontSize(12)
              .fontColor('#888888')
            Blank().width(8)
            Text(this.tag)
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.tagTextColor)
              .backgroundColor(this.tagColor)
              .borderRadius(4)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)

        Checkbox({ name: this.title })
          .select(this.isChecked)
          .selectedColor('#000000')
          .width(24).height(24)
      }
      .width('100%')
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}
