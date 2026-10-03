// entry/src/main/ets/pages/Index.ets
const NAME: string = '018_FilterShop_en';
const UI_TYPE: string = 'Media';
const STYLE_THEME: string = 'Clay Morph';
const BASELINE_SIZE: string = '720x1280';

class AppColor {
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
  // alpha pre-mixed variants (ARGB)
  static readonly onSurface60: string = '#99433E3A';
  static readonly primaryAlpha20: string = '#33433E3A';
  static readonly chipBorderSelected: string = '#1A433E3A';
  static readonly shadowLevel1: string = '#0D000000';
  static readonly shadowLevel2: string = '#14000000';
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
  radius: number;
  color: string;
  offsetX: number;
  offsetY: number;

  constructor(radius: number, color: string, offsetX: number, offsetY: number) {
    this.radius = radius;
    this.color = color;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(8, AppColor.shadowLevel1, 4, 4);
  static readonly level2: ShadowSpec = new ShadowSpec(12, AppColor.shadowLevel2, 6, 6);
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

@Entry
@Component
struct Index {
  private filters: Filter[] = [
    { id: 'vintage', name: 'Vintage' },
    { id: 'grain', name: 'Grain' },
    { id: 'b&w', name: 'B&W' },
    { id: 'neon', name: 'Neon' }
  ];

  private items: FilterItem[] = [
    { id: 1, name: 'Redscale', author: 'by UserA', price: '$4.99', color: AppColor.error },
    { id: 2, name: 'Sepia Tone', author: 'by UserB', price: '$2.99', color: AppColor.primary },
    { id: 3, name: 'Aqua', author: 'by UserC', price: '$4.99', color: AppColor.secondary },
    { id: 4, name: 'Forest', author: 'by UserD', price: '$3.99', color: AppColor.tertiary },
    { id: 5, name: 'Golden Hour', author: 'by UserE', price: '$5.99', color: AppColor.warning },
    { id: 6, name: 'Monochrome', author: 'by UserF', price: '$1.99', color: AppColor.outline }
  ];

  @State selectedFilter: string = 'vintage';

  @Builder
  TopBarSection() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColor.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      Row({ space: AppSpacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(filter.id === this.selectedFilter ? AppColor.onPrimary : AppColor.onBackground)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .backgroundColor(filter.id === this.selectedFilter ? AppColor.primary : AppColor.surface)
            .borderRadius(AppRadius.large)
            .border({
              width: 2,
              color: filter.id === this.selectedFilter ? AppColor.chipBorderSelected : AppColor.outline
            })
            .onClick(() => {
              this.selectedFilter = filter.id;
            })
        }, (filter: Filter) => filter.id)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      // cover / swatch
      Row() {
      }
      .width('100%')
      .aspectRatio(1)
      .borderRadius(AppRadius.medium)
      .backgroundColor(item.color)

      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColor.onSurface)
          .lineHeight(20)

        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(AppColor.onSurface60)
          .margin({ top: 2 })

        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColor.primary)
          .margin({ top: AppSpacing.sm })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.sm)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColor.surface)
    .borderRadius(AppRadius.large)
    .clip(true)
    .shadow({
      radius: AppElevation.level1.radius,
      color: AppElevation.level1.color,
      offsetX: AppElevation.level1.offsetX,
      offsetY: AppElevation.level1.offsetY
    })
  }

  @Builder
  BottomBarSection() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .lineHeight(20)
        .fontColor(AppColor.onSurface)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row({ space: AppSpacing.sm }) {
          Row() {
          }
          .width(16)
          .height(16)
          .borderRadius(8)
          .backgroundColor(AppColor.primaryAlpha20)

          Text('Checkout')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColor.onPrimary)
        }
        .alignItems(VerticalAlign.Center)
      }
      .backgroundColor(AppColor.primary)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.sm + 2,
        bottom: AppSpacing.sm + 2
      })
      .borderRadius(AppRadius.large)
      .shadow({
        radius: AppElevation.level1.radius,
        color: AppElevation.level1.color,
        offsetX: AppElevation.level1.offsetX,
        offsetY: AppElevation.level1.offsetY
      })
      .onClick(() => {
        // checkout action
      })
    }
    .width('100%')
    .height(64)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColor.surface)
    .shadow({
      radius: AppElevation.level2.radius,
      color: AppElevation.level2.color,
      offsetX: 0,
      offsetY: -AppElevation.level2.offsetY
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
      .columnsGap(AppSpacing.md)
      .rowsGap(AppSpacing.md)
      .padding(AppSpacing.lg)
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      this.BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColor.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}