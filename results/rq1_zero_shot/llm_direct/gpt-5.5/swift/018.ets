import window from '@ohos.window';

interface ShadowSpec {
  elevation: number;
  color: string;
  offsetX: number;
  offsetY: number;
  blurRadius: number;
}

class AppColors {
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

  static readonly onPrimary20: string = '#33433E3A';
  static readonly onSurface60: string = '#99433E3A';
  static readonly onBackground10: string = '#1A433E3A';
}

class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly displayWeight: string = '700';

  static readonly headlineSize: number = 22;
  static readonly headlineWeight: string = '600';

  static readonly titleSize: number = 16;
  static readonly titleWeight: string = '500';

  static readonly bodySize: number = 14;
  static readonly bodyWeight: string = '400';

  static readonly labelSize: number = 12;
  static readonly labelWeight: string = '500';
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
  static readonly circle: number = 999;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = {
    elevation: 3,
    color: '#0D000000',
    offsetX: 4,
    offsetY: 4,
    blurRadius: 8
  };

  static readonly level2: ShadowSpec = {
    elevation: 6,
    color: '#14000000',
    offsetX: 6,
    offsetY: 6,
    blurRadius: 12
  };
}

interface Filter {
  id: string;
  name: string;
}

interface FilterItem {
  id: number;
  name: string;
  author: string;
  price: string;
  color: string;
}

@Component
struct TopBarSection {
  filters: Filter[] = [];
  selectedFilter: string = '';
  onSelected: (id: string) => void = (id: string): void => {};

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Filter Shop')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(AppTypographyTokens.displayWeight)
        .fontColor(AppColors.onBackground)

      Row({ space: AppSpacing.sm }) {
        ForEach(
          this.filters,
          (filter: Filter) => {
            Text(filter.name)
              .fontSize(AppTypographyTokens.labelSize)
              .fontWeight(AppTypographyTokens.labelWeight)
              .letterSpacing(0.5)
              .fontColor(filter.id === this.selectedFilter ? AppColors.onPrimary : AppColors.onBackground)
              .padding({
                left: AppSpacing.md,
                right: AppSpacing.md,
                top: AppSpacing.sm,
                bottom: AppSpacing.sm
              })
              .backgroundColor(filter.id === this.selectedFilter ? AppColors.primary : AppColors.surface)
              .borderRadius(AppShapes.large)
              .border({
                width: 2,
                color: filter.id === this.selectedFilter ? AppColors.onBackground10 : AppColors.outline
              })
              .onClick(() => {
                this.onSelected(filter.id);
              })
          },
          (filter: Filter): string => filter.id
        )
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct FilterCard {
  item: FilterItem = {
    id: 0,
    name: '',
    author: '',
    price: '',
    color: AppColors.surface
  };

  build() {
    Column() {
      Blank()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppShapes.medium)

      Column({ space: AppSpacing.sm }) {
        Text(this.item.name)
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight('700')
          .fontColor(AppColors.onSurface)

        Text(this.item.author)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .letterSpacing(0.5)
          .fontColor(AppColors.onSurface60)

        Text(this.item.price)
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight('700')
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.sm)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevationMapping.level1.blurRadius,
      color: AppElevationMapping.level1.color,
      offsetX: AppElevationMapping.level1.offsetX,
      offsetY: AppElevationMapping.level1.offsetY
    })
  }
}

@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .lineHeight(20)
        .fontColor(AppColors.onSurface)

      Blank()
        .layoutWeight(1)

      Row({ space: AppSpacing.sm }) {
        Blank()
          .width(16)
          .height(16)
          .backgroundColor(AppColors.onPrimary20)
          .borderRadius(AppShapes.circle)

        Text('Checkout')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.onPrimary)
      }
      .padding({
        left: 24,
        right: 24,
        top: 8,
        bottom: 8
      })
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: AppElevationMapping.level1.blurRadius,
        color: AppElevationMapping.level1.color,
        offsetX: AppElevationMapping.level1.offsetX,
        offsetY: AppElevationMapping.level1.offsetY
      })
      .onClick(() => {
        console.info('Checkout tapped');
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage';

  filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];

  items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: AppColors.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: AppColors.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: AppColors.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: AppColors.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: AppColors.warning },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppColors.outline }
  ];

  async aboutToAppear(): Promise<void> {
    try {
      const context = getContext(this);
      const win = await window.getLastWindow(context);
      await win.setWindowSystemBarEnable(['navigation']);
    } catch (err) {
    }
  }

  build() {
    Column() {
      Column() {
        TopBarSection({
          filters: this.filters,
          selectedFilter: this.selectedFilter,
          onSelected: (id: string): void => {
            this.selectedFilter = id;
          }
        })
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .backgroundColor(AppColors.background)

      Grid() {
        ForEach(
          this.items,
          (item: FilterItem) => {
            GridItem() {
              FilterCard({ item: item })
            }
          },
          (item: FilterItem): string => item.id.toString()
        )
      }
      .width('100%')
      .layoutWeight(1)
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.md)
      .rowsGap(AppSpacing.md)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)

      Column() {
        BottomBarSection()
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevationMapping.level2.blurRadius,
        color: AppElevationMapping.level2.color,
        offsetX: AppElevationMapping.level2.offsetX,
        offsetY: AppElevationMapping.level2.offsetY
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}