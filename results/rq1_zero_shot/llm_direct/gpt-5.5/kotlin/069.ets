const NAME: string = '131*SupplyHub*en'
const UI_TYPE: string = 'Grid'
const STYLE_THEME: string = 'Muted Earth'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const COLOR_PALETTE: string =
  'primary:#8B6B4C secondary:#C27D38 tertiary:#F2C57C background:#100C08 surface:#19110D surfaceVariant:#2A1C14 outline:#4F3A2C success:#6ECE89 warning:#E19F41 error:#D96666 onPrimary:#100C08 onSecondary:#100C08 onTertiary:#120E04 onBackground:#F7EAD8 onSurface:#FBEFE0'
const DENSITY_SPACING: string = 'Medium'
const COMPLEXITY: string = 'Grid,Image,LazyList'
const EXTRA: string = 'Muted earth cargo grid with image placeholders'

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class DesignTokens {
  static Colors = class {
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
    static onSurface70: string = 'rgba(251, 239, 224, 0.70)'
    static onSurface80: string = 'rgba(251, 239, 224, 0.80)'
    static surface95: string = 'rgba(25, 17, 13, 0.95)'
    static surfaceVariant85: string = 'rgba(42, 28, 20, 0.85)'
    static surfaceVariant92: string = 'rgba(42, 28, 20, 0.92)'
    static tertiary40: string = 'rgba(242, 197, 124, 0.40)'
  }

  static TypographyTokens = class {
    static displaySize: number = 28
    static headlineSize: number = 22
    static titleSize: number = 16
    static bodySize: number = 14
    static labelSize: number = 12
  }

  static Shapes = class {
    static small: number = 10
    static medium: number = 18
    static large: number = 26
  }

  static Spacing = class {
    static xxs: number = 6
    static xs: number = 10
    static sm: number = 14
    static md: number = 18
    static lg: number = 26
    static xl: number = 36
    static xxl: number = 48
    static xxxl: number = 62
  }

  static ElevationMapping = class {
    static level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.18)
    static level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.22)
    static level3: ShadowSpec = new ShadowSpec(12, 12, 6, 0.26)
    static level4: ShadowSpec = new ShadowSpec(18, 18, 8, 0.30)
    static level5: ShadowSpec = new ShadowSpec(24, 24, 10, 0.34)
  }
}

class CargoCard {
  title: string
  id: string
  fill: string

  constructor(title: string, id: string, fill: string) {
    this.title = title
    this.id = id
    this.fill = fill
  }
}

class ManifestEntry {
  origin: string
  destination: string
  status: string

  constructor(origin: string, destination: string, status: string) {
    this.origin = origin
    this.destination = destination
    this.status = status
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
struct RootScreen {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ]

  private manifest: ManifestEntry[] = [
    new ManifestEntry('Santiago', 'Lima', 'Boarding'),
    new ManifestEntry('Mecca', 'Algiers', 'At dock'),
    new ManifestEntry('Reykjavík', 'Oslo', 'Delayed'),
    new ManifestEntry('Perth', 'Jakarta', 'In flight')
  ]

  private filters: HubFilter[] = [
    new HubFilter('All'),
    new HubFilter('Atlantic'),
    new HubFilter('Pacific'),
    new HubFilter('Inland')
  ]

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return DesignTokens.Colors.warning
    }
    if (status === 'In flight') {
      return DesignTokens.Colors.success
    }
    return DesignTokens.Colors.onSurface80
  }

  @Builder
  TitleText(value: string) {
    Text(value)
      .fontSize(DesignTokens.TypographyTokens.titleSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(DesignTokens.Colors.onSurface)
      .lineHeight(22)
  }

  @Builder
  BodyText(value: string, color: string = DesignTokens.Colors.onSurface) {
    Text(value)
      .fontSize(DesignTokens.TypographyTokens.bodySize)
      .fontWeight(FontWeight.Normal)
      .fontColor(color)
      .lineHeight(20)
  }

  @Builder
  LabelText(value: string, color: string = DesignTokens.Colors.onSurface) {
    Text(value)
      .fontSize(DesignTokens.TypographyTokens.labelSize)
      .fontWeight(FontWeight.Medium)
      .fontColor(color)
      .lineHeight(16)
  }

  @Builder
  HeadlineText(value: string) {
    Text(value)
      .fontSize(DesignTokens.TypographyTokens.headlineSize)
      .fontWeight(FontWeight.SemiBold)
      .fontColor(DesignTokens.Colors.onSurface)
      .lineHeight(28)
  }

  @Builder
  CircleIcon() {
    Stack()
      .width(26)
      .height(26)
      .borderRadius(13)
      .backgroundColor(DesignTokens.Colors.surfaceVariant)
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        this.CircleIcon()
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .padding(0)
      .width(48)
      .height(48)
      .onClick(() => {
      })

      Column() {
        this.TitleText('SupplyHub')
        Text('Logistics grid')
          .fontSize(DesignTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface70)
          .lineHeight(16)
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      Button() {
        this.CircleIcon()
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .padding(0)
      .width(48)
      .height(48)
      .onClick(() => {
      })
    }
    .width('100%')
    .height(64)
    .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(DesignTokens.Colors.surface95)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        this.LabelText('Manifest filter', DesignTokens.Colors.onSurface)
        this.TitleText(this.activeFilter)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('Dispatch')
          .fontSize(DesignTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onPrimary)
          .lineHeight(22)
      }
      .type(ButtonType.Normal)
      .backgroundColor(DesignTokens.Colors.primary)
      .borderRadius(DesignTokens.Shapes.medium)
      .padding({
        left: DesignTokens.Spacing.xl,
        right: DesignTokens.Spacing.xl,
        top: DesignTokens.Spacing.xs,
        bottom: DesignTokens.Spacing.xs
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({
      left: DesignTokens.Spacing.lg,
      right: DesignTokens.Spacing.lg,
      top: DesignTokens.Spacing.md,
      bottom: DesignTokens.Spacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(DesignTokens.Colors.surface)
    .shadow({
      radius: DesignTokens.ElevationMapping.level3.radius,
      color: 'rgba(0, 0, 0, 0.26)',
      offsetX: 0,
      offsetY: DesignTokens.ElevationMapping.level3.dy
    })
  }

  @Builder
  FilterRow() {
    Row({ space: DesignTokens.Spacing.xs }) {
      ForEach(this.filters, (filter: HubFilter) => {
        Button() {
          Text(filter.label)
            .fontSize(DesignTokens.TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === filter.label ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
            .lineHeight(16)
        }
        .type(ButtonType.Normal)
        .backgroundColor(this.activeFilter === filter.label ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
        .borderRadius(DesignTokens.Shapes.small)
        .padding({
          left: DesignTokens.Spacing.sm,
          right: DesignTokens.Spacing.sm,
          top: DesignTokens.Spacing.xxs,
          bottom: DesignTokens.Spacing.xxs
        })
        .onClick(() => {
          this.activeFilter = filter.label
        })
      }, (filter: HubFilter) => filter.label)
    }
    .width('100%')
  }

  @Builder
  CargoGrid() {
    Grid() {
      ForEach(this.cards, (card: CargoCard) => {
        GridItem() {
          Column({ space: DesignTokens.Spacing.sm }) {
            Stack() {
              Stack()
                .width(60)
                .height(60)
                .borderRadius(30)
                .backgroundColor(DesignTokens.Colors.tertiary40)
            }
            .width('100%')
            .height(90)
            .alignContent(Alignment.Center)
            .backgroundColor(DesignTokens.Colors.surface)
            .borderRadius(DesignTokens.Shapes.small)

            Column({ space: DesignTokens.Spacing.xxs }) {
              this.TitleText(card.title)
              this.BodyText(card.id, DesignTokens.Colors.onSurface70)
              this.LabelText(`Fill ${card.fill}`, DesignTokens.Colors.success)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .width('100%')
          .padding(DesignTokens.Spacing.md)
          .backgroundColor(DesignTokens.Colors.surfaceVariant92)
          .borderRadius(DesignTokens.Shapes.medium)
          .alignItems(HorizontalAlign.Start)
        }
      }, (card: CargoCard) => card.id)
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(DesignTokens.Spacing.sm)
    .rowsGap(DesignTokens.Spacing.sm)
    .height(320)
    .width('100%')
    .padding(0)
    .scrollBar(BarState.Off)
  }

  @Builder
  ManifestRow(entry: ManifestEntry) {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        this.TitleText(`${entry.origin} → ${entry.destination}`)
        this.BodyText(entry.status, this.statusColor(entry.status))
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text('Details')
          .fontSize(DesignTokens.TypographyTokens.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .lineHeight(16)
      }
      .type(ButtonType.Normal)
      .backgroundColor(DesignTokens.Colors.secondary)
      .borderRadius(DesignTokens.Shapes.small)
      .padding({
        left: DesignTokens.Spacing.sm,
        right: DesignTokens.Spacing.sm,
        top: DesignTokens.Spacing.xs,
        bottom: DesignTokens.Spacing.xs
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(DesignTokens.Colors.surfaceVariant85)
    .borderRadius(DesignTokens.Shapes.medium)
  }

  build() {
    Column() {
      this.TopBar()

      List({ space: DesignTokens.Spacing.lg }) {
        ListItem() {
          this.FilterRow()
        }

        ListItem() {
          this.HeadlineText('Cargo grid')
        }

        ListItem() {
          this.CargoGrid()
        }

        ListItem() {
          this.HeadlineText('Route manifest')
        }

        ForEach(this.manifest, (entry: ManifestEntry) => {
          ListItem() {
            this.ManifestRow(entry)
          }
        }, (entry: ManifestEntry) => `${entry.origin}-${entry.destination}-${entry.status}`)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
      .scrollBar(BarState.Off)
      .backgroundColor(DesignTokens.Colors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}