// Shadow options interface
interface ShadowOptions {
  radius: number;
  color: ResourceColor;
  offsetX: number;
  offsetY: number;
}

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

// Shadow specs
class Elevation {
  static readonly level1: ShadowOptions = {
    radius: 8,
    color: '#0D000000',
    offsetX: 4,
    offsetY: 4
  };
  static readonly level2: ShadowOptions = {
    radius: 12,
    color: '#14000000',
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
              color: isSelected ? '#1A433E3A' : AppColors.outline
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
  item: FilterItem = { id: 0, name: '', author: '', price: '', color: '#FFFFFF' };

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
          .backgroundColor('#33433E3A')
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
