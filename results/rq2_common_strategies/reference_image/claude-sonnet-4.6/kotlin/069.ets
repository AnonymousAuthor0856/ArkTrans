/**
 * SupplyHub · Logistics grid
 * ArkTS / ArkUI conversion of the Kotlin Compose reference.
 * Stage model · API 11+
 * NAME        : 131*SupplyHub*en
 * UI_TYPE     : Grid
 * STYLE_THEME : Muted Earth
 * BASELINE    : 720x1280
 */

const NAME: string = '131*SupplyHub*en';
const UI_TYPE: string = 'Grid';
const STYLE_THEME: string = 'Muted Earth';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';
const DENSITY_SPACING: string = 'Medium';
const COMPLEXITY: string = 'Grid,Image,LazyList';
const EXTRA: string = 'Muted earth cargo grid with image placeholders';

/* ------------------------------------------------------------------ */
/* Design tokens                                                       */
/* ------------------------------------------------------------------ */

class DesignTokens {
  /* ---- colors: primary:#8B6B4C secondary:#C27D38 tertiary:#F2C57C ---- */
  static readonly primary: string = '#8B6B4C';
  static readonly secondary: string = '#C27D38';
  static readonly tertiary: string = '#F2C57C';
  static readonly background: string = '#100C08';
  static readonly surface: string = '#19110D';
  static readonly surfaceVariant: string = '#2A1C14';
  static readonly outline: string = '#4F3A2C';
  static readonly success: string = '#6ECE89';
  static readonly warning: string = '#E19F41';
  static readonly error: string = '#D96666';
  static readonly onPrimary: string = '#100C08';
  static readonly onSecondary: string = '#100C08';
  static readonly onTertiary: string = '#120E04';
  static readonly onBackground: string = '#F7EAD8';
  static readonly onSurface: string = '#FBEFE0';

  /* ---- alpha composites (tokens applied over the muted-earth base) ---- */
  static readonly surfaceHeavy: string = '#F219110D';   // surface          @ 95%
  static readonly cardFill: string = '#EB2A1C14';       // surfaceVariant   @ 92%
  static readonly rowFill: string = '#D92A1C14';        // surfaceVariant   @ 85%
  static readonly imageWell: string = '#19110D';        // surface (placeholder well)
  static readonly imageDot: string = '#66F2C57C';       // tertiary         @ 40%
  static readonly textMuted: string = '#B3FBEFE0';      // onSurface        @ 70%
  static readonly textBody: string = '#CCFBEFE0';       // onSurface        @ 80%

  /* ---- spacing scale ---- */
  static readonly xxs: number = 6;
  static readonly xs: number = 10;
  static readonly sm: number = 14;
  static readonly md: number = 18;
  static readonly lg: number = 26;
  static readonly xl: number = 36;
  static readonly xxl: number = 48;

  /* ---- shape scale ---- */
  static readonly radiusSmall: number = 10;
  static readonly radiusMedium: number = 18;
  static readonly radiusLarge: number = 26;
  static readonly radiusCircle: number = 999;

  /* ---- component metrics ---- */
  static readonly topBarHeight: number = 64;
  static readonly chipHeight: number = 36;
  static readonly primaryButtonHeight: number = 46;
  static readonly primaryButtonWidth: number = 150;
  static readonly smallButtonHeight: number = 34;
  static readonly smallButtonWidth: number = 84;
  static readonly avatarSize: number = 26;
  static readonly gridHeight: number = 320;
  static readonly wellHeight: number = 90;
  static readonly wellDot: number = 60;
}

/* ------------------------------------------------------------------ */
/* Model                                                               */
/* ------------------------------------------------------------------ */

class CargoCard {
  title: string;
  code: string;
  fill: string;

  constructor(title: string, code: string, fill: string) {
    this.title = title;
    this.code = code;
    this.fill = fill;
  }
}

class ManifestEntry {
  origin: string;
  destination: string;
  status: string;

  constructor(origin: string, destination: string, status: string) {
    this.origin = origin;
    this.destination = destination;
    this.status = status;
  }
}

/* ------------------------------------------------------------------ */
/* Screen                                                              */
/* ------------------------------------------------------------------ */

@Entry
@Component
struct SupplyHub {
  @State activeFilter: string = 'All';

  private readonly filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland'];

  private readonly cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ];

  private readonly manifest: ManifestEntry[] = [
    new ManifestEntry('Santiago', 'Lima', 'Boarding'),
    new ManifestEntry('Mecca', 'Algiers', 'At dock'),
    new ManifestEntry('Reykjavík', 'Oslo', 'Delayed'),
    new ManifestEntry('Perth', 'Jakarta', 'In flight')
  ];

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return DesignTokens.warning;
    }
    if (status === 'In flight') {
      return DesignTokens.success;
    }
    return DesignTokens.textBody;
  }

  /* ---------------------------------------------------------------- */
  /* Scaffold chrome                                                   */
  /* ---------------------------------------------------------------- */

  @Builder
  TopBar() {
    Stack() {
      /* Centre-aligned title block */
      Column({ space: 2 }) {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(500)
          .lineHeight(22)
          .letterSpacing(0.2)
          .fontColor(DesignTokens.onSurface)
        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .letterSpacing(0.3)
          .fontColor(DesignTokens.textMuted)
      }

      /* Leading / trailing icon slots */
      Row() {
        Stack() {
          Circle({ width: DesignTokens.avatarSize, height: DesignTokens.avatarSize })
            .fill(DesignTokens.surfaceVariant)
        }
        .onClick(() => {
        })

        Stack() {
          Circle({ width: DesignTokens.avatarSize, height: DesignTokens.avatarSize })
            .fill(DesignTokens.surfaceVariant)
        }
        .onClick(() => {
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height(DesignTokens.topBarHeight)
    .padding({ left: DesignTokens.md, right: DesignTokens.md })
    .backgroundColor(DesignTokens.surfaceHeavy)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: DesignTokens.xxs }) {
        Text('Manifest filter')
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .letterSpacing(0.3)
          .fontColor(DesignTokens.onSurface)
        Text(this.activeFilter)
          .fontSize(16)
          .fontWeight(500)
          .lineHeight(22)
          .letterSpacing(0.2)
          .fontColor(DesignTokens.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Dispatch', { type: ButtonType.Normal, stateEffect: true })
        .width(DesignTokens.primaryButtonWidth)
        .height(DesignTokens.primaryButtonHeight)
        .borderRadius(DesignTokens.radiusMedium)
        .backgroundColor(DesignTokens.primary)
        .fontColor(DesignTokens.onPrimary)
        .fontSize(16)
        .fontWeight(500)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding({
      left: DesignTokens.lg,
      right: DesignTokens.lg,
      top: DesignTokens.md,
      bottom: DesignTokens.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(DesignTokens.surface)
    .shadow({ radius: 12, color: '#44000000', offsetX: 0, offsetY: 6 })
  }

  /* ---------------------------------------------------------------- */
  /* Leaf components                                                   */
  /* ---------------------------------------------------------------- */

  @Builder
  FilterChip(label: string) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .height(DesignTokens.chipHeight)
      .borderRadius(DesignTokens.radiusSmall)
      .backgroundColor(this.activeFilter === label ? DesignTokens.secondary : DesignTokens.surfaceVariant)
      .fontColor(this.activeFilter === label ? DesignTokens.onSecondary : DesignTokens.onSurface)
      .fontSize(12)
      .fontWeight(500)
      .padding({ left: DesignTokens.sm, right: DesignTokens.sm })
      .onClick(() => {
        this.activeFilter = label;
      })
  }

  @Builder
  CargoTile(card: CargoCard) {
    Column({ space: DesignTokens.sm }) {
      /* Image placeholder well */
      Stack() {
        Circle({ width: DesignTokens.wellDot, height: DesignTokens.wellDot })
          .fill(DesignTokens.imageDot)
      }
      .width('100%')
      .height(DesignTokens.wellHeight)
      .borderRadius(DesignTokens.radiusSmall)
      .backgroundColor(DesignTokens.imageWell)

      Column({ space: DesignTokens.xxs }) {
        Text(card.title)
          .fontSize(16)
          .fontWeight(500)
          .lineHeight(22)
          .letterSpacing(0.2)
          .fontColor(DesignTokens.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(card.code)
          .fontSize(14)
          .fontWeight(400)
          .lineHeight(20)
          .letterSpacing(0.2)
          .fontColor(DesignTokens.textMuted)
        Text(`Fill ${card.fill}`)
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .letterSpacing(0.3)
          .fontColor(DesignTokens.success)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(DesignTokens.md)
    .backgroundColor(DesignTokens.cardFill)
    .borderRadius(DesignTokens.radiusMedium)
  }

  @Builder
  ManifestRow(entry: ManifestEntry) {
    Row() {
      Column({ space: DesignTokens.xxs }) {
        Text(`${entry.origin} → ${entry.destination}`)
          .fontSize(16)
          .fontWeight(500)
          .lineHeight(22)
          .letterSpacing(0.2)
          .fontColor(DesignTokens.onSurface)
        Text(entry.status)
          .fontSize(14)
          .fontWeight(400)
          .lineHeight(20)
          .letterSpacing(0.2)
          .fontColor(this.statusColor(entry.status))
      }
      .alignItems(HorizontalAlign.Start)

      Button('Details', { type: ButtonType.Normal, stateEffect: true })
        .width(DesignTokens.smallButtonWidth)
        .height(DesignTokens.smallButtonHeight)
        .borderRadius(DesignTokens.radiusSmall)
        .backgroundColor(DesignTokens.secondary)
        .fontColor(DesignTokens.onSecondary)
        .fontSize(12)
        .fontWeight(500)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(DesignTokens.md)
    .borderRadius(DesignTokens.radiusMedium)
    .backgroundColor(DesignTokens.rowFill)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SectionHeading(title: string) {
    Text(title)
      .fontSize(22)
      .fontWeight(600)
      .lineHeight(28)
      .letterSpacing(0.1)
      .fontColor(DesignTokens.onSurface)
  }

  /* ---------------------------------------------------------------- */
  /* Root                                                              */
  /* ---------------------------------------------------------------- */

  build() {
    Column() {
      this.TopBar()

      List({ space: DesignTokens.lg }) {
        ListItem() {
          Row({ space: DesignTokens.xs }) {
            ForEach(this.filters, (label: string) => {
              this.FilterChip(label)
            }, (label: string) => label)
          }
          .width('100%')
        }

        ListItem() {
          this.SectionHeading('Cargo grid')
        }

        ListItem() {
          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                this.CargoTile(card)
              }
            }, (card: CargoCard) => card.code)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(DesignTokens.sm)
          .rowsGap(DesignTokens.sm)
          .width('100%')
          .height(DesignTokens.gridHeight)
        }

        ListItem() {
          this.SectionHeading('Route manifest')
        }

        ForEach(this.manifest, (entry: ManifestEntry) => {
          ListItem() {
            this.ManifestRow(entry)
          }
        }, (entry: ManifestEntry) => `${entry.origin}-${entry.destination}`)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .padding({
        left: DesignTokens.lg,
        right: DesignTokens.lg,
        top: DesignTokens.md,
        bottom: DesignTokens.md
      })

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.background)
  }
}