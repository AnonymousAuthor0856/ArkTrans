@Entry
@Component
struct Index {
  @State selectedCategory: string = 'All'
  @State checked: boolean[] = [true, false, false, false]

  private categories: string[] = ['All', 'Work', 'Personal', 'Design']
  private titles: string[] = ['Team Meeting', 'Design Review', 'Grocery Shopping', 'Read Documentation']
  private times: string[] = ['10:00 AM - 11:30 AM', '02:00 PM - 03:00 PM', '05:30 PM', '08:00 PM']
  private tags: string[] = ['Work', 'Design', 'Personal', 'Study']
  private tagBackgrounds: string[] = ['#E3F2FD', '#F3E5F5', '#E8F5E9', '#FFF3E0']
  private tagForegrounds: string[] = ['#1565C0', '#7B1FA2', '#2E7D32', '#EF6C00']

  @Builder
  private HeaderButton(symbol: string) {
    Stack() {
      Text(symbol)
        .fontSize(26)
        .fontColor('#080808')
        .fontWeight(FontWeight.Medium)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor('#F5F5F5')
    .alignContent(Alignment.Center)
  }

  @Builder
  private CategoryPill(category: string) {
    Text(category)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedCategory === category ? '#FFFFFF' : '#080808')
      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
      .borderRadius(40)
      .backgroundColor(this.selectedCategory === category ? '#212121' : '#F5F5F5')
      .onClick(() => {
        this.selectedCategory = category
      })
  }

  @Builder
  private TaskCard(index: number) {
    Row({ space: 16 }) {
      Stack() {
        Text(index === 2 ? '☺' : '▣')
          .fontSize(25)
          .fontColor('#090909')
      }
      .width(48)
      .height(48)
      .borderRadius(14)
      .backgroundColor('#FFFFFF')
      .alignContent(Alignment.Center)

      Column({ space: 8 }) {
        Text(this.titles[index])
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked[index] ? '#888888' : '#080808')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: 8 }) {
          Text(this.times[index])
            .fontSize(12)
            .fontColor('#888888')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.tags[index])
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.tagForegrounds[index])
            .padding({ left: 6, right: 6, top: 3, bottom: 3 })
            .borderRadius(4)
            .backgroundColor(this.tagBackgrounds[index])
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Stack() {
        if (this.checked[index]) {
          Text('✓')
            .fontSize(22)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(20)
      .height(20)
      .borderRadius(2)
      .backgroundColor(this.checked[index] ? '#050505' : '#FAFAFA')
      .border({ width: this.checked[index] ? 0 : 2, color: '#888888' })
      .onClick(() => {
        let next = this.checked.slice()
        next[index] = !next[index]
        this.checked = next
      })
    }
    .width('100%')
    .height(120)
    .padding({ left: 20, right: 20 })
    .borderRadius(20)
    .backgroundColor('#FAFAFA')
  }

  build() {
    Stack() {
      Column() {
        Row() {
          this.HeaderButton('☰')
          Blank()
          this.HeaderButton('⌕')
        }
        .width('100%')
        .height(96)
        .padding({ left: 24, right: 24, top: 48, bottom: 0 })
        .alignItems(VerticalAlign.Top)

        Scroll() {
          Column({ space: 0 }) {
            Column({ space: 8 }) {
              Text('Hello, Alex')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#080808')
              Text('You have 5 incomplete tasks today.')
                .fontSize(16)
                .fontColor('#888888')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 30 })

            Scroll() {
              Row({ space: 12 }) {
                ForEach(this.categories, (category: string) => {
                  this.CategoryPill(category)
                }, (category: string) => category)
              }
              .padding({ right: 24 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ top: 34 })

            Column({ space: 16 }) {
              Text('Recent Tasks')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111111')
                .width('100%')
                .margin({ bottom: 0 })
              ForEach([0, 1, 2, 3], (index: number) => {
                this.TaskCard(index)
              }, (index: number) => `${index}`)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 24, bottom: 100 })
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 16 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      Stack() {
        Text('+')
          .fontSize(34)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#212121')
      .alignContent(Alignment.Center)
      .position({ right: 16, bottom: 16 })
      .shadow({ radius: 12, color: '#30000000', offsetX: 0, offsetY: 5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
