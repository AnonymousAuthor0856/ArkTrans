// AppTokens - Design tokens
class AppColors {
  static readonly primary: Color = Color(0xD7BBA8);
  static readonly secondary: Color = Color(0xA2C4C9);
  static readonly tertiary: Color = Color(0xB3C9A2);
  static readonly background: Color = Color(0xF0EBE3);
  static readonly surface: Color = Color(0xFFFFFF);
  static readonly surfaceVariant: Color = Color(0xE6E0D9);
  static readonly outline: Color = Color(0xDCD7CF);
  static readonly success: Color = Color(0x7EA87E);
  static readonly warning: Color = Color(0xD9B872);
  static readonly error: Color = Color(0xD98B8B);
  static readonly onPrimary: Color = Color(0x433E3A);
  static readonly onSecondary: Color = Color(0x433E3A);
  static readonly onTertiary: Color = Color(0x433E3A);
  static readonly onBackground: Color = Color(0x433E3A);
  static readonly onSurface: Color = Color(0x433E3A);
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppRadius {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
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
  color: Color;
}

// FilterChip component
@Component
struct FilterChip {
  @State filter: Filter;
  @State @Watch('onSelectedChange') selected: boolean = false;
  onSelect: (id: string) => void = () => {};

  onSelectedChange() {
    // Trigger parent callback
  }

  build() {
    Text(this.filter.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? AppColors.onPrimary : AppColors.onBackground)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.selected ? AppColors.primary : AppColors.surface)
      .border({
        width: 2,
        color: this.selected ? 'rgba(67, 62, 58, 0.1)' : AppColors.outline
      })
      .borderRadius(AppRadius.large)
      .onClick(() => {
        this.onSelect(this.filter.id);
      })
  }
}

// FilterCard component
@Component
struct FilterCard {
  @State item: FilterItem;

  build() {
    Column() {
      // Color preview square (aspect ratio 1:1)
      Row()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppRadius.medium)

      Column() {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: AppSpacing.xs })

        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(67, 62, 58, 0.6)')
          .margin({ bottom: AppSpacing.xs })

        Text(this.item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(AppSpacing.sm)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 4,
      offsetY: 4
    })
  }
}

// TopBarSection component
@Component
struct TopBarSection {
  filters: Filter[] = [];
  @State selectedFilter: string = '';
  onFilterSelect: (id: string) => void = () => {};

  build() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .margin({ bottom: AppSpacing.md })

      Row() {
        ForEach(this.filters, (filter: Filter) => {
          FilterChip({
            filter: filter,
            selected: filter.id === this.selectedFilter,
            onSelect: (id: string) => {
              this.selectedFilter = id;
              this.onFilterSelect(id);
            }
          })
        }, (filter: Filter) => filter.id)
      }
      .justifyContent(FlexAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// BottomBarSection component
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .lineHeight(20)

      Blank()

      Row() {
        Row()
          .width(16)
          .height(16)
          .backgroundColor('rgba(67, 62, 58, 0.2)')
          .borderRadius(8)

        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .margin({ left: AppSpacing.sm })
      }
      .padding({ left: 24, right: 24, top: 8, bottom: 8 })
      .backgroundColor(AppColors.primary)
      .borderRadius(AppRadius.large)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.05)',
        offsetX: 4,
        offsetY: 4
      })
      .onClick(() => {
        console.info('Checkout tapped');
      })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 12,
      color: 'rgba(0, 0, 0, 0.08)',
      offsetX: 6,
      offsetY: 6
    })
  }
}

// RootScreen component
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
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppColors.outline },
  ];

  build() {
    Column() {
      TopBarSection({
        filters: this.filters,
        selectedFilter: this.selectedFilter,
        onFilterSelect: (id: string) => {
          this.selectedFilter = id;
        }
      })
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        .backgroundColor(AppColors.background)

      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              FilterCard({ item: item })
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .padding(AppSpacing.lg)
      }
      .backgroundColor(AppColors.background)
      .layoutWeight(1)

      BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
