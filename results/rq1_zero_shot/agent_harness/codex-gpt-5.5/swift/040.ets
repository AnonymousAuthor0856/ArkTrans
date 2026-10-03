class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

@Entry
@Component
struct RootScreen {
  @State private query: string = '';
  @State private knobX: number = 144;
  @State private knobY: number = 104;

  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'), new ResultItem(1, 'Result 2'), new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'), new ResultItem(4, 'Result 5'), new ResultItem(5, 'Result 6')
  ];
  private chips: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  @Builder
  FilterCanvas() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width('100%')
        .height(180)
        .fill('#FFF0C1')
        .radius(14)
      Circle()
        .width(120)
        .height(120)
        .fill('#FFD166')
      Circle()
        .width(32)
        .height(32)
        .fill('#FF7B00')
        .position({ x: this.knobX, y: this.knobY })
    }
    .width('100%')
    .height(180)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
  }

  @Builder
  CardView(item: ResultItem) {
    Column() {
      Rect()
        .width(96)
        .height(96)
        .fill('#FFF0C1')
        .radius(10)
      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .margin({ top: 8 })
      Button('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#FF7B00')
        .width('100%')
        .height(40)
        .borderRadius(10)
        .margin({ top: 8 })
    }
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Scroll() {
      Column() {
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .width('100%')

        TextInput({ text: this.query, placeholder: 'Search products' })
          .fontSize(14)
          .fontColor('#3E2723')
          .placeholderColor('#663E2723')
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#E0C080', radius: 10 })
          .borderRadius(10)
          .height(56)
          .padding({ left: 16, right: 16 })
          .width('100%')
          .margin({ top: 12 })
          .onChange((value: string) => {
            this.query = value;
          })

        Row() {
          ForEach(this.chips, (chip: string) => {
            Button(chip)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')
              .backgroundColor('#FFD166')
              .height(36)
              .padding({ left: 12, right: 12 })
              .borderRadius(6)
              .margin({ right: 8 })
          }, (chip: string) => chip)
        }
        .width('100%')
        .margin({ top: 12 })

        this.FilterCanvas()
          .margin({ top: 12 })

        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              this.CardView(item)
            }
          }, (item: ResultItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .margin({ top: 12 })
        .padding({ bottom: 24 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF6E5')
  }
}
