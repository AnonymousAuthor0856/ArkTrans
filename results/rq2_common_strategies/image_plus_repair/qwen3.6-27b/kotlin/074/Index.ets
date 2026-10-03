import { LengthUnit } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

interface AppTokenColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
  sliderTrackInactive: string;
}

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppTokenRadius {
  small: number;
  medium: number;
  large: number;
}

const AppTokens = {
  Colors: {
    primary: '#D95F02',
    secondary: '#1B9AAA',
    tertiary: '#FEC601',
    background: '#F9F4EB',
    surface: '#FFFFFF',
    surfaceVariant: '#F0E3D1',
    outline: '#E1CDB2',
    success: '#56C271',
    warning: '#F4A259',
    error: '#D7263D',
    onPrimary: '#1B1B1B',
    onSecondary: '#041012',
    onTertiary: '#1E1200',
    onBackground: '#2C2A29',
    onSurface: '#2E2924',
    sliderTrackInactive: '#E8DEF8' // Approximation for the light purple track in screenshot
  } as AppTokenColors,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  } as AppTokenSpacing,
  Radius: {
    small: 12,
    medium: 16,
    large: 20
  } as AppTokenRadius
};

interface Zone {
  name: string;
  humidity: number;
  temp: string;
}

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  
  private zones: Zone[] = [
    { name: "Atrium", humidity: 0.45, temp: "72°F" },
    { name: "Lab East", humidity: 0.62, temp: "68°F" },
    { name: "Hab Deck", humidity: 0.30, temp: "70°F" }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Dock')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
        
        Blank().layoutWeight(1)

        Text('Smart Orbit Panel')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
        
        Blank().layoutWeight(1)

        Text('Alerts')
          .fontColor(AppTokens.Colors.secondary)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.sm })

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          
          // Mode Chips
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.modes, (mode: string) => {
              Button(mode)
                .backgroundColor(this.activeMode === mode ? AppTokens.Colors.primary + '26' : AppTokens.Colors.surface)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .height(36)
                .borderRadius(AppTokens.Radius.small)
                .onClick(() => {
                  this.activeMode = mode;
                })
            })
          }
          .width('100%')

          // Solar Wash Card
          CardComponent({ 
            title: 'Solar wash', 
            subtitle: 'Adjust orbital window glow', 
            color: AppTokens.Colors.surface 
          }) {
            Column({ space: AppTokens.Spacing.sm }) {
              Slider({ value: this.solarLevel, min: 0, max: 1 })
                .blockColor(AppTokens.Colors.primary)
                .selectedColor(AppTokens.Colors.primary)
                .trackColor(AppTokens.Colors.sliderTrackInactive)
                .trackHeight(12)
                .blockSize({ width: 4, height: 40 })
                .onChange((value: number) => {
                  this.solarLevel = value;
                })

              Row() {
                Text('0%')
                  .fontColor(AppTokens.Colors.onSurface)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                
                Blank().layoutWeight(1)

                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontColor(AppTokens.Colors.primary)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')

              Text('Ambient glow')
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ top: AppTokens.Spacing.xs })

              Slider({ value: this.ambientGlow, min: 0, max: 1 })
                .blockColor(AppTokens.Colors.secondary)
                .selectedColor(AppTokens.Colors.secondary)
                .trackColor(AppTokens.Colors.sliderTrackInactive)
                .trackHeight(12)
                .blockSize({ width: 4, height: 40 })
                .onChange((value: number) => {
                  this.ambientGlow = value;
                })

              Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
                .width('100%')
                .height(6)
                .color(AppTokens.Colors.secondary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(3)
            }
          }

          // Orbit Health Card
          CardComponent({ 
            title: 'Orbit health', 
            subtitle: '', 
            color: AppTokens.Colors.surfaceVariant 
          }) {
            Column({ space: AppTokens.Spacing.sm }) {
              StatusRowItem({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
              StatusRowItem({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
              StatusRowItem({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
            }
          }

          // Deck Zones Card
          CardComponent({ 
            title: 'Deck zones', 
            subtitle: '', 
            color: AppTokens.Colors.surface 
          }) {
            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.zones, (zone: Zone) => {
                ZoneRowItem({ zone: zone })
              })
            }
          }
          
          // Spacer for bottom bar clearance
          Column().height(80)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        Column() {
          Text('Grid draw')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
          
          Text('18.4 kWh')
            .fontColor(AppTokens.Colors.primary)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: AppTokens.Spacing.xs })
        }

        Blank().layoutWeight(1)

        Button('Engage eco hold')
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor('#FFFFFF')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Radius.medium)
          .height(48)
          .margin({ right: AppTokens.Spacing.lg })
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CardComponent {
  @Prop title: string;
  @Prop subtitle: string;
  @Prop color: string;
  @BuilderParam content: () => void;

  build() {
    Column() {
      Column({ space: AppTokens.Spacing.sm }) {
        if (this.title) {
          Text(this.title)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        if (this.subtitle) {
          Text(this.subtitle)
            .fontColor(Color.Gray)
            .fontSize(13)
            .fontWeight(FontWeight.Normal)
        }
        this.content();
      }
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .backgroundColor(this.color)
    .borderRadius(AppTokens.Radius.large)
  }
}

@Component
struct StatusRowItem {
  @Prop label: string;
  @Prop value: number;
  @Prop accent: string;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Text(this.label)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
        
        Blank().layoutWeight(1)

        Text(`${Math.round(this.value * 100)}%`)
          .fontColor(this.accent)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')

      Progress({ value: this.value, total: 1, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color(this.accent)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(3)
    }
  }
}

@Component
struct ZoneRowItem {
  @Prop zone: Zone;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        
        Blank().layoutWeight(1)

        Text(this.zone.temp)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')

      Progress({ value: this.zone.humidity, total: 1, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(3)
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surfaceVariant + '80') // Alpha approx
    .borderRadius(AppTokens.Radius.small)
  }
}