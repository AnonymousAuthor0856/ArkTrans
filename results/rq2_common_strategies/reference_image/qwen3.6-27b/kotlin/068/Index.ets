import { common, window } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

// --- Design Tokens & Constants ---

const COLORS = {
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

const SPACING = {
  xxs: '4vp',
  xs: '8vp',
  sm: '12vp',
  md: '16vp',
  lg: '20vp',
  xl: '28vp',
  xxl: '40vp'
};

const SHAPES = {
  small: '8vp',
  medium: '18vp',
  large: '28vp'
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

  build() {
    Column() {
      // Top Bar
      this.TopBar();

      // Scrollable Content
      Scroll() {
        Column({ space: Number(SPACING.lg.replace('vp', '')) }) {
          // Timer and Metrics Section
          Row({ space: Number(SPACING.sm.replace('vp', '')) }) {
            // Timer Card
            this.TimerCard();
            
            // Metrics Column
            Column({ space: Number(SPACING.sm.replace('vp', '')) }) {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                this.MetricCard(metric);
              })
            }.width('35%')
          }.width('100%')

          // Workout Sets List
          Column({ space: Number(SPACING.md.replace('vp', '')) }) {
            ForEach(this.sets, (set: MacroSet) => {
              this.SetCard(set);
            })
          }.width('100%')
          
          // Bottom padding for the fixed bottom bar
          Blank().height(Number(SPACING.xxl.replace('vp', '')))
        }
        .padding({ left: Number(SPACING.lg.replace('vp', '')), right: Number(SPACING.lg.replace('vp', '')) })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .backgroundColor(COLORS.background)
    .width('100%')
    .height('100%')
    
    // Fixed Bottom Bar
    this.BottomBar();
  }

  @Builder
  TopBar() {
    Row() {
      // Left Icon Placeholder
      Circle({ width: '24vp', height: '24vp' })
        .fill(COLORS.surfaceVariant)
      
      Column() {
        Text("MacroTrainer")
          .fontColor(COLORS.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize('16fp')
        Text("Neon workout stack")
          .fontColor(Color.Transparent) // Using alpha in ArkTS is tricky with hex, using transparent or lighter color
          .opacity(0.7)
          .fontColor(COLORS.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize('12fp')
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)

      // Right Icon Placeholder
      Circle({ width: '24vp', height: '24vp' })
        .fill(COLORS.surfaceVariant)
    }
    .width('100%')
    .padding({ top: Number(SPACING.md.replace('vp', '')), bottom: Number(SPACING.md.replace('vp', '')), left: Number(SPACING.lg.replace('vp', '')), right: Number(SPACING.lg.replace('vp', '')) })
    .backgroundColor(COLORS.surface)
    .opacity(0.95)
  }

  @Builder
  TimerCard() {
    Column({ space: Number(SPACING.sm.replace('vp', '')) }) {
      // Circular Progress Ring
      Stack() {
        // Background Circle
        Circle({ width: '160vp', height: '160vp' })
          .fill(COLORS.surface)
        
        // Gradient Border Simulation (Using a slightly larger circle with gradient stroke isn't direct in ArkTS basic shapes, 
        // so we use a conical gradient mask or just a thick border if supported. 
        // Here we simulate the look with a thick border using a linear gradient approximation or just a solid color if complex gradients fail.
        // ArkTS supports LinearGradient. Let's try to mimic the sweep gradient with a ConicalGradient if available or just a nice border.
        // Since ConicalGradient might be version dependent, let's use a thick border with a linear gradient as a fallback visual.
        Circle({ width: '160vp', height: '160vp' })
          .border({
            width: 10,
            color: new LinearGradient({
              angle: 45,
              colors: [[COLORS.primary, 0], [COLORS.secondary, 0.5], [COLORS.tertiary, 1]]
            }),
            radius: '50%'
          })
          .margin({ top: -5, left: -5, right: -5, bottom: -5 }) // Adjust for border thickness

        // Center Content
        Column() {
          Text(this.timerValue)
            .fontColor(COLORS.onSurface)
            .fontWeight(FontWeight.Bold)
            .fontSize('32fp')
            .lineHeight('38fp')
          Text("Timer")
            .fontColor(COLORS.onSurface)
            .opacity(0.7)
            .fontWeight(FontWeight.Medium)
            .fontSize('12fp')
        }
      }
      .width('160vp')
      .height('160vp')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Tags
      Row({ space: Number(SPACING.xxs.replace('vp', '')) }) {
        ["Macro", "Tempo", "Breath"].forEach(tag => {
          Text(tag)
            .fontColor(COLORS.onSurface)
            .fontWeight(FontWeight.Medium)
            .fontSize('12fp')
            .padding({ left: Number(SPACING.xs.replace('vp', '')), right: Number(SPACING.xs.replace('vp', '')), top: Number(SPACING.xxs.replace('vp', '')), bottom: Number(SPACING.xxs.replace('vp', '')) })
            .backgroundColor(COLORS.surfaceVariant)
            .borderRadius(Number(SHAPES.small.replace('vp', '')))
        })
      }
    }
    .width('65%')
    .padding(Number(SPACING.md.replace('vp', '')))
    .backgroundColor(COLORS.surface)
    .borderRadius(Number(SHAPES.large.replace('vp', '')))
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  MetricCard(metric: PerformanceMetric) {
    Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
      Text(metric.label)
        .fontColor(COLORS.onSurface)
        .fontWeight(FontWeight.Medium)
        .fontSize('12fp')
      
      Text(metric.value)
        .fontColor(COLORS.secondary)
        .fontWeight(FontWeight.SemiBold)
        .fontSize('22fp')
      
      Text(metric.change)
        .fontColor(COLORS.onSurface)
        .opacity(0.7)
        .fontWeight(FontWeight.Normal)
        .fontSize('14fp')
    }
    .width('100%')
    .padding(Number(SPACING.sm.replace('vp', '')))
    .backgroundColor(COLORS.surfaceVariant)
    .borderRadius(Number(SHAPES.medium.replace('vp', '')))
  }

  @Builder
  SetCard(set: MacroSet) {
    Row() {
      Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
        Text(set.title)
          .fontColor(COLORS.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize('16fp')
        
        Text(set.phase)
          .fontColor(COLORS.onSurface)
          .opacity(0.7)
          .fontWeight(FontWeight.Normal)
          .fontSize('14fp')
      }
      
      Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
        Text(set.reps)
          .fontColor(COLORS.primary)
          .fontWeight(FontWeight.SemiBold)
          .fontSize('22fp')
        
        Button("Start")
          .type(ButtonType.Normal)
          .backgroundColor(COLORS.secondary)
          .fontColor(COLORS.onSecondary)
          .fontWeight(FontWeight.Medium)
          .fontSize('12fp')
          .borderRadius(Number(SHAPES.small.replace('vp', '')))
          .padding({ left: Number(SPACING.xs.replace('vp', '')), right: Number(SPACING.xs.replace('vp', '')), top: Number(SPACING.xxs.replace('vp', '')), bottom: Number(SPACING.xxs.replace('vp', '')) })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .verticalAlign(VerticalAlign.Center)
    .padding(Number(SPACING.md.replace('vp', '')))
    .backgroundColor(COLORS.surfaceVariant)
    .opacity(0.9)
    .borderRadius(Number(SHAPES.medium.replace('vp', '')))
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: Number(SPACING.xxs.replace('vp', '')) }) {
        Text("Next macro")
          .fontColor(COLORS.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize('12fp')
        
        Text(this.targetPhase)
          .fontColor(COLORS.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize('16fp')
      }
      
      Button("Prime")
        .type(ButtonType.Normal)
        .backgroundColor(COLORS.secondary)
        .fontColor(COLORS.onSecondary)
        .fontWeight(FontWeight.Medium)
        .fontSize('16fp')
        .borderRadius(Number(SHAPES.medium.replace('vp', '')))
        .padding({ left: Number(SPACING.xl.replace('vp', '')), right: Number(SPACING.xl.replace('vp', '')), top: Number(SPACING.xs.replace('vp', '')), bottom: Number(SPACING.xs.replace('vp', '')) })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .verticalAlign(VerticalAlign.Center)
    .padding({ left: Number(SPACING.lg.replace('vp', '')), right: Number(SPACING.lg.replace('vp', '')), top: Number(SPACING.md.replace('vp', '')), bottom: Number(SPACING.md.replace('vp', '')) })
    .backgroundColor(COLORS.surfaceVariant)
  }
}