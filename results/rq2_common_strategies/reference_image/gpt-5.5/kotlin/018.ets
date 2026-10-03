const NAME: string = '018_FilterShop_en'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Clay Morph'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#D7BBA8'
  static readonly secondary: string = '#A2C4C9'
  static readonly tertiary: string = '#B3C9A2'
  static readonly background: string = '#F0EBE3'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E6E0D9'
  static readonly outline: string = '#DCD7CF'
  static readonly success: string = '#7EA87E'
  static readonly warning: string = '#D9B872'
  static readonly error: string = '#D98B8B'
  static readonly onPrimary: string = '#433E3A'
  static readonly onSecondary: string = '#433E3A'
  static readonly onTertiary: string = '#433E3A'
  static readonly onBackground: string = '#433E3A'
  static readonly onSurface: string = '#433E3A'
  static readonly onSurfaceMuted: string = 'rgba(67, 62, 58, 0.60)'
  static readonly selectedBorder: string = 'rgba(67, 62, 58, 0.10)'
  static readonly buttonDot: string = 'rgba(67, 62, 58, 0.20)'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 16
  static readonly large: number = 24
}

class Filter {
  id: string
  name: string

  constructor(id: string, name: string) {
    this.id = id
    this.name = name
  }
}

class FilterItem {
  id: number
  name: string
  author: string
  price: string
  color: string

  constructor(id: number, name: string, author: string, price: string, color: string) {
    this.id = id
    this.name = name
    this.author = author
    this.price = price
    this.color = color
  }
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'vintage'

  private filters: Filter[] = [
    new Filter('vintage', 'Vintage'),
    new Filter('grain', 'Grain'),
    new Filter('b&w', 'B&W'),
    new Filter('neon', 'Neon')
  ]

  private items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', AppColors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', AppColors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', AppColors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', AppColors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', AppColors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', AppColors.outline)
  ]

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
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      this.BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  TopBarSection() {
    Column() {
      Text('Filter Shop')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .lineHeight(34)

      Blank()
        .height(AppSpacing.md)

      Row() {
        ForEach(this.filters, (filter: Filter) => {
          this.FilterChip(filter)
        }, (filter: Filter) => filter.id)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .gap(AppSpacing.sm)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.lg,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.background)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  FilterChip(filter: Filter) {
    Text(filter.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedFilter === filter.id ? AppColors.onPrimary : AppColors.onBackground)
      .letterSpacing(0.5)
      .padding({
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .backgroundColor(this.selectedFilter === filter.id ? AppColors.primary : AppColors.surface)
      .border({
        width: 2,
        color: this.selectedFilter === filter.id ? AppColors.selectedBorder : AppColors.outline,
        radius: AppRadius.large
      })
      .borderRadius(AppRadius.large)
      .onClick(() => {
        this.selectedFilter = filter.id
      })
  }

  @Builder
  FilterCard(item: FilterItem) {
    Column() {
      Column()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(item.color)
        .borderRadius(AppRadius.medium)

      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(22)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(item.author)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurfaceMuted)
          .letterSpacing(0.5)
          .lineHeight(18)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Blank()
          .height(AppSpacing.sm)

        Text(item.price)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .lineHeight(22)
      }
      .width('100%')
      .padding(AppSpacing.sm)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 2,
      offsetY: 3
    })
  }

  @Builder
  BottomBarSection() {
    Row() {
      Text('3 items in cart')
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .lineHeight(20)

      Row() {
        Circle()
          .width(16)
          .height(16)
          .fill(AppColors.buttonDot)

        Text('Checkout')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
      }
      .height(48)
      .padding({
        left: AppSpacing.xl,
        right: AppSpacing.xl
      })
      .gap(AppSpacing.sm)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppRadius.large)
      .shadow({
        radius: 12,
        color: 'rgba(0, 0, 0, 0.18)',
        offsetX: 4,
        offsetY: 5
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 12,
      color: 'rgba(0, 0, 0, 0.08)',
      offsetX: 0,
      offsetY: -2
    })
  }
}