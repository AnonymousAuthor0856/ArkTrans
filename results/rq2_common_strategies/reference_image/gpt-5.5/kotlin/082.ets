interface TaskData {
  title: string
  time: string
  tag: string
  tagColor: string
  tagTextColor: string
  isChecked: boolean
}

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
      .backgroundColor(Color.White)

      FloatingAddButton()
        .margin({ right: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      HeaderIconButton({ icon: 'menu' })
      HeaderIconButton({ icon: 'search' })
    }
    .width('100%')
    .padding({ top: 48, left: 24, right: 24, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HeaderIconButton {
  icon: string = 'menu'

  build() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.icon === 'menu') {
        MenuGlyph()
      } else {
        SearchGlyph()
      }
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct MenuGlyph {
  build() {
    Column({ space: 5 }) {
      Blank()
        .width(26)
        .height(3)
        .backgroundColor(Color.Black)

      Blank()
        .width(26)
        .height(3)
        .backgroundColor(Color.Black)

      Blank()
        .width(26)
        .height(3)
        .backgroundColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct SearchGlyph {
  build() {
    Text('⌕')
      .fontSize(34)
      .fontColor(Color.Black)
      .fontWeight(FontWeight.Bold)
      .height(34)
      .lineHeight(34)
  }
}

@Component
struct WelcomeSection {
  build() {
    Column() {
      Text('Hello, Alex')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank().height(8)

      Text('You have 5 incomplete tasks today.')
        .fontSize(16)
        .fontColor('#888888')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct CategorySelector {
  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.categories, (category: string) => {
          CategoryChip({
            label: category,
            selected: category === 'All'
          })
        }, (category: string) => category)
      }
      .padding({ right: 24 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }
}

@Component
struct CategoryChip {
  label: string = ''
  selected: boolean = false

  build() {
    Text(this.label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? Color.White : Color.Black)
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .backgroundColor(this.selected ? '#212121' : '#F5F5F5')
      .borderRadius(50)
  }
}

@Component
struct RecentTasksList {
  private tasks: TaskData[] = [
    {
      title: 'Team Meeting',
      time: '10:00 AM - 11:30 AM',
      tag: 'Work',
      tagColor: '#E3F2FD',
      tagTextColor: '#1565C0',
      isChecked: true
    },
    {
      title: 'Design Review',
      time: '02:00 PM - 03:00 PM',
      tag: 'Design',
      tagColor: '#F3E5F5',
      tagTextColor: '#7B1FA2',
      isChecked: false
    },
    {
      title: 'Grocery Shopping',
      time: '05:30 PM',
      tag: 'Personal',
      tagColor: '#E8F5E9',
      tagTextColor: '#2E7D32',
      isChecked: false
    },
    {
      title: 'Read Documentation',
      time: '08:00 PM',
      tag: 'Study',
      tagColor: '#FFF3E0',
      tagTextColor: '#EF6C00',
      isChecked: false
    }
  ]

  build() {
    Column() {
      Text('Recent Tasks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .padding({ bottom: 16 })

      Scroll() {
        Column({ space: 16 }) {
          ForEach(this.tasks, (task: TaskData) => {
            TaskItem({
              title: task.title,
              time: task.time,
              tag: task.tag,
              tagColor: task.tagColor,
              tagTextColor: task.tagTextColor,
              isChecked: task.isChecked
            })
          }, (task: TaskData) => task.title)

          Blank().height(80)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct TaskItem {
  title: string = ''
  time: string = ''
  tag: string = ''
  tagColor: string = '#E3F2FD'
  tagTextColor: string = '#1565C0'
  isChecked: boolean = false

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.tag === 'Personal' ? '☺' : '▦')
          .fontSize(28)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor(Color.White)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#888888' : Color.Black)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank().height(4)

        Row() {
          Text(this.time)
            .fontSize(12)
            .fontColor('#888888')
            .maxLines(1)

          Blank().width(8)

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
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank().width(8)

      CustomCheckBox({ checked: this.isChecked })
    }
    .width('100%')
    .padding(20)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
  }
}

@Component
struct CustomCheckBox {
  checked: boolean = false

  build() {
    if (this.checked) {
      Stack({ alignContent: Alignment.Center }) {
        Text('✓')
          .fontSize(30)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .height(30)
          .lineHeight(30)
      }
      .width(24)
      .height(24)
      .backgroundColor(Color.Black)
      .borderRadius(2)
    } else {
      Stack()
        .width(24)
        .height(24)
        .border({
          width: 3,
          color: '#888888'
        })
        .borderRadius(2)
    }
  }
}

@Component
struct FloatingAddButton {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('+')
        .fontSize(34)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Normal)
        .height(34)
        .lineHeight(34)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor('#212121')
    .shadow({
      radius: 20,
      color: '#33000000',
      offsetX: 0,
      offsetY: 8
    })
  }
}