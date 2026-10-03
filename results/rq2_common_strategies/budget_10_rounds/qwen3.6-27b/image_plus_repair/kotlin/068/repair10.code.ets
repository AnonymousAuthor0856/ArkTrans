import { common, UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

interface ColorTokens {
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

const COLORS: ColorTokens = {
  primary: '#7C4DFF',
  secondary: '#08D6FF',
  tertiary: '#FF8E3C',
  background: '#05030A',
  surface: '#0D0616',
  surfaceVariant: '#1A0F2C',
  outline: '#3A2759',
  success: '#56F0A6',
  warning: '#FFC857',
  error: '#FF5B7A',
  onPrimary: '#05030A',
  onSecondary: '#05030A',
  onTertiary: '#120601',
  onBackground: '#F4ECFF',
  onSurface: '#F8F4FF'
};

interface SpacingTokens {
  xxs: string;
  xs: string;
  sm: string;
  md: string;
  lg: string;
  xl: string;
  xxl: string;
}

const SPACING: SpacingTokens = {
  xxs: '4vp',
  xs: '8vp',
  sm: '12vp',
  md: '16vp',
  lg: '20vp',
  xl: '28vp',
  xxl: '40vp'
};

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

const SHAPES: ShapeTokens = {
  small: 8,
  medium: 18,
  large: 28
};

// --- Data Models ---

interface MacroSet {
  title: string;
  reps: string;
  phase: string;
}

interface PerformanceMetric {
  label: string;
  value: string;
  change: string;
}

// --- Main Entry Point ---

@Entry
@Component
struct Index {
  @State sets: MacroSet[] = [
    { title: "Warm circuit", reps: "3 sets", phase: "Energy" },
    { title: "Core push", reps: "4 rounds", phase: "Explosive" },
    { title: "Cooldown flow", reps: "6 min", phase: "Calm" }
  ];
  
  @State metrics: PerformanceMetric[] = [
    { label: "Load", value: "72%", change: "+4%" },
    { label: "VO2", value: "41", change: "+1" },
    { label: "Focus", value: "88%", change: "stable" }
  ];

  @State timerValue: string = "02:34";
  @State targetPhase: string = "Macro tempo";

  aboutToAppear() {
    // Hide status bar for immersive experience similar to Android code
    try {
      let ctx = getContext(this) as common.UIAbilityContext;
      let windowClass = window.WindowManager.getInstance().getWindowSync(ctx);
      windowClass.setWindowLayoutFullScreen(true);
    } catch (e) {
      console.error('Failed to set full screen');
    }
  }

  build() {
    Column() {
      // Top Bar
      this.TopBar();

      // Main Content
      Scroll() {
        Column({ space: Number(SPACING.lg.replace('vp', '')) }) {
          .padding({ left: Number(SPACING.lg.replace('vp', '')), right: Number(SPACING.lg.replace('vp', '')) })
          
          // Hero Section (Timer + Metrics)
          Row({ space: Number(SPACING.sm.replace('vp', '')) }) {
            // Timer Card
            Column() {
              .width('100%')
              .backgroundColor(COLORS.surface)
              .borderRadius(SHAPES.large)
              .padding(SPACING.md)
              .weight(1)
              
              // Progress Ring
              Stack() {
                Circle()
                  .width(160)
                  .height(160)
                  .fill(Color.Transparent)
                  .linearGradient({
                    direction: GradientDirection.Bottom,
                    colors: [
                      [COLORS.primary, 0],
                      [COLORS.secondary, 0.33],
                      [COLORS.tertiary, 0.66],
                      [COLORS.primary, 1]
                    ]
                  })
                  .borderWidth(10)
                
                Column({ space: 4 }) {
                  Text(this.timerValue)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(COLORS.onSurface)
                  
                  Text("Timer")
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#B3' + COLORS.onSurface.slice(1)) // Approx alpha 0.7
                }
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
              }
              .width(160)
              .height(160)
              .margin({ top: SPACING.sm, bottom: SPACING.sm })
              .alignSelf(ItemAlign.Center)

              // Tags
              Row({ space: Number(SPACING.xxs.replace('vp', '')) }) {
                ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
                  Text(tag)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLORS.onSurface)
                    .backgroundColor(COLORS.surfaceVariant)
                    .borderRadius(SHAPES.small)
                    .padding({ left: Number(SPACING.xs.replace('vp', '')), right: Number(SPACING.xs.replace('vp', '')), top: Number(SPACING.xxs.replace('vp', '')), bottom: Number(SPACING.xxs.replace('vp', '')) })
                })
              }
              .justifyContent(FlexAlign.Center)
            }

            // Metrics Column
            Column({ space: Number(SPACING.sm.replace('vp', '')) }) {
              .width(120)
              
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
                  .width('100%')
                  .backgroundColor(COLORS.surfaceVariant)
                  .borderRadius(SHAPES.medium)
                  .padding(SPACING.sm)
                  
                  Text(metric.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLORS.onSurface)
                  
                  Text(metric.value)
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(COLORS.secondary)
                  
                  Text(metric.change)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#B3' + COLORS.onSurface.slice(1))
                }
              })
            }
          }

          // Sets List
          Column({ space: Number(SPACING.lg.replace('vp', '')) }) {
            .margin({ top: SPACING.lg })
            
            ForEach(this.sets, (set: MacroSet) => {
              Row() {
                .width('100%')
                .backgroundColor(COLORS.surfaceVariant)
                .borderRadius(SHAPES.medium)
                .padding(SPACING.md)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)
                
                Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
                  Text(set.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLORS.onSurface)
                  
                  Text(set.phase)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#B3' + COLORS.onSurface.slice(1))
                }
                
                Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
                  .alignItems(HorizontalAlign.End)
                  
                  Text(set.reps)
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(COLORS.primary)
                  
                  Button("Start")
                    .backgroundColor(COLORS.secondary)
                    .fontColor(COLORS.onSecondary)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .borderRadius(SHAPES.small)
                    .padding({ left: Number(SPACING.xs.replace('vp', '')), right: Number(SPACING.xs.replace('vp', '')), top: Number(SPACING.xxs.replace('vp', '')), bottom: Number(SPACING.xxs.replace('vp', '')) })
                }
              }
            })
          }
          
          // Bottom padding to account for fixed bottom bar
          Blank().height(100)
        }
        .padding({ top: Number(SPACING.md.replace('vp', '')) })
      }
      .layoutWeight(1)
      .backgroundColor(COLORS.background)

      // Bottom Bar
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  TopBar() {
    Row() {
      .width('100%')
      .height(60)
      .backgroundColor('#F2' + COLORS.surface.slice(1)) // Approx alpha 0.95
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: Number(SPACING.lg.replace('vp', '')), right: Number(SPACING.lg.replace('vp', '')) })
      
      // Left Icon Placeholder
      Circle()
        .width(24)
        .height(24)
        .backgroundColor(COLORS.surfaceVariant)
      
      // Center Title
      Column({ space: 2 }) {
        Text("MacroTrainer")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
        
        Text("Neon workout stack")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3' + COLORS.onSurface.slice(1))
      }
      
      // Right Icon Placeholder
      Circle()
        .width(24)
        .height(24)
        .backgroundColor(COLORS.surfaceVariant)
    }
  }

  @Builder
  BottomBar() {
    Row() {
      .width('100%')
      .padding({ 
        left: Number(SPACING.lg.replace('vp', '')), 
        right: Number(SPACING.lg.replace('vp', '')), 
        top: Number(SPACING.md.replace('vp', '')), 
        bottom: Number(SPACING.md.replace('vp', '')) 
      })
      .backgroundColor(COLORS.surfaceVariant)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      
      Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
        Text("Next macro")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
        
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
      }
      
      Button("Prime")
        .backgroundColor(COLORS.secondary)
        .fontColor(COLORS.onSecondary)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .borderRadius(SHAPES.medium)
        .padding({ left: Number(SPACING.xl.replace('vp', '')), right: Number(SPACING.xl.replace('vp', '')), top: Number(SPACING.xs.replace('vp', '')), bottom: Number(SPACING.xs.replace('vp', '')) })
    }
  }
}