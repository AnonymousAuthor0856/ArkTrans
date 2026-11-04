class DesignColors {
  static primary: string = '#8B6B4C'
  static secondary: string = '#C27D38'
  static tertiary: string = '#F2C57C'
  static background: string = '#100C08'
  static surface: string = '#19110D'
  static surfaceVariant: string = '#2A1C14'
  static outline: string = '#4F3A2C'
  static success: string = '#6ECE89'
  static warning: string = '#E19F41'
  static error: string = '#D96666'
  static onPrimary: string = '#100C08'
  static onSecondary: string = '#100C08'
  static onTertiary: string = '#120E04'
  static onBackground: string = '#F7EAD8'
  static onSurface: string = '#FBEFE0'
}

class DesignSpacing {
  static xxs: number = 6
  static xs: number = 10
  static sm: number = 14
  static md: number = 18
  static lg: number = 26
  static xl: number = 36
  static xxl: number = 48
  static xxxl: number = 62
}

class DesignRadius {
  static small: number = 10
  static medium: number = 18
  static large: number = 26
}

class CargoCardData {
  title: string
  itemId: string
  fill: string

  constructor(title: string, itemId: string, fill: string) {
    this.title = title
    this.itemId = itemId
    this.fill = fill
  }
}

class HubFilter {
  label: string

  constructor(label: string) {
    this.label = label
  }
}

@Entry
@Component
struct Index {
  @State activeFilter: string = 'All'

  private cards: CargoCardData[] = [
    new CargoCardData('Copper stack', 'SH-014', '78%'),
    new CargoCardData('Fiber reels', 'SH-022', '64%'),
    new CargoCardData('Agro crates', 'SH-031', '92%'),
    new CargoCardData('Glass kits', 'SH-045', '51%'),
    new CargoCardData('Steel mesh', 'SH-057', '88%'),
    new CargoCardData('Raw silica', 'SH-063', '43%')
  ]

  private filters: HubFilter[] = [
    new HubFilter('All'),
    new HubFilter('Atlantic'),
    new HubFilter('Pacific'),
    new HubFilter('Inland')
  ]

  @Builder
  TopAppBar() {
    Stack() {
      Row() {
        Circle()
          .width(26)
          .height(26)
          .fill(DesignColors.surfaceVariant)

        Blank()
          .layoutWeight(1)

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignColors.onSurface)
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3FBEFE0')
        }
        .alignItems(HorizontalAlign.Center)

        Blank()
          .layoutWeight(1)

        Circle()
          .width(26)
          .height(26)
          .fill(DesignColors.surfaceVariant)
      }
      .width('100%')
      .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg, top: DesignSpacing.md, bottom: DesignSpacing.md })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor('#F219110D')
  }

  @Builder
  FilterButton(filter: HubFilter) {
    Text(filter.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === filter.label ? DesignColors.onSecondary : DesignColors.onSurface)
      .padding({ left: DesignSpacing.sm, right: DesignSpacing.sm, top: DesignSpacing.xxs, bottom: DesignSpacing.xxs })
      .backgroundColor(this.activeFilter === filter.label ? DesignColors.secondary : DesignColors.surfaceVariant)
      .borderRadius(DesignRadius.small)
      .onClick(() => {
        this.activeFilter = filter.label
      })
  }

  @Builder
  FilterButtons() {
    Scroll() {
      Row({ space: DesignSpacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          this.FilterButton(filter)
        })
      }
      .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  CargoCardView(card: CargoCardData) {
    Column({ space: DesignSpacing.sm }) {
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill('#66F2C57C')
      }
      .width('100%')
      .height(90)
      .backgroundColor(DesignColors.surface)
      .borderRadius(DesignRadius.small)

      Column({ space: DesignSpacing.xxs }) {
        Text(card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.onSurface)
        Text(card.itemId)
          .fontSize(14)
          .fontColor('#B3FBEFE0')
        Text('Fill ' + card.fill)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.success)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .padding(DesignSpacing.md)
    .backgroundColor('#EB2A1C14')
    .borderRadius(DesignRadius.medium)
  }

  @Builder
  ManifestFilter() {
    Column({ space: DesignSpacing.xs }) {
      Text('Manifest filter')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3FBEFE0')
      Text(this.activeFilter)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignColors.onSurface)
    }
    .width('100%')
    .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg, top: DesignSpacing.md, bottom: DesignSpacing.md })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#D92A1C14')
    .borderRadius(DesignRadius.medium)
  }

  build() {
    Stack() {
      Column() {
        this.TopAppBar()

        Scroll() {
          Column({ space: DesignSpacing.lg }) {
            this.FilterButtons()

            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignColors.onSurface)
              .width('100%')
              .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })

            Grid() {
              ForEach(this.cards, (card: CargoCardData) => {
                GridItem() {
                  this.CargoCardView(card)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DesignSpacing.sm)
            .rowsGap(DesignSpacing.sm)
            .width('100%')
            .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })

            Column() {
              this.ManifestFilter()
            }
            .width('100%')
            .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })
          }
          .width('100%')
          .padding({ top: DesignSpacing.md, bottom: DesignSpacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignColors.background)
  }
}
