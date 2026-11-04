class AppColors {
  static primary: string = '#D95F02'
  static secondary: string = '#1B9AAA'
  static tertiary: string = '#FEC601'
  static background: string = '#F9F4EB'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#F0E3D1'
  static outline: string = '#E1CDB2'
  static success: string = '#56C271'
  static warning: string = '#F4A259'
  static error: string = '#D7263D'
  static onPrimary: string = '#1B1B1B'
  static onSecondary: string = '#041012'
  static onTertiary: string = '#1E1200'
  static onBackground: string = '#2C2A29'
  static onSurface: string = '#2E2924'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 20
  static xxl: number = 28
  static xxxl: number = 40
}

class AppShape {
  static small: number = 12
  static medium: number = 16
  static large: number = 20
}

class Zone {
  name: string
  humidity: number
  temp: string

  constructor(name: string, humidity: number, temp: string) {
    this.name = name
    this.humidity = humidity
    this.temp = temp
  }
}

class StatusItem {
  label: string
  value: number
  accent: string

  constructor(label: string, value: number, accent: string) {
    this.label = label
    this.value = value
    this.accent = accent
  }
}

@Entry
@Component
struct Index {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ]
  private statuses: StatusItem[] = [
    new StatusItem('Atmos mix', 0.74, AppColors.secondary),
    new StatusItem('Hull temp', 0.42, AppColors.primary),
    new StatusItem('Shield sync', 0.88, AppColors.tertiary)
  ]

  @Builder
  TopBar() {
    Row() {
      Button('Dock')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor('#00000000')

      Blank()
        .layoutWeight(1)

      Text('Smart Orbit Panel')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Blank()
        .layoutWeight(1)

      Button('Alerts')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor('#00000000')
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ModeChip(mode: string) {
    Text(mode)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.activeMode === mode ? '#26D95F02' : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: AppShape.small })
      .onClick(() => {
        this.activeMode = mode
      })
  }

  @Builder
  ProgressBar(value: number, accent: string, track: string) {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(4)
        .fill(track)
        .radius(2)
      Rect()
        .width((value * 100).toString() + '%')
        .height(4)
        .fill(accent)
        .radius(2)
    }
    .width('100%')
    .height(4)
  }

  @Builder
  StatusRow(item: StatusItem) {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(item.label)
          .fontSize(13)
          .fontColor(AppColors.onSurface)
        Blank()
          .layoutWeight(1)
        Text(Math.floor(item.value * 100).toString() + '%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(item.accent)
      }
      .width('100%')
      this.ProgressBar(item.value, item.accent, AppColors.surface)
    }
    .width('100%')
  }

  @Builder
  ZoneRow(zone: Zone) {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
          .layoutWeight(1)
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      this.ProgressBar(zone.humidity, AppColors.secondary, AppColors.surface)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor('#80F0E3D1')
    .borderRadius(AppShape.small)
  }

  @Builder
  SolarCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Solar wash')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
      Text('Adjust orbital window glow')
        .fontSize(13)
        .fontColor('#B32E2924')

      Slider({ value: this.solarLevel, min: 0, max: 1, step: 0.01 })
        .onChange((value: number) => {
          this.solarLevel = value
        })

      Row() {
        Text('0%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
          .layoutWeight(1)
        Text(Math.floor(this.solarLevel * 100).toString() + '%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Text('Ambient glow')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Slider({ value: this.ambientGlow, min: 0, max: 1, step: 0.01 })
        .onChange((value: number) => {
          this.ambientGlow = value
        })

      this.ProgressBar(this.ambientGlow, AppColors.secondary, AppColors.surfaceVariant)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShape.large)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  @Builder
  HealthCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Orbit health')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
      ForEach(this.statuses, (item: StatusItem) => {
        this.StatusRow(item)
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShape.large)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  @Builder
  ZonesCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Deck zones')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
      ForEach(this.zones, (zone: Zone) => {
        this.ZoneRow(zone)
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShape.large)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Grid draw')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('18.4 kWh')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Engage eco hold')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#29000000', offsetY: -4 })
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.modes, (mode: string) => {
                this.ModeChip(mode)
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)

            this.SolarCard()
            this.HealthCard()
            this.ZonesCard()
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
