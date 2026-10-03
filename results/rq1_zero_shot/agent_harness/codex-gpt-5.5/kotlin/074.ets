const NAME: string = "205_SmartOrbitPanel_en";
const UI_TYPE: string = "SmartHome ControlPanel";
const STYLE_THEME: string = "Retro Flat";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const DENSITY_SPACING: string = "Compact";
const COMPLEXITY: string = "Includes Slider and ProgressBar to tune orbit lighting, monitor zones and provide flat retro meters.";
const EXTRA: string = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts.";

class AppColors {
  static readonly primary: string = '#D95F02';
  static readonly secondary: string = '#1B9AAA';
  static readonly tertiary: string = '#FEC601';
  static readonly background: string = '#F9F4EB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F0E3D1';
  static readonly onSurface: string = '#2E2924';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
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
struct MainActivity {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ];

  @Builder
  TopBar() {
    Row() {
      Button('Dock')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(Color.Transparent)
      Text('Smart Orbit Panel')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
      Button('Alerts')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(64)
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
      .borderRadius(12)
      .onClick(() => {
        this.activeMode = mode;
      })
  }

  @Builder
  StatusRow(label: string, value: number, accent: string) {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor(AppColors.onSurface)
        Text(`${Math.floor(value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Progress({ value: value * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .color(accent)
        .backgroundColor(AppColors.surface)
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
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Progress({ value: zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor('#80F0E3D1')
    .borderRadius(12)
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
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Button('Engage eco hold')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .borderRadius(16)
    }
    .width('100%')
    .height(66)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#29000000', offsetY: -4 })
  }

  build() {
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

          Column({ space: AppSpacing.sm }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')
            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontColor(AppColors.onSurface)
              .opacity(0.7)
              .width('100%')
            Slider({ value: this.solarLevel, min: 0, max: 1, step: 0.01 })
              .onChange((value: number) => { this.solarLevel = value; })
              .width('100%')
            Row() {
              Text('0%').fontSize(11).fontColor(AppColors.onSurface)
              Text(`${Math.floor(this.solarLevel * 100)}%`).fontSize(16).fontWeight(FontWeight.Medium).fontColor(AppColors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')
            Slider({ value: this.ambientGlow, min: 0, max: 1, step: 0.01 })
              .onChange((value: number) => { this.ambientGlow = value; })
              .width('100%')
            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .width('100%')
              .color(AppColors.secondary)
              .backgroundColor(AppColors.surfaceVariant)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(20)

          Column({ space: AppSpacing.sm }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')
            this.StatusRow('Atmos mix', 0.74, AppColors.secondary)
            this.StatusRow('Hull temp', 0.42, AppColors.primary)
            this.StatusRow('Shield sync', 0.88, AppColors.tertiary)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(20)

          Column({ space: AppSpacing.sm }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .width('100%')
            ForEach(this.zones, (zone: Zone) => {
              this.ZoneRow(zone)
            })
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(20)
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
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
