class AppColors {
  static primary: string = '#D95F02';
  static secondary: string = '#1B9AAA';
  static tertiary: string = '#FEC601';
  static background: string = '#F9F4EB';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F0E3D1';
  static outline: string = '#E1CDB2';
  static success: string = '#56C271';
  static warning: string = '#F4A259';
  static error: string = '#D7263D';
  static onPrimary: string = '#1B1B1B';
  static onSecondary: string = '#041012';
  static onTertiary: string = '#1E1200';
  static onBackground: string = '#2C2A29';
  static onSurface: string = '#2E2924';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 20;
  static xxl: number = 28;
  static xxxl: number = 40;
}

class Zone {
  name: string;
  humidity: number;
  temp: string;

  constructor(name: string, humidity: number, temp: string) {
    this.name = name;
    this.humidity = humidity;
    this.temp = temp;
  }
}

@Entry
@Component
struct RootScreen {
  @State private activeMode: string = 'Orbit';
  @State private solarLevel: number = 0.6;
  @State private ambientGlow: number = 0.35;
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ];

  @Builder
  private StatusRow(label: string, value: number, accent: string) {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(`${Math.floor(value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(accent)
      }
      .width('100%')
      Progress({ value: value * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(accent)
        .backgroundColor(AppColors.surface)
    }
    .width('100%')
  }

  @Builder
  private ZoneRow(zone: Zone) {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      Progress({ value: zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surface)
    }
    .padding(AppSpacing.sm)
    .width('100%')
    .backgroundColor('#F0E3D180')
    .borderRadius(12)
  }

  @Builder
  private TopBar() {
    Row() {
      Button('Dock')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(Color.Transparent)
      Blank()
      Text('Smart Orbit Panel')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Blank()
      Button('Alerts')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .height(56)
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private ModeChip(mode: string) {
    Text(mode)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.activeMode === mode ? '#D95F0226' : AppColors.surface)
      .borderRadius(12)
      .border({ width: 1, color: AppColors.outline })
      .onClick(() => {
        this.activeMode = mode;
      })
  }

  @Builder
  private SolarCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Solar wash')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
      Text('Adjust orbital window glow')
        .fontSize(13)
        .fontColor('#2E2924B3')
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({ value: this.solarLevel * 100, min: 0, max: 100 })
        .selectedColor(AppColors.primary)
        .onChange((value: number) => {
          this.solarLevel = value / 100;
        })

      Row() {
        Text('0%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(`${Math.floor(this.solarLevel * 100)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Text('Ambient glow')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({ value: this.ambientGlow * 100, min: 0, max: 100 })
        .selectedColor(AppColors.secondary)
        .onChange((value: number) => {
          this.ambientGlow = value / 100;
        })

      Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surfaceVariant)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0000001F', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private HealthCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Orbit health')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
      this.StatusRow('Atmos mix', 0.74, AppColors.secondary)
      this.StatusRow('Hull temp', 0.42, AppColors.primary)
      this.StatusRow('Shield sync', 0.88, AppColors.tertiary)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0000001F', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private ZonesCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Deck zones')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
      ForEach(this.zones, (zone: Zone) => {
        this.ZoneRow(zone)
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0000001F', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private BottomBar() {
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
      Button('Engage eco hold')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .width('100%')
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#00000029', offsetX: 0, offsetY: 4 })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
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
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
          .width('100%')
        }
        .layoutWeight(1)

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
