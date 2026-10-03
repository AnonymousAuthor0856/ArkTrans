class AppTokens {
  static readonly Colors = {
    primary: '#FFD95F02',
    secondary: '#FF1B9AAA',
    tertiary: '#FFFEC601',
    background: '#FFF9F4EB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF0E3D1',
    outline: '#FFE1CDB2',
    success: '#FF56C271',
    warning: '#FFF4A259',
    error: '#FFD7263D',
    onPrimary: '#FF1B1B1B',
    onSecondary: '#FF041012',
    onTertiary: '#FF1E1200',
    onBackground: '#FF2C2A29',
    onSurface: '#FF2E2924',
    onSurface70: '#B32E2924',
    primary15: '#26D95F02',
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40,
  }
  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20,
  }
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
    new Zone('Hab Deck', 0.30, '70°F'),
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Dock')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Smart Orbit Panel')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Alerts')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .height(56)
        .backgroundColor(AppTokens.Colors.surface)

        Scroll() {
          Column() {
            Row() {
              ForEach(this.modes, (mode: string) => {
                Text(mode)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                  .backgroundColor(this.activeMode === mode ? AppTokens.Colors.primary15 : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .onClick(() => { this.activeMode = mode })
              })
            }

            Column() {
              Text('Solar wash')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)
              Text('Adjust orbital window glow')
                .fontSize(13)
                .fontColor(AppTokens.Colors.onSurface70)
                .margin({ top: AppTokens.Spacing.sm })

              Slider({
                value: this.solarLevel,
                min: 0,
                max: 1,
                step: 0.01,
              })
                .blockColor(AppTokens.Colors.primary)
                .trackColor(AppTokens.Colors.surfaceVariant)
                .selectedColor(AppTokens.Colors.primary)
                .margin({ top: AppTokens.Spacing.sm })

              Row() {
                Text('0%')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                Blank()
                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.primary)
              }
              .margin({ top: AppTokens.Spacing.xs })

              Text('Ambient glow')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.sm })

              Slider({
                value: this.ambientGlow,
                min: 0,
                max: 1,
                step: 0.01,
              })
                .blockColor(AppTokens.Colors.secondary)
                .trackColor(AppTokens.Colors.surfaceVariant)
                .selectedColor(AppTokens.Colors.secondary)
                .margin({ top: AppTokens.Spacing.sm })

              Progress({ value: Math.round(this.ambientGlow * 100), total: 100, type: ProgressType.Linear })
                .color(AppTokens.Colors.secondary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .height(4)
                .borderRadius(2)
                .margin({ top: AppTokens.Spacing.sm })
            }
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            .alignItems(HorizontalAlign.Start)
            .margin({ top: AppTokens.Spacing.md })

            Column() {
              Text('Orbit health')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)

              StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
              StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
              StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
            }
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            .alignItems(HorizontalAlign.Start)
            .margin({ top: AppTokens.Spacing.md })

            Column() {
              Text('Deck zones')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onSurface)

              ForEach(this.zones, (zone: Zone) => {
                ZoneRow({ zoneName: zone.name, zoneHumidity: zone.humidity, zoneTemp: zone.temp })
              })
            }
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            .alignItems(HorizontalAlign.Start)
            .margin({ top: AppTokens.Spacing.md })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        Row() {
          Column() {
            Text('Grid draw')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text('18.4 kWh')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
              .margin({ top: AppTokens.Spacing.xs })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('Engage eco hold')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.medium)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
      }
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct StatusRow {
  @Prop label: string = ''
  @Prop value: number = 0
  @Prop accent: string = '#FFFFFF'

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }

      Progress({ value: Math.round(this.value * 100), total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(AppTokens.Colors.surface)
        .height(4)
        .borderRadius(2)
        .margin({ top: AppTokens.Spacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ top: AppTokens.Spacing.sm })
  }
}

@Component
struct ZoneRow {
  @Prop zoneName: string = ''
  @Prop zoneHumidity: number = 0
  @Prop zoneTemp: string = ''

  build() {
    Column() {
      Row() {
        Text(this.zoneName)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(this.zoneTemp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }

      Progress({ value: Math.round(this.zoneHumidity * 100), total: 100, type: ProgressType.Linear })
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
        .height(4)
        .borderRadius(2)
        .margin({ top: AppTokens.Spacing.xs })
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor('#80F0E3D1')
    .borderRadius(AppTokens.Shapes.small)
    .alignItems(HorizontalAlign.Start)
    .margin({ top: AppTokens.Spacing.sm })
  }
}