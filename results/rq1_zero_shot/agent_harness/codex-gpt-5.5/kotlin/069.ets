const NAME: string = "131*SupplyHub*en";
const UI_TYPE: string = "Grid";
const STYLE_THEME: string = "Muted Earth";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const COLOR_PALETTE: string = "primary:#8B6B4C secondary:#C27D38 tertiary:#F2C57C background:#100C08 surface:#19110D surfaceVariant:#2A1C14 outline:#4F3A2C success:#6ECE89 warning:#E19F41 error:#D96666 onPrimary:#100C08 onSecondary:#100C08 onTertiary:#120E04 onBackground:#F7EAD8 onSurface:#FBEFE0";
const DENSITY_SPACING: string = "Medium";
const COMPLEXITY: string = "Grid,Image,LazyList";
const EXTRA: string = "Muted earth cargo grid with image placeholders";

class AppColors {
  static readonly primary: string = '#8B6B4C';
  static readonly secondary: string = '#C27D38';
  static readonly tertiary: string = '#F2C57C';
  static readonly background: string = '#100C08';
  static readonly surface: string = '#19110D';
  static readonly surfaceVariant: string = '#2A1C14';
  static readonly success: string = '#6ECE89';
  static readonly warning: string = '#E19F41';
  static readonly onPrimary: string = '#100C08';
  static readonly onSecondary: string = '#100C08';
  static readonly onSurface: string = '#FBEFE0';
}

class AppSpacing {
  static readonly xxs: number = 6;
  static readonly xs: number = 10;
  static readonly sm: number = 14;
  static readonly md: number = 18;
  static readonly lg: number = 26;
  static readonly xl: number = 36;
}

class CargoCard {
  title: string;
  id: string;
  fill: string;

  constructor(title: string, id: string, fill: string) {
    this.title = title;
    this.id = id;
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

@Entry
@Component
struct MainActivity {
  @State activeFilter: string = 'All';

  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland'];
  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ];
  private manifest: ManifestEntry[] = [
    new ManifestEntry('Santiago', 'Lima', 'Boarding'),
    new ManifestEntry('Mecca', 'Algiers', 'At dock'),
    new ManifestEntry('Reykjavík', 'Oslo', 'Delayed'),
    new ManifestEntry('Perth', 'Jakarta', 'In flight')
  ];

  private statusColor(status: string): string {
    if (status === 'Delayed') {
      return AppColors.warning;
    }
    if (status === 'In flight') {
      return AppColors.success;
    }
    return AppColors.onSurface;
  }

  @Builder
  TopBar() {
    Row() {
      Blank().width(26).height(26).backgroundColor(AppColors.surfaceVariant).borderRadius(13)
      Column() {
        Text('SupplyHub')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Logistics grid')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      Blank().width(26).height(26).backgroundColor(AppColors.surfaceVariant).borderRadius(13)
    }
    .width('100%')
    .height(68)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F219110D')
  }

  @Builder
  FilterButton(label: string) {
    Button(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
      .height(34)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
      .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(10)
      .onClick(() => {
        this.activeFilter = label;
      })
  }

  @Builder
  CargoTile(card: CargoCard) {
    Column({ space: AppSpacing.sm }) {
      Stack({ alignContent: Alignment.Center }) {
        Blank()
          .width('100%')
          .height(90)
          .backgroundColor(AppColors.surface)
          .borderRadius(10)
        Circle()
          .width(60)
          .height(60)
          .fill('#66F2C57C')
      }
      .width('100%')
      .height(90)

      Column({ space: AppSpacing.xxs }) {
        Text(card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(card.id)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
        Text(`Fill ${card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.success)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor('#EB2A1C14')
    .borderRadius(18)
  }

  @Builder
  ManifestRow(entry: ManifestEntry) {
    Row() {
      Column({ space: AppSpacing.xxs }) {
        Text(`${entry.origin} → ${entry.destination}`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(entry.status)
          .fontSize(14)
          .fontColor(this.statusColor(entry.status))
          .opacity(entry.status === 'Delayed' || entry.status === 'In flight' ? 1 : 0.8)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Details')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .height(36)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        .backgroundColor(AppColors.secondary)
        .borderRadius(10)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#D92A1C14')
    .borderRadius(18)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xxs }) {
        Text('Manifest filter')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.activeFilter)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Button('Dispatch')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .height(42)
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
        .backgroundColor(AppColors.primary)
        .borderRadius(18)
    }
    .width('100%')
    .height(78)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 12, color: '#42000000', offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Row({ space: AppSpacing.xs }) {
            ForEach(this.filters, (filter: string) => {
              this.FilterButton(filter)
            })
          }
          .width('100%')

          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
            .width('100%')

          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                this.CargoTile(card)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.sm)
          .rowsGap(AppSpacing.sm)
          .height(640)
          .width('100%')

          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
            .width('100%')

          ForEach(this.manifest, (entry: ManifestEntry) => {
            this.ManifestRow(entry)
          })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
