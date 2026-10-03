@Entry
@Component
struct TaskDashboardApp {
  @State isChecked0: boolean = true
  @State isChecked1: boolean = false
  @State isChecked2: boolean = false
  @State isChecked3: boolean = false

  private categories: string[] = ['All', 'Work', 'Personal', 'Design']

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

      Column({ space: 0 }) {
        Row({ space: 0 }) {
          Button() {
            Text('☰')
              .fontSize(24)
              .foregroundColor('#000000')
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)

          Blank()

          Button() {
            Text('🔍')
              .fontSize(24)
              .foregroundColor('#000000')
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 48, bottom: 16 })

        List({ space: 0 }) {
          ListItem() {
            Column({ space: 8 }) {
              Text('Hello, Alex')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#000000')
              Text('You have 5 incomplete tasks today.')
                .fontSize(16)
                .foregroundColor('#808080')
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 16 })
          }

          ListItem() {
            Row({ space: 12 }) {
              ForEach(this.categories, (cat: string) => {
                this.buildCategoryChip(cat, cat === 'All')
              })
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 24, bottom: 24 })
          }

          ListItem() {
            Text('Recent Tasks')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
              .width('100%')
              .padding({ left: 24, right: 24, bottom: 16 })
          }

          ListItem() {
            this.buildTaskItem('Team Meeting', '10:00 AM - 11:30 AM', 'Work',
              '#E3F2FD', '#1565C0', this.isChecked0)
          }
          ListItem() {
            this.buildTaskItem('Design Review', '02:00 PM - 03:00 PM', 'Design',
              '#F3E5F5', '#7B1FA2', this.isChecked1)
          }
          ListItem() {
            this.buildTaskItem('Grocery Shopping', '05:30 PM', 'Personal',
              '#E8F5E9', '#2E7D32', this.isChecked2)
          }
          ListItem() {
            this.buildTaskItem('Read Documentation', '08:00 PM', 'Study',
              '#FFF3E0', '#EF6C00', this.isChecked3)
          }

          ListItem() {
            Column()
              .height(80)
              .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FFFFFF')
          .width(56)
          .height(56)
          .textAlign(TextAlign.Center)
      }
      .width(56)
      .height(56)
      .backgroundColor('#212121')
      .borderRadius(28)
      .shadow({ radius: 4, color: '#000000', offsetY: 4 })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildCategoryChip(cat: string, isSelected: boolean) {
    Button() {
      Text(cat)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .foregroundColor(isSelected ? '#FFFFFF' : '#000000')
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    }
    .backgroundColor(isSelected ? '#212121' : '#F5F5F5')
    .borderRadius(999)
  }

  @Builder
  buildTaskItem(title: string, time: string, tag: string, tagBg: string, tagColor: string, isChecked: boolean) {
    Row({ space: 16 }) {
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width(48)
          .height(48)
          .backgroundColor('#FFFFFF')
          .borderRadius(14)
        Text('📅')
          .fontSize(24)
      }
      .width(48)
      .height(48)

      Column({ space: 4 }) {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .foregroundColor(isChecked ? '#808080' : '#000000')
          .decoration({ type: isChecked ? TextDecorationType.LineThrough : TextDecorationType.None })
        Row({ space: 8 }) {
          Text(time)
            .fontSize(12)
            .foregroundColor('#808080')
          Text(tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .foregroundColor(tagColor)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(tagBg)
            .borderRadius(4)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text(isChecked ? '☑' : '☐')
          .fontSize(24)
          .foregroundColor(isChecked ? '#000000' : '#808080')
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
      }
      .width(24)
      .height(24)
      .onClick(() => {
        if (title === 'Team Meeting') {
          this.isChecked0 = !this.isChecked0
        } else if (title === 'Design Review') {
          this.isChecked1 = !this.isChecked1
        } else if (title === 'Grocery Shopping') {
          this.isChecked2 = !this.isChecked2
        } else if (title === 'Read Documentation') {
          this.isChecked3 = !this.isChecked3
        }
      })
    }
    .padding(20)
    .width('100%')
    .backgroundColor('#FAFAFA')
    .borderRadius(20)
    .padding({ left: 24, right: 24 })
  }
}