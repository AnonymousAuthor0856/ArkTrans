const AppColors = {
  primary: '#8B6B4C',
  secondary: '#C27D38',
  tertiary: '#F2C57C',
  background: '#100C08',
  surface: '#19110D',
  surfaceVariant: '#2A1C14',
  outline: '#4F3A2C',
  success: '#6ECE89',
  warning: '#E19F41',
  error: '#D96666',
  onPrimary: '#100C08',
  onSecondary: '#100C08',
  onTertiary: '#120E04',
  onBackground: '#F7EAD8',
  onSurface: '#FBEFE0',
  onSurfaceAlpha70: '#B3FBEFE0',
  onSurfaceAlpha80: '#CCFBEFE0',
  surfaceAlpha95: '#F219110D',
  surfaceVariantAlpha92: '#EB2A1C14',
  surfaceVariantAlpha85: '#D92A1C14',
  tertiaryAlpha40: '#66F2C57C',
}

const AppSpacing = {
  xxs: 6,
  xs: 10,
  sm: 14,
  md: 18,
  lg: 26,
  xl: 36,
  xxl: 48,
  xxxl: 62,
}

const AppShapes = {
  small: 10,
  medium: 18,
  large: 26,
}

class CargoCard {
  title: string = ''
  id: string = ''
  fill: string = ''
  constructor(title: string, id: string, fill: string) {
    this.title = title
    this.id = id
    this.fill = fill
  }
}

class ManifestEntry {
  origin: string = ''
  destination: string = ''
  status: string = ''
  constructor(origin: string, destination: string, status: string) {
    this.origin = origin
    this.destination = destination
    this.status = status
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
    new CargoCard('Raw silica', 'SH-063', '43%'),
  ]
  private manifest: ManifestEntry[] = [
    new ManifestEntry('Santiago', 'Lima', 'Boarding'),
    new ManifestEntry('Mecca', 'Algiers', 'At dock'),
    new ManifestEntry('Reykjavík', 'Oslo', 'Delayed'),
    new ManifestEntry('Perth', 'Jakarta', 'In flight'),
  ]
  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']

  getStatusColor(status: string): string {
    if (status === 'Delayed') return AppColors.warning
    if (status === 'In flight') return AppColors.success
    return AppColors.onSurfaceAlpha80
  }

  @Builder
  FilterButtonBuilder(filter: string) {
    Button(filter) {
      Text(filter)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.activeFilter === filter ? AppColors.onSecondary : AppColors.onSurface)
    }
      .type(ButtonType.Normal)
      .backgroundColor(this.activeFilter === filter ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xxs, bottom: AppSpacing.xxs })
      .height(36)
      .onClick(() => {
        this.activeFilter = filter
      })
  }

  @Builder
  CargoCardBuilder(card: CargoCard) {
    Column() {
      Column() {
        Column() {}
          .width(60)
          .height(60)
          .backgroundColor(AppColors.tertiaryAlpha40)
          .borderRadius(30)
      }
      .width('100%')
      .height(90)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.small)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column() {
        Text(card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(card.id)
          .fontSize(14)
          .fontColor(AppColors.onSurfaceAlpha70)
          .margin({ top: AppSpacing.xxs })
        Text(`Fill ${card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.success)
          .margin({ top: AppSpacing.xxs })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: AppSpacing.sm })
    }
    .backgroundColor(AppColors.surfaceVariantAlpha92)
    .borderRadius(AppShapes.medium)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ManifestRowBuilder(entry: ManifestEntry) {
    Row() {
      Column() {
        Text(`${entry.origin} → ${entry.destination}`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(entry.status)
          .fontSize(14)
          .fontColor(this.getStatusColor(entry.status))
          .margin({ top: AppSpacing.xxs })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Details') {
        Text('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
      }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.small)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .height(36)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariantAlpha85)
    .borderRadius(AppShapes.medium)
  }

  build() {
    Column() {
      Row() {
        Column() {}
          .width(26)
          .height(26)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(13)

        Column() {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurfaceAlpha70)
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {}
          .width(26)
          .height(26)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(13)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surfaceAlpha95)

      List({ space: AppSpacing.lg }) {
        ListItem() {
          Row() {
            ForEach(this.filters, (filter: string) => {
              this.FilterButtonBuilder(filter)
            }, (filter: string) => filter)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }

        ListItem() {
          Text('Cargo grid')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
        }

        ListItem() {
          Grid() {
            ForEach(this.cards, (card: CargoCard) => {
              GridItem() {
                this.CargoCardBuilder(card)
              }
            }, (card: CargoCard) => card.id)
          }
          .columnsTemplate('1fr 1fr')
          .height(320)
          .columnsGap(AppSpacing.sm)
          .rowsGap(AppSpacing.sm)
        }

        ListItem() {
          Text('Route manifest')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)
        }

        ForEach(this.manifest, (entry: ManifestEntry) => {
          ListItem() {
            this.ManifestRowBuilder(entry)
          }
        }, (entry: ManifestEntry) => `${entry.origin}_${entry.destination}`)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })

      Row() {
        Column() {
          Text('Manifest filter')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(this.activeFilter)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .margin({ top: AppSpacing.xxs })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Dispatch') {
          Text('Dispatch')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.xs, bottom: AppSpacing.xs })
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}