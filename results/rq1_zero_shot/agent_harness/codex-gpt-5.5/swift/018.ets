class FilterModel {
  id: string;
  name: string;

  constructor(id: string, name: string) {
    this.id = id;
    this.name = name;
  }
}

class FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;

  constructor(id: number, name: string, author: string, price: string, color: string) {
    this.id = id;
    this.name = name;
    this.author = author;
    this.price = price;
    this.color = color;
  }
}

@Entry
@Component
struct RootScreen {
  @State private selectedFilter: string = 'vintage';

  private filters: FilterModel[] = [
    new FilterModel('vintage', 'Vintage'),
    new FilterModel('grain', 'Grain'),
    new FilterModel('b&w', 'B&W'),
    new FilterModel('neon', 'Neon')
  ];

  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', '#D98B8B'),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', '#D7BBA8'),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', '#A2C4C9'),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', '#B3C9A2'),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', '#D9B872'),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', '#DCD7CF')
  ];

  @Builder
  TopBarSection() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#433E3A')
      Row() {
        ForEach(this.filters, (filter: FilterModel) => {
          Text(filter.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(filter.id === this.selectedFilter ? '#433E3A' : '#433E3A')
            .letterSpacing(0.5)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(filter.id === this.selectedFilter ? '#D7BBA8' : '#FFFFFF')
            .border({ width: 2, color: filter.id === this.selectedFilter ? '#1A433E3A' : '#DCD7CF', radius: 24 })
            .borderRadius(24)
            .margin({ right: 8 })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: FilterModel) => filter.id)
      }
      .margin({ top: 12 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#F0EBE3')
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      Rect()
        .width('100%')
        .aspectRatio(1)
        .fill(item.color)
        .radius(16)
      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#433E3A')
        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99433E3A')
          .letterSpacing(0.5)
          .margin({ top: 8 })
        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#D7BBA8')
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(8)
    }
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
  }

  @Builder
  BottomBarSection() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontColor('#433E3A')
        .lineHeight(20)
      Blank()
      Button() {
        Row() {
          Circle()
            .width(16)
            .height(16)
            .fill('#33433E3A')
          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#433E3A')
            .margin({ left: 8 })
        }
        .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      }
      .backgroundColor('#D7BBA8')
      .borderRadius(24)
      .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: '#14000000', offsetX: 6, offsetY: 6 })
  }

  build() {
    Column() {
      this.TopBarSection()
      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              this.FilterCard(item)
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .backgroundColor('#F0EBE3')
      this.BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0EBE3')
  }
}
