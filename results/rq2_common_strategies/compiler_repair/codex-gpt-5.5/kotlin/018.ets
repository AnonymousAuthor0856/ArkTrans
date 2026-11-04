class FilterOption {
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

class FilterColors {
  static primary: string = '#D7BBA8';
  static secondary: string = '#A2C4C9';
  static tertiary: string = '#B3C9A2';
  static background: string = '#F0EBE3';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E6E0D9';
  static outline: string = '#DCD7CF';
  static warning: string = '#D9B872';
  static error: string = '#D98B8B';
  static onPrimary: string = '#433E3A';
  static onBackground: string = '#433E3A';
  static onSurface: string = '#433E3A';
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'vintage';

  private filters: FilterOption[] = [
    new FilterOption('vintage', 'Vintage'),
    new FilterOption('grain', 'Grain'),
    new FilterOption('b&w', 'B&W'),
    new FilterOption('neon', 'Neon')
  ];

  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', FilterColors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', FilterColors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', FilterColors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', FilterColors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', FilterColors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', FilterColors.outline)
  ];

  @Builder
  FilterChip(option: FilterOption) {
    Text(option.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedFilter === option.id ? FilterColors.onPrimary : FilterColors.onBackground)
      .lineHeight(16)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.selectedFilter === option.id ? FilterColors.primary : FilterColors.surface)
      .border({ width: 2, color: this.selectedFilter === option.id ? '#1A433E3A' : FilterColors.outline, radius: 24 })
      .borderRadius(24)
      .onClick(() => {
        this.selectedFilter = option.id;
      })
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      Blank()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(item.color)
        .borderRadius(16)
      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(FilterColors.onSurface)
          .lineHeight(22)
        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99433E3A')
          .lineHeight(16)
        Blank().height(8)
        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(FilterColors.primary)
          .lineHeight(22)
      }
      .padding(8)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(FilterColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 })
  }

  @Builder
  TopBarSection() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(FilterColors.onBackground)
        .lineHeight(34)
      Blank().height(12)
      Row({ space: 8 }) {
        ForEach(this.filters, (filter: FilterOption) => {
          this.FilterChip(filter)
        }, (filter: FilterOption) => filter.id)
      }
      .width('100%')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(FilterColors.background)
  }

  @Builder
  BottomBarSection() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontColor(FilterColors.onSurface)
        .lineHeight(20)
      Button('Checkout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(FilterColors.onPrimary)
        .backgroundColor(FilterColors.primary)
        .borderRadius(24)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(FilterColors.surface)
    .shadow({ radius: 12, color: '#14000000', offsetX: 0, offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBarSection()

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
      .layoutWeight(1)
      .width('100%')
      .padding(16)

      this.BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(FilterColors.background)
  }
}
