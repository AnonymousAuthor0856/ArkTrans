import { common } from '@kit.ArkUI';

// AppTokens.ts
export interface ColorToken {
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
}

export interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

export interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

export interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

export interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

export interface ElevationMapping {
  level1: ElevationLevel;
  level2: ElevationLevel;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
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
    onSurface: '#2E2924'
  };

  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Bold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium }
  };

  static readonly Shapes: ShapeToken = {
    small: 12,
    medium: 16,
    large: 20
  };

  static readonly Spacing: SpacingToken = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  };

  static readonly ElevationMapping: ElevationMapping = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.16 }
  };
}

// ZoneModel.ts
export interface Zone {
  name: string;
  humidity: number;
  temp: string;
}

// StatusRow.ets
@Component
export struct StatusRow {
  @Prop label: string;
  @Prop value: number; // 0 to 1
  @Prop accent: string;

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()
        
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value, total: 1 })
        .width('100%')
        .height(4)
        .color(this.accent)
        .backgroundColor(Color.Transparent) 
        .borderRadius(2)
    }
    .padding({ top: AppTokens.Spacing.xs })
  }
}

// ZoneRow.ets
@Component
export struct ZoneRow {
  @Prop zone: Zone;

  build() {
    Column() {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Blank()
        
        Text(this.zone.temp)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity, total: 1 })
        .width('100%')
        .height(4)
        .color(AppTokens.Colors.secondary)
        .backgroundColor('#EAEAEA') 
        .borderRadius(2)
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surfaceVariant + '80') 
    .borderRadius(AppTokens.Shapes.small)
    .margin({ bottom: AppTokens.Spacing.xs })
  }
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State activeMode: string = "Orbit";
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ["Orbit", "Eclipse", "Manual"];
  
  private zones: Zone[] = [
    { name: "Atrium", humidity: 0.45, temp: "72°F" },
    { name: "Lab East", humidity: 0.62, temp: "68°F" },
    { name: "Hab Deck", humidity: 0.30, temp: "70°F" }
  ];

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Button("Dock")
            .type(ButtonType.Capsule)
            .backgroundColor(Color.Transparent)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
          
          Blank()
          
          Text("Smart Orbit Panel")
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank()
          
          Button("Alerts")
            .type(ButtonType.Capsule)
            .backgroundColor(Color.Transparent)
            .fontColor(AppTokens.Colors.secondary)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable Content
        Scroll() {
          Column() {
            // Filter Chips
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
              ForEach(this.modes, (mode: string) => {
                Button(mode)
                  .onClick(() => {
                    this.activeMode = mode;
                  })
                  .type(ButtonType.Capsule)
                  .backgroundColor(this.activeMode === mode ? AppTokens.Colors.primary + '26' : AppTokens.Colors.surface) 
                  .borderWidth(1)
                  .borderColor(AppTokens.Colors.outline)
                  .fontColor(AppTokens.Colors.onSurface)
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                  .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              })
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.md })

            // Solar Wash Card
            Column() {
              Text("Solar wash")
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
              
              Text("Adjust orbital window glow")
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .opacity(0.7)
                .margin({ top: AppTokens.Spacing.xs })

              Slider({ value: this.solarLevel, min: 0, max: 1, step: 0.01 })
                .blockColor(AppTokens.Colors.surface)
                .selectedColor(AppTokens.Colors.primary)
                .trackColor('#EAEAEA')
                .trackThickness(4)
                .blockSize({ width: 24, height: 24 })
                .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              Row() {
                Text("0%")
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontColor(AppTokens.Colors.onSurface)
                
                Blank()
                
                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontSize(AppTokens.TypographyTokens.title.size)
                  .fontWeight(AppTokens.TypographyTokens.title.weight)
                  .fontColor(AppTokens.Colors.primary)
              }
              .width('100%')

              Text("Ambient glow")
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.md })

              Slider({ value: this.ambientGlow, min: 0, max: 1, step: 0.01 })
                .blockColor(AppTokens.Colors.surface)
                .selectedColor(AppTokens.Colors.secondary)
                .trackColor('#EAEAEA')
                .trackThickness(4)
                .blockSize({ width: 24, height: 24 })
                .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })

              Progress({ value: this.ambientGlow, total: 1 })
                .width('100%')
                .height(4)
                .color(AppTokens.Colors.secondary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(2)
            }
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: new Color('#000000').withAlpha(AppTokens.ElevationMapping.level1.opacity), offsetY: AppTokens.ElevationMapping.level1.dy })
            .margin({ bottom: AppTokens.Spacing.md })

            // Orbit Health Card
            Column() {
              Text("Orbit health")
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
              
              StatusRow({ label: "Atmos mix", value: 0.74, accent: AppTokens.Colors.secondary })
              StatusRow({ label: "Hull temp", value: 0.42, accent: AppTokens.Colors.primary })
              StatusRow({ label: "Shield sync", value: 0.88, accent: AppTokens.Colors.tertiary })
            }
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: new Color('#000000').withAlpha(AppTokens.ElevationMapping.level1.opacity), offsetY: AppTokens.ElevationMapping.level1.dy })
            .margin({ bottom: AppTokens.Spacing.md })

            // Deck Zones Card
            Column() {
              Text("Deck zones")
                .fontSize(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)
              
              ForEach(this.zones, (zone: Zone) => {
                ZoneRow({ zone: zone })
              })
            }
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: new Color('#000000').withAlpha(AppTokens.ElevationMapping.level1.opacity), offsetY: AppTokens.ElevationMapping.level1.dy })
            .margin({ bottom: AppTokens.Spacing.xxxl }) 
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Bottom Bar
        Row() {
          Column() {
            Text("Grid draw")
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontColor(AppTokens.Colors.onSurface)
            
            Text("18.4 kWh")
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.primary)
          }
          .alignItems(HorizontalAlign.Start)
          
          Blank()
          
          Button("Engage eco hold")
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: new Color('#000000').withAlpha(AppTokens.ElevationMapping.level2.opacity), offsetY: AppTokens.ElevationMapping.level2.dy })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
  }
}