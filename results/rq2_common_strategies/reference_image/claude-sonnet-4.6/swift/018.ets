// ---------------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------------
class Colors {
  static readonly primary: string = '#D7BBA8';
  static readonly secondary: string = '#A2C4C9';
  static readonly tertiary: string = '#B3C9A2';
  static readonly background: string = '#F0EBE3';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E6E0D9';
  static readonly outline: string = '#DCD7CF';
  static readonly success: string = '#7EA87E';
  static readonly warning: string = '#D9B872';
  static readonly error: string = '#D98B8B';
  static readonly onPrimary: string = '#433E3A';
  static readonly onSecondary: string = '#433E3A';
  static readonly onTertiary: string = '#433E3A';
  static readonly onBackground: string = '#433E3A';
  static readonly onSurface: string = '#433E3A';
  static readonly onSurfaceMuted: string = '#99433E3A';   // onSurface @ 0.6
  static readonly onPrimaryMuted: string = '#33433E3A';   // onPrimary @ 0.2
  static readonly elevation1: string = '#0D000000';       // black @ 0.05
  static readonly elevation2: string = '#14000000';       // black @ 0.08
}

class Typography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 22;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class Shapes {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
}

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------
class Filter {
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

// ---------------------------------------------------------------------------
// Root screen
// ---------------------------------------------------------------------------
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  private filters: Filter[] = [
    new Filter('vintage', 'Vintage'),
    new Filter('grain', 'Grain'),
    new Filter('b&w', 'B&W'),
    new Filter('neon', 'Neon')
  ];

  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', Colors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', Colors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', Colors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', Colors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', Colors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', Colors.outline)
  ];

  // MARK: Top bar
  @Builder
  TopBarSection() {
    Column({ space: Spacing.md }) {
      Text('Filter Shop')
        .fontSize(Typography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)

      Row({ space: Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .fontSize(Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(this.selectedFilter === filter.id ? Colors.onPrimary : Colors.onBackground)
            .padding({
              left: Spacing.md,
              right: Spacing.md,
              top: Spacing.sm,
              bottom: Spacing.sm
            })
            .backgroundColor(this.selectedFilter === filter.id ? Colors.primary : Colors.surface)
            .borderRadius(Shapes.large)
            .border({
              width: 2,
              color: this.selectedFilter === filter.id ? Colors.onSurfaceMuted : Colors.outline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: Filter) => filter.id)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({
      left: Spacing.lg,
      right: Spacing.lg,
      top: Spacing.md,
      bottom: Spacing.md
    })
    .backgroundColor(Colors.background)
  }

  // MARK: Card
  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      Column()
        .width('100%')
        .aspectRatio(1)
        .borderRadius(Shapes.medium)
        .backgroundColor(item.color)

      Column({ space: Spacing.sm }) {
        Text(item.name)
          .fontSize(Typography.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)

        Text(item.author)
          .fontSize(Typography.labelSize)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(Colors.onSurfaceMuted)

        Text(item.price)
          .fontSize(Typography.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(Spacing.sm)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.sm)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .shadow({
      radius: 8,
      color: Colors.elevation1,
      offsetX: 4,
      offsetY: 4
    })
  }

  // MARK: Bottom bar
  @Builder
  BottomBarSection() {
    Row() {
      Text('3 items in cart')
        .fontSize(Typography.bodySize)
        .fontColor(Colors.onSurface)

      Blank()

      Button({ type: ButtonType.Normal }) {
        Row({ space: Spacing.sm }) {
          Circle({ width: 16, height: 16 })
            .fill(Colors.onPrimaryMuted)

          Text('Checkout')
            .fontSize(Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
        }
        .alignItems(VerticalAlign.Center)
      }
      .padding({
        left: Spacing.xl,
        right: Spacing.xl,
        top: Spacing.sm,
        bottom: Spacing.sm
      })
      .backgroundColor(Colors.primary)
      .borderRadius(Shapes.large)
      .shadow({
        radius: 8,
        color: Colors.elevation1,
        offsetX: 4,
        offsetY: 4
      })
      .onClick(() => {
        console.info('Checkout tapped');
      })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding({
      left: Spacing.lg,
      right: Spacing.lg,
      top: Spacing.md,
      bottom: Spacing.md
    })
    .backgroundColor(Colors.surface)
    .shadow({
      radius: 12,
      color: Colors.elevation2,
      offsetX: 6,
      offsetY: 6
    })
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
      .columnsGap(Spacing.md)
      .rowsGap(Spacing.md)
      .padding(Spacing.lg)
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(Colors.background)

      this.BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}