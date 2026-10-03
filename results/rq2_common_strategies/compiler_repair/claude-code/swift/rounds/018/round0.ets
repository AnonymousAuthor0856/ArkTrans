// Color design tokens
class AppColors {
  static readonly primary: ResourceColor = Color(0xFFD7BBA8);
  static readonly secondary: ResourceColor = Color(0xFFA2C4C9);
  static readonly tertiary: ResourceColor = Color(0xFFB3C9A2);
  static readonly background: ResourceColor = Color(0xFFF0EBE3);
  static readonly surface: ResourceColor = Color(0xFFFFFFFF);
  static readonly surfaceVariant: ResourceColor = Color(0xFFE6E0D9);
  static readonly outline: ResourceColor = Color(0xFFDCD7CF);
  static readonly success: ResourceColor = Color(0xFF7EA87E);
  static readonly warning: ResourceColor = Color(0xFFD9B872);
  static readonly error: ResourceColor = Color(0xFFD98B8B);
  static readonly onPrimary: ResourceColor = Color(0xFF433E3A);
  static readonly onSecondary: ResourceColor = Color(0xFF433E3A);
  static readonly onTertiary: ResourceColor = Color(0xFF433E3A);
  static readonly onBackground: ResourceColor = Color(0xFF433E3A);
  static readonly onSurface: ResourceColor = Color(0xFF433E3A);
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

// Shadow specs
class Elevation {
  static level1 = {
    radius: 8,
    color: Color(0x0D000000),
    offsetX: 4,
    offsetY: 4
  };
  static level2 = {
    radius: 12,
    color: Color(0x14000000),
    offsetX: 6,
    offsetY: 6
  };
}

// Data models
interface Filter {
  id: string;
  name: string;
}

interface FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: ResourceColor;
}

// Top bar with title and filter chips
@Component
struct TopBarSection {
  filters: Filter[] = [];
  @Link selectedFilter: string;

  build() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Row() {
        ForEach(this.filters, (filter: Filter) => {
          let isSelected: boolean = filter.id === this.selectedFilter;
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
              color: isSelected ? Color(0x1A433E3A) : AppColors.outline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: Filter) => filter.id)
      }
      .space(Spacing.sm)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .space(Spacing.md)
  }
}

// Product card for a filter item
@Component
struct FilterCard {
  item: FilterItem;

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
          .fontColor(Color(0x99433E3A))

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .space(Spacing.sm)
      .padding(Spacing.sm)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .space(0)
    .padding(Spacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(ShapeRadius.large)
    .shadow(Elevation.level1)
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
          .backgroundColor(Color(0x33433E3A))
          .borderRadius(8)
        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .space(Spacing.sm)
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

  private filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];

  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: AppColors.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: AppColors.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: AppColors.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: AppColors.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: AppColors.warning },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppColors.outline }
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
