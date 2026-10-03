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

  static readonly onSurface60: string = '#99433E3A';
  static readonly onPrimary20: string = '#33433E3A';
  static readonly selectedOutline: string = '#1A433E3A';
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

class ShadowSpec {
  elevation: number;
  color: string;
  offsetX: number;
  offsetY: number;
  blurRadius: number;

  constructor(elevation: number, color: string, offsetX: number, offsetY: number, blurRadius: number) {
    this.elevation = elevation;
    this.color = color;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    this.blurRadius = blurRadius;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(3, '#0D000000', 4, 4, 8);
  static readonly level2: ShadowSpec = new ShadowSpec(6, '#14000000', 6, 6, 12);
}

class FilterModel {
  id: string;
  name: string;

  constructor(id: string, name: string) {
    this.id = id;
    this.name = name;
  }
}

class FilterItemModel {
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

@Component
struct TopBarSection {
  filters: FilterModel[] = [];
  @Link selectedFilter: string;

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Row({ space: AppSpacing.sm }) {
        ForEach(this.filters, (filter: FilterModel) => {
          Text(filter.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(filter.id === this.selectedFilter ? AppColors.onPrimary : AppColors.onBackground)
            .letterSpacing(0.5)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .backgroundColor(filter.id === this.selectedFilter ? AppColors.primary : AppColors.surface)
            .borderRadius(AppRadius.large)
            .border({
              width: 2,
              color: filter.id === this.selectedFilter ? AppColors.selectedOutline : AppColors.outline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: FilterModel) => filter.id)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct FilterCard {
  item: FilterItemModel = new FilterItemModel(0, '', '', '', AppColors.surface);

  build() {
    Column() {
      Row()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppRadius.medium)

      Column({ space: AppSpacing.sm }) {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface60)
          .letterSpacing(0.5)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

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
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: AppElevation.level1.blurRadius,
      color: AppElevation.level1.color,
      offsetX: AppElevation.level1.offsetX,
      offsetY: AppElevation.level1.offsetY
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
        .fontColor(AppColors.onSurface)
        .lineHeight(20)

      Blank()

      Row({ space: AppSpacing.sm }) {
        Row()
          .width(16)
          .height(16)
          .backgroundColor(AppColors.onPrimary20)
          .borderRadius(8)

        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .alignItems(VerticalAlign.Center)
      .padding({
        left: 24,
        right: 24,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .backgroundColor(AppColors.primary)
      .borderRadius(AppRadius.large)
      .shadow({
        radius: AppElevation.level1.blurRadius,
        color: AppElevation.level1.color,
        offsetX: AppElevation.level1.offsetX,
        offsetY: AppElevation.level1.offsetY
      })
      .onClick(() => {
        console.info('Checkout tapped');
      })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
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
struct Index {
  @State selectedFilter: string = 'vintage';

  private readonly filters: FilterModel[] = [
    new FilterModel('vintage', 'Vintage'),
    new FilterModel('grain', 'Grain'),
    new FilterModel('b&w', 'B&W'),
    new FilterModel('neon', 'Neon')
  ];

  private readonly items: FilterItemModel[] = [
    new FilterItemModel(1, 'Redscale', 'by UserA', '$4.99', AppColors.error),
    new FilterItemModel(2, 'Sepia Tone', 'by UserB', '$2.99', AppColors.primary),
    new FilterItemModel(3, 'Aqua', 'by UserC', '$4.99', AppColors.secondary),
    new FilterItemModel(4, 'Forest', 'by UserD', '$3.99', AppColors.tertiary),
    new FilterItemModel(5, 'Golden Hour', 'by UserE', '$5.99', AppColors.warning),
    new FilterItemModel(6, 'Monochrome', 'by UserF', '$1.99', AppColors.outline)
  ];

  build() {
    Column() {
      TopBarSection({
        filters: this.filters,
        selectedFilter: $selectedFilter
      })
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .backgroundColor(AppColors.background)

      Grid() {
        ForEach(this.items, (item: FilterItemModel) => {
          GridItem() {
            FilterCard({ item: item })
          }
        }, (item: FilterItemModel) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.md)
      .rowsGap(AppSpacing.md)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomBarSection()
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: AppElevation.level2.blurRadius,
          color: AppElevation.level2.color,
          offsetX: AppElevation.level2.offsetX,
          offsetY: AppElevation.level2.offsetY
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}