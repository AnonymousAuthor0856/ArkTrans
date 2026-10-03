class TdColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly fabBg: string = '#FF212121'
  static readonly lightBg: string = '#FFF5F5F5'
  static readonly taskCardBg: string = '#FFFAFAFA'
  static readonly workTagBg: string = '#FFE3F2FD'
  static readonly workTagText: string = '#FF1565C0'
  static readonly designTagBg: string = '#FFF3E5F5'
  static readonly designTagText: string = '#FF7B1FA2'
  static readonly personalTagBg: string = '#FFE8F5E9'
  static readonly personalTagText: string = '#FF2E7D32'
  static readonly studyTagBg: string = '#FFFFF3E0'
  static readonly studyTagText: string = '#FFEF6C00'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('☰')
            .fontSize(24)
            .fontColor(TdColors.black)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(TdColors.lightBg)
            .borderRadius(24)

          Blank()

          Text('🔍')
            .fontSize(24)
            .fontColor(TdColors.black)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(TdColors.lightBg)
            .borderRadius(24)
        }
        .padding({ left: 24, right: 24, top: 48, bottom: 16 })

        Scroll() {
          Column() {
            Blank().height(16)

            Column() {
              Text('Hello, Alex')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(TdColors.black)

              Text('You have 5 incomplete tasks today.')
                .fontSize(16)
                .fontColor(TdColors.gray)
                .margin({ top: 8 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank().height(32)

            Scroll() {
              Row() {
                Text('All')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(TdColors.white)
                  .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                  .backgroundColor(TdColors.fabBg)
                  .borderRadius(24)
                  .margin({ right: 12 })

                Text('Work')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(TdColors.black)
                  .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                  .backgroundColor(TdColors.lightBg)
                  .borderRadius(24)
                  .margin({ right: 12 })

                Text('Personal')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(TdColors.black)
                  .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                  .backgroundColor(TdColors.lightBg)
                  .borderRadius(24)
                  .margin({ right: 12 })

                Text('Design')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(TdColors.black)
                  .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                  .backgroundColor(TdColors.lightBg)
                  .borderRadius(24)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Blank().height(24)

            Column() {
              Text('Recent Tasks')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(TdColors.black)

              TaskItem({
                title: 'Team Meeting', time: '10:00 AM - 11:30 AM', tag: 'Work',
                tagBg: TdColors.workTagBg, tagText: TdColors.workTagText,
                isChecked: true, icon: '📅'
              })
              TaskItem({
                title: 'Design Review', time: '02:00 PM - 03:00 PM', tag: 'Design',
                tagBg: TdColors.designTagBg, tagText: TdColors.designTagText,
                isChecked: false, icon: '📅'
              })
              TaskItem({
                title: 'Grocery Shopping', time: '05:30 PM', tag: 'Personal',
                tagBg: TdColors.personalTagBg, tagText: TdColors.personalTagText,
                isChecked: false, icon: '☺'
              })
              TaskItem({
                title: 'Read Documentation', time: '08:00 PM', tag: 'Study',
                tagBg: TdColors.studyTagBg, tagText: TdColors.studyTagText,
                isChecked: false, icon: '📅'
              })
            }
            .alignItems(HorizontalAlign.Start)

            Blank().height(80)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      Stack() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(TdColors.white)
          .width(56)
          .height(56)
          .textAlign(TextAlign.Center)
          .backgroundColor(TdColors.fabBg)
          .borderRadius(28)
          .shadow({ radius: 4, color: '#66000000', offsetY: 4 })
      }
      .margin({ right: 24, bottom: 24 })
    }
    .backgroundColor(TdColors.white)
    .width('100%')
    .height('100%')
    .alignContent(Alignment.BottomEnd)
  }
}

@Component
struct TaskItem {
  @Prop title: string = ''
  @Prop time: string = ''
  @Prop tag: string = ''
  @Prop tagBg: string = '#FFFFFF'
  @Prop tagText: string = '#FFFFFF'
  @Prop isChecked: boolean = false
  @Prop icon: string = ''
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = this.isChecked
  }

  build() {
    Row() {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(TdColors.black)
      }
      .width(48)
      .height(48)
      .backgroundColor(TdColors.white)
      .borderRadius(14)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? TdColors.gray : TdColors.black)
          .decoration({ type: this.checked ? TextDecorationType.LineThrough : TextDecorationType.None })

        Row() {
          Text(this.time)
            .fontSize(12)
            .fontColor(TdColors.gray)

          Text(this.tag)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tagText)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
            .backgroundColor(this.tagBg)
            .borderRadius(4)
            .margin({ left: 8 })
        }
        .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(this.checked ? '☑' : '☐')
        .fontSize(24)
        .fontColor(this.checked ? TdColors.black : TdColors.gray)
        .onClick(() => {
          this.checked = !this.checked
        })
    }
    .padding(20)
    .backgroundColor(TdColors.taskCardBg)
    .borderRadius(20)
    .margin({ top: 16 })
  }
}