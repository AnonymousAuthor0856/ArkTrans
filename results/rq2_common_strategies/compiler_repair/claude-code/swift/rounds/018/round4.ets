// Color design tokens
class AppColors {
  static readonly primary: ResourceColor = '#D7BBA8';
  static readonly secondary: ResourceColor = '#A2C4C9';
  static readonly tertiary: ResourceColor = '#B3C9A2';
  static readonly background: ResourceColor = '#F0EBE3';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E6E0D9';
  static readonly outline: ResourceColor = '#DCD7CF';
  static readonly success: ResourceColor = '#7EA87E';
  static readonly warning: ResourceColor = '#D9B872';
  static readonly error: ResourceColor = '#D98B8B';
  static readonly onPrimary: ResourceColor = '#433E3A';
  static readonly onSecondary: ResourceColor = '#433E3A';
  static readonly onTertiary: ResourceColor = '#433E3A';
  static readonly onBackground: ResourceColor = '#433E3A';
  static readonly onSurface: ResourceColor = '#433E3A';
}

// Spacing design tokens
class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

// Shape corner radii
class ShapeRadius {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
}

// Shadow specs using inline shadow values
class Elevation {
  static readonly level1Radius: number = 8;
  static readonly level1Color: ResourceColor = '#0D000000';
  static readonly level1OffsetX: number = 4;
  static readonly level1OffsetY: number = 4;
  static readonly level2Radius: number = 12;
  static readonly level2Color: ResourceColor = '#14000000';
  static readonly level2OffsetX: number = 6;
  static readonly level2OffsetY: number = 6;
}

// Data models
@Observed
class AppFilter {
  id: string = '';
  name: string = '';

  constructor(id: string = '', name: string = '') {
    this.id = id;
    this.name = name;
  }
}

@Observed
class FilterItem {
  id: number = 0;
  name: string = '';
  author: string = '';
  price: string = '';
  color: ResourceColor = '#FFFFFF';

  constructor(id: number = 0, name: string = '', author: string = '', price: string = '', color: ResourceColor = '#FFFFFF') {
    this.id = id;
    this.name = name;
    this.author = author;
    this.price = price;
    this.color = color;
  }
}

// Top bar with title and filter chips
@Component
struct TopBarSection {
  filters: AppFilter[] = [];
  @Link selectedFilter: string;

  @Builder
  FilterChip(filter: AppFilter, isSelected: boolean) {
    Text(filter.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .letterSpacing(0.5)
      .fontColor(isSelected ? AppColors.onPrimary : AppColors.onBackground)
      .padding({
        left: Spacing.md,
        right: Spacing.md,
        top: Spacing.sm,
        bottom: Spacing.sm
      })
      .backgroundColor(isSelected ? AppColors.primary : AppColors.surface)
      .borderRadius(ShapeRadius.large)
      .border({
        width: 2,
        color: isSelected ? '#1A433E3A' : AppColors.outline
      })
      .onClick(() => {
        this.selectedFilter = filter.id;
      })
  }

  build() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Row() {
        ForEach(this.filters, (filter: AppFilter) => {
          this.FilterChip(filter, filter.id === this.selectedFilter)
        }, (filter: AppFilter) => filter.id)
      }
      .margin({ bottom: 0 })
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 0, bottom: Spacing.md })
  }
}

// Product card for a filter item
@Component
struct FilterCard {
  item: FilterItem = new FilterItem();

  build() {
    Column() {
      Stack() { }
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(ShapeRadius.medium)

      Column() {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor('#99433E3A')

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: Spacing.sm })
      .padding(Spacing.sm)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(ShapeRadius.large)
    .shadow({ radius: Elevation.level1Radius, color: Elevation.level1Color, offsetX: Elevation.level1OffsetX, offsetY: Elevation.level1OffsetY })
  }
}

// Bottom bar with cart info and checkout button
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .lineHeight(20)
        .fontColor(AppColors.onSurface)

      Blank()

      Row() {
        Stack() { }
          .width(16)
          .height(16)
          .backgroundColor('#33433E3A')
          .borderRadius(8)
        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .margin({ left: Spacing.sm, right: 0 })
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .backgroundColor(AppColors.primary)
      .borderRadius(ShapeRadius.large)
      .shadow(Elevation.level1)
      .onClick(() => {
        console.info('Checkout tapped');
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({
      left: Spacing.lg,
      right: Spacing.lg,
      top: Spacing.md,
      bottom: Spacing.md
    })
  }
}

// Root screen
@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  private filters: AppFilter[] = [
    new AppFilter('vintage', 'Vintage'),
    new AppFilter('grain', 'Grain'),
    new AppFilter('b&w', 'B&W'),
    new AppFilter('neon', 'Neon')
  ];

  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', AppColors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', AppColors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', AppColors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', AppColors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', AppColors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', AppColors.outline)
  ];

  build() {
    Column() {
      TopBarSection({
        filters: this.filters,
        selectedFilter: $selectedFilter
      })
      .width('100%')
      .padding({
        left: Spacing.lg,
        right: Spacing.lg,
        top: Spacing.md,
        bottom: Spacing.md
      })
      .backgroundColor(AppColors.background)

      Grid() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            FilterCard({ item: item })
          }
        }, (item: FilterItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(Spacing.md)
      .rowsGap(Spacing.md)
      .padding(Spacing.lg)
      .backgroundColor(AppColors.background)
      .layoutWeight(1)

      BottomBarSection()
        .width('100%')
        .backgroundColor(AppColors.surface)
        .shadow(Elevation.level2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
