class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

class FilterSearchColors {
  static primary: string = '#FF7B00';
  static secondary: string = '#FFD166';
  static background: string = '#FFF6E5';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFF0C1';
  static outline: string = '#E0C080';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#3E2723';
  static onSurface: string = '#3E2723';
}

@Entry
@Component
struct Index {
  @State query: string = '';
  @State knobX: number = 160;
  @State knobY: number = 120;

  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];
  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ];

  @Builder
  FilterButton(label: string) {
    Button(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(FilterSearchColors.onSecondary)
      .height(36)
      .backgroundColor(FilterSearchColors.secondary)
      .borderRadius(6)
  }

  @Builder
  KnobPanel() {
    Stack({ alignContent: Alignment.Center }) {
      Text('')
        .width('100%')
        .height('100%')
        .backgroundColor(FilterSearchColors.surfaceVariant)
      Circle()
        .width(160)
        .height(160)
        .fill(FilterSearchColors.secondary)
      Circle()
        .width(32)
        .height(32)
        .fill(FilterSearchColors.primary)
        .position({ x: this.knobX, y: this.knobY })
    }
    .width('100%')
    .height(180)
    .backgroundColor(FilterSearchColors.surface)
    .borderRadius(14)
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          let nextX: number = this.knobX + event.offsetX;
          let nextY: number = this.knobY + event.offsetY;
          if (nextX < 0) {
            nextX = 0;
          }
          if (nextX > 300) {
            nextX = 300;
          }
          if (nextY < 0) {
            nextY = 0;
          }
          if (nextY > 150) {
            nextY = 150;
          }
          this.knobX = nextX;
          this.knobY = nextY;
        })
    )
  }

  @Builder
  ResultCard(item: ResultItem) {
    Column() {
      Text('')
        .width(96)
        .height(96)
        .backgroundColor(FilterSearchColors.surfaceVariant)
        .borderRadius(10)
      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(FilterSearchColors.onSurface)
        .lineHeight(22)
        .margin({ top: 8 })
      Button('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(FilterSearchColors.onPrimary)
        .width('100%')
        .height(36)
        .backgroundColor(FilterSearchColors.primary)
        .borderRadius(10)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(FilterSearchColors.surface)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(FilterSearchColors.onSurface)
        .lineHeight(34)
        .width('100%')

      TextInput({ text: this.query, placeholder: 'Search products' })
        .width('100%')
        .height(48)
        .fontColor(FilterSearchColors.onSurface)
        .placeholderColor('#663E2723')
        .backgroundColor(FilterSearchColors.surface)
        .border({ width: 1, color: FilterSearchColors.outline, radius: 10 })
        .borderRadius(10)
        .onChange((value: string) => {
          this.query = value;
        })
        .margin({ top: 12 })

      Row({ space: 8 }) {
        ForEach(this.filters, (filter: string) => {
          this.FilterButton(filter)
        }, (filter: string) => filter)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 12 })

      Column() {
        this.KnobPanel()
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
      .layoutWeight(1)
      .padding({ top: 16, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(FilterSearchColors.background)
  }
}
