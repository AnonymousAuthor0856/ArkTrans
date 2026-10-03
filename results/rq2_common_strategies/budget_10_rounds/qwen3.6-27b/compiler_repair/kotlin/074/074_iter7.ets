import { router } from '@kit.ArkRouter'
import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

interface AppColors {
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

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
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
    onSurface: '#2E2924'
  } as AppColors,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  } as AppSpacing
}

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
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
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
        
        Blank()

        Text('Smart Orbit Panel')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Text('Alerts')
          .fontColor(AppTokens.Colors.secondary)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Mode Chips
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.modes, (mode: string) => {
              Button(mode)
                .type(ButtonType.Normal)
                .backgroundColor(this.activeMode === mode ? '#FFF0E6' : AppTokens.Colors.surface)
                .borderRadius(12)
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .onClick(() => {
                  this.activeMode = mode;
                })
                .border({ width: 1, color: AppTokens.Colors.outline })
            })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

          // Solar Wash Card
          CardComponent({ 
            title: 'Solar wash', 
            subtitle: 'Adjust orbital window glow',
            sliderValue: $solarLevel,
            sliderColor: AppTokens.Colors.primary,
            label: 'Ambient glow',
            progressValue: $ambientGlow,
            progressColor: AppTokens.Colors.secondary
          })
          .margin({ top: AppTokens.Spacing.md })

          // Orbit Health Card
          CardComponentHealth()
          .margin({ top: AppTokens.Spacing.md })

          // Deck Zones Card
          CardComponentZones({ zones: this.zones })
          .margin({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxl })
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
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
        
        Button('Engage eco hold')
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor('#FFFFFF')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .margin({ left: AppTokens.Spacing.md })
      }
      .width('100%')
      .padding({ 
        left: AppTokens.Spacing.lg, 
        right: AppTokens.Spacing.lg, 
        top: AppTokens.Spacing.sm, 
        bottom: AppTokens.Spacing.sm 
      })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
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
  @Link sliderValue: number;
  @Prop sliderColor: string;
  @Prop label: string;
  @Link progressValue: number;
  @Prop progressColor: string;

  build() {
    Column() {
      Text(this.title)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      
      Text(this.subtitle)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .fontSize(13)
        .margin({ top: AppTokens.Spacing.xs })

      Slider({ value: this.sliderValue, min: 0, max: 1, step: 0.01 })
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(this.sliderColor)
        .blockColor(this.sliderColor)
        .width('100%')
        .margin({ top: AppTokens.Spacing.md })
        .onChange((value: number) => {
          this.sliderValue = value;
        })

      Row() {
        Text('0%')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
        
        Blank()
        
        Text(`${Math.round(this.sliderValue * 100)}%`)
          .fontColor(this.sliderColor)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.xs })

      Text(this.label)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: AppTokens.Spacing.md })

      Slider({ value: this.progressValue, min: 0, max: 1, step: 0.01 })
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(this.progressColor)
        .blockColor(this.progressColor)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
        .onChange((value: number) => {
          this.progressValue = value;
        })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(20)
    .width('100%')
  }
}

@Component
struct CardComponentHealth {
  build() {
    Column() {
      Text('Orbit health')
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      
      StatusRowItem({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
      StatusRowItem({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
      StatusRowItem({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(20)
    .width('100%')
  }
}

@Component
struct StatusRowItem {
  @Prop label: string;
  @Prop value: number;
  @Prop accent: string;

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(13)
        
        Blank()
        
        Text(`${Math.round(this.value * 100)}%`)
          .fontColor(this.accent)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      
      Progress({ value: this.value, total: 1, type: ProgressType.Linear })
        .color(this.accent)
        .trackColor(AppTokens.Colors.surface)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .margin({ top: AppTokens.Spacing.sm })
  }
}

@Component
struct CardComponentZones {
  @Prop zones: Zone[];

  build() {
    Column() {
      Text('Deck zones')
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      
      ForEach(this.zones, (zone: Zone) => {
        ZoneRowItem({ zone: zone })
      })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(20)
    .width('100%')
  }
}

@Component
struct ZoneRowItem {
  @Prop zone: Zone;

  build() {
    Column() {
      Row() {
        Text(this.zone.name)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        
        Blank()
        
        Text(this.zone.temp)
          .fontColor(AppTokens.Colors.primary)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      
      Progress({ value: this.zone.humidity, total: 1, type: ProgressType.Linear })
        .color(AppTokens.Colors.secondary)
        .trackColor(AppTokens.Colors.surface)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xs })
    }
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .opacity(0.5)
    .borderRadius(12)
    .margin({ top: AppTokens.Spacing.sm })
  }
}