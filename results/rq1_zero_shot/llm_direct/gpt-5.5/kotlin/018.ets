const NAME: string = '018_FilterShop_en'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Clay Morph'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: ResourceColor = '#D7BBA8'
  static readonly secondary: ResourceColor = '#A2C4C9'
  static readonly tertiary: ResourceColor = '#B3C9A2'
  static readonly background: ResourceColor = '#F0EBE3'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E6E0D9'
  static readonly outline: ResourceColor = '#DCD7CF'
  static readonly success: ResourceColor = '#7EA87E'
  static readonly warning: ResourceColor = '#D9B872'
  static readonly error: ResourceColor = '#D98B8B'
  static readonly onPrimary: ResourceColor = '#433E3A'
  static readonly onSecondary: ResourceColor = '#433E3A'
  static readonly onTertiary: ResourceColor = '#433E3A'
  static readonly onBackground: ResourceColor = '#433E3A'
  static readonly onSurface: ResourceColor = '#433E3A'
}

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly headlineSize: number = 22
  static readonly titleSize: number = 16
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 16
  static readonly large: number = 24
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class ShadowSpec {
  elevation: number
  color: ResourceColor
  offsetX: number
  offsetY: number
  blurRadius: number

  constructor(elevation: number, color: ResourceColor, offsetX: number, offsetY: number, blurRadius: number) {
    this.elevation = elevation
    this.color = color
    this.offsetX = offsetX
    this.offsetY = offsetY
    this.blurRadius = blurRadius
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(3, '#0D000000', 4, 4, 8)
  static readonly level2: ShadowSpec = new ShadowSpec(6, '#14000000', 6, 6, 12)
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
  color: ResourceColor

  constructor(id: number, name: string, author: string, price: string, color: ResourceColor) {
    this.id = id
    this.name = name
    this.author = author
    this.price = price
    this.color = color
  }
}

@Component
struct TopBarSection {
  filters: Filter[] = []
  selectedFilter: string = 'vintage'
  onFilterSelected: (id: string) => void = () => {
  }

  build() {
    Column() {
      Text('Filter Shop')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Blank()
        .height(AppSpacing.md)

      Row({ space: AppSpacing.sm }) {
        ForEach(this.filters, (filter: Filter) => {
          Text(filter.name)
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
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
              color: filter.id === this.selectedFilter ? '#1A433E3A' : AppColors.outline
            })
            .onClick(() => {
              this.onFilterSelected(filter.id)
            })
        }, (filter: Filter) => filter.id)
      }
      .width('100%')
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct FilterCard {
  item: FilterItem = new FilterItem(0, '', '', '', AppColors.surface)

  build() {
    Column() {
      Stack()
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppShapes.medium)

      Column() {
        Text(this.item.name)
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Text(this.item.author)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor('#99433E3A')

        Blank()
          .height(AppSpacing.sm)

        Text(this.item.price)
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(FontWeight.Bold)
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
        .fontWeight(FontWeight.Normal)
        .lineHeight(20)
        .fontColor(AppColors.onSurface)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row({ space: AppSpacing.sm }) {
          Circle()
            .width(16)
            .height(16)
            .fill('#33433E3A')

          Text('Checkout')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .alignItems(VerticalAlign.Center)
      }
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.large)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .shadow({
        radius: AppElevationMapping.level1.blurRadius,
        color: AppElevationMapping.level1.color,
        offsetX: AppElevationMapping.level1.offsetX,
        offsetY: AppElevationMapping.level1.offsetY
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevationMapping.level2.blurRadius,
      color: AppElevationMapping.level2.color,
      offsetX: AppElevationMapping.level2.offsetX,
      offsetY: AppElevationMapping.level2.offsetY
    })
  }
}

@Entry
@Component
struct RootScreen {
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
      TopBarSection({
        filters: this.filters,
        selectedFilter: this.selectedFilter,
        onFilterSelected: (id: string) => {
          this.selectedFilter = id
        }
      })

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
      .width('100%')
      .layoutWeight(1)

      BottomBarSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}