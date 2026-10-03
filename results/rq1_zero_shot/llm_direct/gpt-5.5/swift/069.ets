class CargoCard {
  id: string
  title: string
  itemId: string
  fill: string

  constructor(title: string, itemId: string, fill: string) {
    this.id = `${title}-${itemId}`
    this.title = title
    this.itemId = itemId
    this.fill = fill
  }
}

class HubFilter {
  id: string
  label: string

  constructor(label: string) {
    this.id = label
    this.label = label
  }
}

class DesignTokens {
  static Colors = {
    primary: '#8B6B4C',
    secondary: '#C27D38',
    tertiary: '#F2C57C',
    tertiary40: '#66F2C57C',
    background: '#100C08',
    surface: '#19110D',
    surface95: '#F219110D',
    surfaceVariant: '#2A1C14',
    surfaceVariant85: '#D92A1C14',
    surfaceVariant92: '#EB2A1C14',
    outline: '#4F3A2C',
    success: '#6ECE89',
    warning: '#E19F41',
    error: '#D96666',
    onPrimary: '#100C08',
    onSecondary: '#100C08',
    onTertiary: '#120E04',
    onBackground: '#F7EAD8',
    onSurface: '#FBEFE0',
    onSurface70: '#B3FBEFE0'
  }

  static Spacing = {
    xxs: 6,
    xs: 10,
    sm: 14,
    md: 18,
    lg: 26,
    xl: 36,
    xxl: 48,
    xxxl: 62
  }

  static CornerRadius = {
    small: 10,
    medium: 18,
    large: 26
  }
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Circle()
          .fill(DesignTokens.Colors.surfaceVariant)
          .width(26)
          .height(26)

        Blank()

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)

          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface70)
        }

        Blank()

        Circle()
          .fill(DesignTokens.Colors.surfaceVariant)
          .width(26)
          .height(26)
      }
      .width('100%')
      .height('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor(DesignTokens.Colors.surface95)
  }
}

@Component
struct FilterButtons {
  @Link activeFilter: string
  filters: HubFilter[] = []

  build() {
    Scroll() {
      Row({ space: DesignTokens.Spacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Button() {
            Text(filter.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
              .padding({
                left: DesignTokens.Spacing.sm,
                right: DesignTokens.Spacing.sm,
                top: DesignTokens.Spacing.xxs,
                bottom: DesignTokens.Spacing.xxs
              })
          }
          .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
          .borderRadius(DesignTokens.CornerRadius.small)
          .onClick(() => {
            this.activeFilter = filter.label
          })
        }, (filter: HubFilter) => filter.id)
      }
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg
      })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }
}

@Component
struct CargoCardView {
  card: CargoCard = new CargoCard('', '', '')

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      Stack() {
        Circle()
          .fill(DesignTokens.Colors.tertiary40)
          .width(60)
          .height(60)
      }
      .width('100%')
      .height(90)
      .backgroundColor(DesignTokens.Colors.surface)
      .borderRadius(DesignTokens.CornerRadius.small)

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)

        Text(this.card.itemId)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(DesignTokens.Colors.onSurface70)

        Text(`Fill ${this.card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.success)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant92)
    .borderRadius(DesignTokens.CornerRadius.medium)
  }
}

@Entry
@Component
struct ContentView {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ]

  private filters: HubFilter[] = [
    new HubFilter('All'),
    new HubFilter('Atlantic'),
    new HubFilter('Pacific'),
    new HubFilter('Inland')
  ]

  build() {
    Stack() {
      Column() {
        TopAppBar()

        Scroll() {
          Column({ space: DesignTokens.Spacing.lg }) {
            FilterButtons({
              activeFilter: $activeFilter,
              filters: this.filters
            })

            Text('Cargo grid')
              .width('100%')
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(DesignTokens.Colors.onSurface)
              .padding({
                left: DesignTokens.Spacing.lg,
                right: DesignTokens.Spacing.lg
              })

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  CargoCardView({ card: card })
                }
              }, (card: CargoCard) => card.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(DesignTokens.Spacing.sm)
            .rowsGap(DesignTokens.Spacing.sm)
            .width('100%')
            .padding({
              left: DesignTokens.Spacing.lg,
              right: DesignTokens.Spacing.lg
            })

            Column({ space: DesignTokens.Spacing.xs }) {
              Text('Manifest filter')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface70)

              Text(this.activeFilter)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({
              left: DesignTokens.Spacing.lg,
              right: DesignTokens.Spacing.lg,
              top: DesignTokens.Spacing.md,
              bottom: DesignTokens.Spacing.md
            })
            .backgroundColor(DesignTokens.Colors.surfaceVariant85)
            .borderRadius(DesignTokens.CornerRadius.medium)
            .margin({
              left: DesignTokens.Spacing.lg,
              right: DesignTokens.Spacing.lg
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({
            top: DesignTokens.Spacing.md,
            bottom: DesignTokens.Spacing.md
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(DesignTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}