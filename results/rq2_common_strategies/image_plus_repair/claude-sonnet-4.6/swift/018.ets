class AppColors {
  primary: number = 0xFFD7BBA8;
  secondary: number = 0xFFA2C4C9;
  tertiary: number = 0xFFB3C9A2;
  background: number = 0xFFF0EBE3;
  surface: number = 0xFFFFFFFF;
  surfaceVariant: number = 0xFFE6E0D9;
  outline: number = 0xFFDCD7CF;
  success: number = 0xFF7EA87E;
  warning: number = 0xFFD9B872;
  error: number = 0xFFD98B8B;
  onPrimary: number = 0xFF433E3A;
  onSecondary: number = 0xFF433E3A;
  onTertiary: number = 0xFF433E3A;
  onBackground: number = 0xFF433E3A;
  onSurface: number = 0xFF433E3A;
}

class AppSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

const Colors = new AppColors();
const Spacing = new AppSpacing();

class FilterData {
  id: string = '';
  name: string = '';
}

class FilterItemData {
  id: number = 0;
  name: string = '';
  author: string = '';
  price: string = '';
  color: number = 0;
}

@Component
struct FilterChip {
  filter: FilterData = new FilterData();
  isSelected: boolean = false;
  onSelect: (id: string) => void = () => {};

  build() {
    Text(this.filter.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .letterSpacing(0.5)
      .fontColor(this.isSelected ? Colors.onPrimary : Colors.onBackground)
      .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
      .backgroundColor(this.isSelected ? Colors.primary : Colors.surface)
      .borderRadius(24)
      .border({
        width: 2,
        color: this.isSelected ? 0x1A433E3A : Colors.outline,
        style: BorderStyle.Solid
      })
      .onClick(() => {
        this.onSelect(this.filter.id);
      })
  }
}

@Component
struct TopBarSection {
  filters: FilterData[] = [];
  @Link selectedFilter: string;

  build() {
    Column({ space: Spacing.md }) {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      Row({ space: Spacing.sm }) {
        ForEach(this.filters, (filter: FilterData) => {
          FilterChip({
            filter: filter,
            isSelected: filter.id === this.selectedFilter,
            onSelect: (id: string) => {
              this.selectedFilter = id;
            }
          })
        }, (filter: FilterData) => filter.id)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct FilterCard {
  item: FilterItemData = new FilterItemData();

  build() {
    Column({ space: 0 }) {
      Row()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(16)

      Column({ space: Spacing.sm }) {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(0x99433E3A)
          .width('100%')
          .textAlign(TextAlign.Start)

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(Spacing.sm)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.sm)
    .backgroundColor(Colors.surface)
    .borderRadius(24)
    .shadow({
      radius: 8,
      color: 0x0D000000,
      offsetX: 4,
      offsetY: 4
    })
  }
}

@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(Colors.onSurface)
        .lineHeight(20)

      Blank()

      Row({ space: Spacing.sm }) {
        Circle()
          .width(16)
          .height(16)
          .fill(0x33433E3A)

        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
      }
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .backgroundColor(Colors.primary)
      .borderRadius(24)
      .shadow({
        radius: 8,
        color: 0x0D000000,
        offsetX: 4,
        offsetY: 4
      })
    }
    .width('100%')
    .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    .backgroundColor(Colors.surface)
    .shadow({
      radius: 12,
      color: 0x14000000,
      offsetX: 6,
      offsetY: 6
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  filters: FilterData[] = (() => {
    let f1 = new FilterData();
    f1.id = 'vintage';
    f1.name = 'Vintage';
    let f2 = new FilterData();
    f2.id = 'grain';
    f2.name = 'Grain';
    let f3 = new FilterData();
    f3.id = 'b&w';
    f3.name = 'B&W';
    let f4 = new FilterData();
    f4.id = 'neon';
    f4.name = 'Neon';
    return [f1, f2, f3, f4];
  })();

  items: FilterItemData[] = (() => {
    let i1 = new FilterItemData();
    i1.id = 1; i1.name = 'Redscale'; i1.author = 'by UserA'; i1.price = '$4.99'; i1.color = Colors.error;
    let i2 = new FilterItemData();
    i2.id = 2; i2.name = 'Sepia Tone'; i2.author = 'by UserB'; i2.price = '$2.99'; i2.color = Colors.primary;
    let i3 = new FilterItemData();
    i3.id = 3; i3.name = 'Aqua'; i3.author = 'by UserC'; i3.price = '$4.99'; i3.color = Colors.secondary;
    let i4 = new FilterItemData();
    i4.id = 4; i4.name = 'Forest'; i4.author = 'by UserD'; i4.price = '$3.99'; i4.color = Colors.tertiary;
    let i5 = new FilterItemData();
    i5.id = 5; i5.name = 'Golden Hour'; i5.author = 'by UserE'; i5.price = '$5.99'; i5.color = Colors.warning;
    let i6 = new FilterItemData();
    i6.id = 6; i6.name = 'Monochrome'; i6.author = 'by UserF'; i6.price = '$1.99'; i6.color = Colors.outline;
    return [i1, i2, i3, i4, i5, i6];
  })();

  build() {
    Column({ space: 0 }) {
      TopBarSection({
        filters: this.filters,
        selectedFilter: $selectedFilter
      })
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        .backgroundColor(Colors.background)
        .width('100%')

      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItemData) => {
            GridItem() {
              FilterCard({ item: item })
            }
          }, (item: FilterItemData) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.md)
        .rowsGap(Spacing.md)
        .padding(Spacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(Colors.background)
      .width('100%')
      .scrollBar(BarState.Off)

      BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}