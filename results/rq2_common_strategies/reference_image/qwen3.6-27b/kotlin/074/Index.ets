import { Color, FontSize, FontWeight, LengthUnit } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

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
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  },
  Radius: {
    small: 12,
    medium: 16,
    large: 20
  }
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
              Chip(mode, this.activeMode === mode, () => {
                this.activeMode = mode;
              })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          // Solar Wash Card
          Card(AppTokens.Colors.surface, AppTokens.Radius.large) {
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Solar wash')
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
              
              Text('Adjust orbital window glow')
                .fontColor(Color.AppTokens.Colors.onSurface.withAlpha(0.7))
                .fontSize(13)

              Slider({ value: this.solarLevel, range: [0, 1] })
                .blockColor(AppTokens.Colors.primary)
                .trackColor(AppTokens.Colors.sliderTrackInactive)
                .selectedColor(AppTokens.Colors.primary)
                .showValue(false)
                .width('100%')
                .height(32) // Taller thumb area to match screenshot style roughly

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
                .fontWeight(FontWeight.SemiBold)

              Slider({ value: this.ambientGlow, range: [0, 1] })
                .blockColor(AppTokens.Colors.secondary)
                .trackColor(AppTokens.Colors.sliderTrackInactive)
                .selectedColor(AppTokens.Colors.secondary)
                .showValue(false)
                .width('100%')
                .height(32)

              // Linear Progress Indicator for Ambient Glow
              Row() {
                Row()
                  .width(`${this.ambientGlow * 100}%`)
                  .height(4)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(2)
              }
              .width('100%')
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(2)
              .height(4)

            }
            .padding(AppTokens.Spacing.lg)
          }

          // Orbit Health Card
          Card(AppTokens.Colors.surfaceVariant, AppTokens.Radius.large) {
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Orbit health')
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)

              StatusRow('Atmos mix', 0.74, AppTokens.Colors.secondary)
              StatusRow('Hull temp', 0.42, AppTokens.Colors.primary)
              StatusRow('Shield sync', 0.88, AppTokens.Colors.tertiary)
            }
            .padding(AppTokens.Spacing.lg)
          }

          // Deck Zones Card
          Card(AppTokens.Colors.surface, AppTokens.Radius.large) {
            Column({ space: AppTokens.Spacing.sm }) {
              Text('Deck zones')
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)

              ForEach(this.zones, (zone: Zone) => {
                ZoneRow(zone)
              })
            }
            .padding(AppTokens.Spacing.lg)
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
        }

        Button('Engage eco hold')
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor('#FFFFFF')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Radius.medium)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {})
      }
      .width('100%')
      .padding({ 
        left: AppTokens.Spacing.lg, 
        right: AppTokens.Spacing.lg, 
        top: AppTokens.Spacing.sm, 
        bottom: AppTokens.Spacing.sm 
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: '#00000026', offsetY: -2 }) // Simple shadow approximation
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct Chip {
  private text: string;
  private isSelected: boolean;
  private onClick: () => void;

  build() {
    Text(this.text)
      .fontColor(this.isSelected ? AppTokens.Colors.onSurface : AppTokens.Colors.onSurface)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary + '26' : AppTokens.Colors.surface) // Hex alpha approx for 0.15 opacity
      .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Radius.small })
      .onClick(this.onClick)
  }
}

@Component
struct StatusRow {
  private label: string;
  private value: number;
  private accent: string;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Text(this.label)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(13)
        
        Blank().layoutWeight(1)

        Text(`${Math.round(this.value * 100)}%`)
          .fontColor(this.accent)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')

      Row() {
        Row()
          .width(`${this.value * 100}%`)
          .height(4)
          .backgroundColor(this.accent)
          .borderRadius(2)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(2)
      .height(4)
    }
  }
}

@Component
struct ZoneRow {
  private zone: Zone;

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

      Row() {
        Row()
          .width(`${this.zone.humidity * 100}%`)
          .height(4)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(2)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(2)
      .height(4)
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surfaceVariant + '80') // Alpha approx
    .borderRadius(AppTokens.Radius.small)
  }
}

// Helper to access colors inside ArkTS components where static context might be tricky if not careful
namespace Color {
  export const AppTokens = AppTokens;
}