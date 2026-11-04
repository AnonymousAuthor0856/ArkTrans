class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

@Entry
@Component
struct Index {
  @State query: string = ''
  @State knobX: number = 144
  @State knobY: number = 104

  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium']
  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ]

  @Builder
  FilterButton(text: string) {
    Button(text)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor('#3E2723')
      .height(36)
      .padding({ left: 12, right: 12 })
      .backgroundColor('#FFD166')
      .borderRadius(6)
  }

  @Builder
  ControlPanel() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .radius(14)
        .fill('#FFF0C1')

      Circle()
        .width(120)
        .height(120)
        .linearGradient({ angle: 180, colors: [['#FFD166', 0.0], ['#FF7B00', 1.0]] })

      Circle()
        .width(32)
        .height(32)
        .fill('#FF7B00')
        .translate({ x: this.knobX - 150, y: this.knobY - 86 })
    }
    .width('100%')
    .height(180)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
  }

  @Builder
  ResultCard(item: ResultItem) {
    Column() {
      Rect()
        .width(96)
        .height(96)
        .radius(10)
        .fill('#FFF0C1')

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .margin({ top: 8 })

      Button('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .width('100%')
        .height(40)
        .backgroundColor('#FF7B00')
        .borderRadius(10)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
  }

  build() {
    Column() {
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .width('100%')

      TextInput({ placeholder: 'Search products', text: this.query })
        .fontSize(14)
        .fontColor('#3E2723')
        .placeholderColor('#663E2723')
        .height(56)
        .width('100%')
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#E0C080', radius: 10 })
        .margin({ top: 12 })
        .onChange((value: string) => {
          this.query = value
        })

      Row() {
        ForEach(this.filters, (filter: string) => {
          Column() {
            this.FilterButton(filter)
          }
          .margin({ right: filter === 'Premium' ? 0 : 8 })
        }, (filter: string) => filter)
      }
      .width('100%')
      .margin({ top: 12 })

      Column() {
        this.ControlPanel()
      }
      .width('100%')
      .margin({ top: 12 })

      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            this.ResultCard(item)
          }
        }, (item: ResultItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .margin({ top: 12, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF6E5')
  }
}
