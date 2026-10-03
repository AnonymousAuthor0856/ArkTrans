// AppTokens - Design Tokens
class AppTokens {
  static readonly Colors = {
    primary: '#D7BBA8',
    secondary: '#A2C4C9',
    tertiary: '#B3C9A2',
    background: '#F0EBE3',
    surface: '#FFFFFF',
    surfaceVariant: '#E6E0D9',
    outline: '#DCD7CF',
    success: '#7EA87E',
    warning: '#D9B872',
    error: '#D98B8B',
    onPrimary: '#433E3A',
    onSecondary: '#433E3A',
    onTertiary: '#433E3A',
    onBackground: '#433E3A',
    onSurface: '#433E3A',
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 22, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 16,
    large: 24,
    circle: '50%',
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static readonly ElevationMapping = {
    level1: { radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 },
    level2: { radius: 12, color: '#14000000', offsetX: 6, offsetY: 6 },
  };
}

// Data Models
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

// TopBarSection Component
@Component
struct TopBarSection {
  private filters: Filter[] = [];
  @Link selectedFilter: string;

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Filter Shop')
        .font({ size: AppTokens.TypographyTokens.display.fontSize, weight: AppTokens.TypographyTokens.display.fontWeight })
        .fontColor(AppTokens.Colors.onBackground)
        .alignSelf(ItemAlign.Start)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .font({ size: AppTokens.TypographyTokens.label.fontSize, weight: AppTokens.TypographyTokens.label.fontWeight })
            .fontColor(filter.id === this.selectedFilter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(filter.id === this.selectedFilter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .border({ width: 2, color: filter.id === this.selectedFilter ? '#1A433E3A' : AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        })
      }
      .align(Alignment.Start)
    }
    .width('100%')
    .align(Alignment.Start)
  }
}

// FilterCard Component
@Component
struct FilterCard {
  private item: FilterItem = new FilterItem(0, '', '', '', '');

  build() {
    Column() {
      Column() {
        Column()
          .width('100%')
          .aspectRatio(1)
          .backgroundColor(this.item.color)
          .borderRadius(AppTokens.Shapes.medium)

        Column({ space: AppTokens.Spacing.sm }) {
          Text(this.item.name)
            .font({ size: AppTokens.TypographyTokens.title.fontSize, weight: FontWeight.Bold })
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.item.author)
            .font({ size: AppTokens.TypographyTokens.label.fontSize, weight: AppTokens.TypographyTokens.label.fontWeight })
            .fontColor('#99433E3A')

          Text(this.item.price)
            .font({ size: AppTokens.TypographyTokens.title.fontSize, weight: FontWeight.Bold })
            .fontColor(AppTokens.Colors.primary)
        }
        .padding(AppTokens.Spacing.sm)
        .alignItems(HorizontalAlign.Start)
      }
      .padding(AppTokens.Spacing.sm)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level1.radius,
        color: AppTokens.ElevationMapping.level1.color,
        offsetX: AppTokens.ElevationMapping.level1.offsetX,
        offsetY: AppTokens.ElevationMapping.level1.offsetY
      })
    }
  }
}

// BottomBarSection Component
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .font({ size: AppTokens.TypographyTokens.body.fontSize, weight: AppTokens.TypographyTokens.body.fontWeight })
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(20)

      Blank()

      Row({ space: AppTokens.Spacing.sm }) {
        Column()
          .width(16)
          .height(16)
          .backgroundColor('#33433E3A')
          .borderRadius(AppTokens.Shapes.circle)

        Text('Checkout')
          .font({ size: AppTokens.TypographyTokens.title.fontSize, weight: AppTokens.TypographyTokens.title.fontWeight })
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level1.radius,
        color: AppTokens.ElevationMapping.level1.color,
        offsetX: AppTokens.ElevationMapping.level1.offsetX,
        offsetY: AppTokens.ElevationMapping.level1.offsetY
      })
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
  }
}

// RootScreen Component
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
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', AppTokens.Colors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', AppTokens.Colors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', AppTokens.Colors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', AppTokens.Colors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', AppTokens.Colors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', AppTokens.Colors.outline),
  ];

  build() {
    Column() {
      // Top Bar
      TopBarSection({ filters: this.filters, selectedFilter: $selectedFilter })
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              FilterCard({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.lg)
      }
      .backgroundColor(AppTokens.Colors.background)
      .layoutWeight(1)

      // Bottom Bar
      BottomBarSection()
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: AppTokens.ElevationMapping.level2.color,
          offsetX: AppTokens.ElevationMapping.level2.offsetX,
          offsetY: AppTokens.ElevationMapping.level2.offsetY
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}