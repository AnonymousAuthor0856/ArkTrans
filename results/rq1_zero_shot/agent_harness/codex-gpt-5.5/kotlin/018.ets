const NAME: string = '018_FilterShop_en';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Clay Morph';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

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
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

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

@Entry
@Component
struct MainActivity {
  @State selectedFilter: string = 'vintage';
  private filters: Filter[] = [new Filter('vintage', 'Vintage'), new Filter('grain', 'Grain'), new Filter('b&w', 'B&W'), new Filter('neon', 'Neon')];
  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', AppColors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', AppColors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', AppColors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', AppColors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', AppColors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', AppColors.outline)
  ];

  @Builder
  TopBar(): void {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground);
      Blank().height(AppSpacing.md);
      Row({ space: AppSpacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(filter.id === this.selectedFilter ? AppColors.onPrimary : AppColors.onBackground)
            .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
            .backgroundColor(filter.id === this.selectedFilter ? AppColors.primary : AppColors.surface)
            .border({ width: 2, color: filter.id === this.selectedFilter ? '#1A433E3A' : AppColors.outline })
            .borderRadius(24)
            .onClick(() => {
              this.selectedFilter = filter.id;
            });
        }, (filter: Filter) => filter.id)
      }
      .width('100%');
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md });
  }

  @Builder
  FilterCard(item: FilterItem): void {
    Column() {
      Rect()
        .width('100%')
        .aspectRatio(1)
        .fill(item.color)
        .radius(16);
      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface);
        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99433E3A');
        Blank().height(AppSpacing.sm);
        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary);
      }
      .padding(AppSpacing.sm)
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#0D000000', offsetX: 4, offsetY: 4 });
  }

  @Builder
  BottomBar(): void {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontColor(AppColors.onSurface);
      Blank();
      Button('Checkout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(24);
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 12, color: '#14000000', offsetY: -4 });
  }

  build() {
    Column() {
      this.TopBar();
      Grid() {
        ForEach(this.items, (item: FilterItem) => {
          GridItem() {
            this.FilterCard(item);
          }
        }, (item: FilterItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.md)
      .rowsGap(AppSpacing.md)
      .layoutWeight(1)
      .padding(AppSpacing.lg);
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
