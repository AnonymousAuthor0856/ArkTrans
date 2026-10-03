import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - Design Tokens & Constants
interface ColorMap {
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

const COLORS: ColorMap = {
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

interface SpacingMap {
  xxs: number;
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

const SPACING: SpacingMap = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 40,
  xxxl: 56
};

// MARK: - Data Models
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

// MARK: - Main Entry
@Entry
@Component
struct MacroTrainerApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}

// MARK: - Content View
@Component
struct ContentView {
  @State timerValue: string = "02:34";
  @State targetPhase: string = "Macro tempo";

  private sets: MacroSet[] = [
    { title: "Warm circuit", reps: "3 sets", phase: "Energy" },
    { title: "Core push", reps: "4 rounds", phase: "Explosive" },
    { title: "Cooldown flow", reps: "6 min", phase: "Calm" }
  ];

  private metrics: PerformanceMetric[] = [
    { label: "Load", value: "72%", change: "+4%" },
    { label: "VO2", value: "41", change: "+1" },
    { label: "Focus", value: "88%", change: "stable" }
  ];

  private tags: string[] = ["Macro", "Tempo", "Breath"];

  build() {
    Column() {
      TopAppBar()
      
      Scroll() {
        Column({ space: SPACING.lg }) {
          TimerSection({ 
            timerValue: this.timerValue, 
            tags: this.tags, 
            metrics: this.metrics 
          })
          
          SetsListSection({ sets: this.sets })
        }
        .padding({ left: SPACING.lg, right: SPACING.lg, top: SPACING.md, bottom: SPACING.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomBar({ targetPhase: this.targetPhase })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}

// MARK: - Top App Bar
@Component
struct TopAppBar {
  build() {
    Row() {
      Circle()
        .fill(COLORS.surfaceVariant)
        .width(24)
        .height(24)
      
      Blank()
      
      Column() {
        Text("MacroTrainer")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
        
        Text("Neon workout stack")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#F8F4FF') // Using hex directly or defined constant if needed, avoiding Color() call issues
          .opacity(0.7)
      }
      
      Blank()
      
      Circle()
        .fill(COLORS.surfaceVariant)
        .width(24)
        .height(24)
    }
    .width('100%')
    .height(60)
    .padding({ left: SPACING.lg, right: SPACING.lg })
    .backgroundColor('#0D0616') // Using hex directly
    .opacity(0.95)
  }
}

// MARK: - Timer Section
@Component
struct TimerSection {
  timerValue: string = "";
  tags: string[] = [];
  metrics: PerformanceMetric[] = [];

  build() {
    Row({ space: SPACING.sm }) {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
      MetricsColumn({ metrics: this.metrics })
    }
  }
}

@Component
struct TimerRing {
  timerValue: string = "";
  tags: string[] = [];

  build() {
    Column({ space: SPACING.sm }) {
      Stack() {
        // Gradient Ring
        Circle()
          .stroke(new LinearGradient({
            angle: 360,
            colors: [
              { color: COLORS.primary, offset: 0 },
              { color: COLORS.secondary, offset: 0.33 },
              { color: COLORS.tertiary, offset: 0.66 },
              { color: COLORS.primary, offset: 1 }
            ]
          }))
          .strokeWidth(10)
          .width(160)
          .height(160)

        Column({ space: 4 }) {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLORS.onSurface)
          
          Text("Timer")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
            .opacity(0.7)
        }
      }
      .width(160)
      .height(160)

      Row({ space: SPACING.xxs }) {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.onSurface)
            .padding({ left: SPACING.xs, right: SPACING.xs, top: SPACING.xxs, bottom: SPACING.xxs })
            .backgroundColor(COLORS.surfaceVariant)
            .borderRadius(8)
        })
      }
    }
    .padding(SPACING.md)
    .backgroundColor(COLORS.surface)
    .borderRadius(28)
    .shadow({ radius: 6, color: '#000000', offsetY: 4 })
    .opacity(0.74) // Approximating shadow opacity effect if direct shadow color opacity isn't supported simply
  }
}

@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = [];

  build() {
    Column({ space: SPACING.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      })
    }
    .width(120)
  }
}

@Component
struct MetricCard {
  metric: PerformanceMetric = { label: "", value: "", change: "" };

  build() {
    Column({ space: SPACING.xxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onSurface)
        .alignSelf(ItemAlign.Start)
      
      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold) // SemiBold not available in some versions, using Bold or Regular
        .fontColor(COLORS.secondary)
        .alignSelf(ItemAlign.Start)
      
      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#F8F4FF')
        .opacity(0.7)
        .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .padding(SPACING.sm)
    .backgroundColor(COLORS.surfaceVariant)
    .borderRadius(18)
  }
}

// MARK: - Sets List Section
@Component
struct SetsListSection {
  sets: MacroSet[] = [];

  build() {
    Column() {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
      })
    }
  }
}

@Component
struct SetListItemView {
  set: MacroSet = { title: "", reps: "", phase: "" };

  build() {
    Row() {
      Column({ space: SPACING.xxs }) {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
          .alignSelf(ItemAlign.Start)
        
        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#F8F4FF')
          .opacity(0.7)
          .alignSelf(ItemAlign.Start)
      }
      .layoutWeight(1)
      
      Column({ space: SPACING.xxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)
          .alignSelf(ItemAlign.End)
        
        Button({ type: ButtonType.Capsule, stateEffect: true })
          .type(ButtonType.Capsule)
          .onClick(() => {
            // Start action
          })
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSecondary)
          .backgroundColor(COLORS.secondary)
          .borderRadius(8)
          .padding({ left: SPACING.xs, right: SPACING.xs, top: SPACING.xxs, bottom: SPACING.xxs })
          .alignSelf(ItemAlign.End)
          .width('auto')
          .height('auto')
      }
    }
    .width('100%')
    .padding(SPACING.md)
    .backgroundColor('#1A0F2C')
    .opacity(0.9)
    .borderRadius(18)
    .margin({ bottom: SPACING.sm })
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  targetPhase: string = "";

  build() {
    Row() {
      Column({ space: SPACING.xxs }) {
        Text("Next macro")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
          .alignSelf(ItemAlign.Start)
        
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
          .alignSelf(ItemAlign.Start)
      }
      
      Blank()
      
      Button({ type: ButtonType.Capsule, stateEffect: true })
        .type(ButtonType.Capsule)
        .onClick(() => {
          // Prime action
        })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onSecondary)
        .backgroundColor(COLORS.secondary)
        .borderRadius(18)
        .padding({ left: SPACING.xl, right: SPACING.xl, top: SPACING.xs, bottom: SPACING.xs })
    }
    .width('100%')
    .height(80)
    .padding({ left: SPACING.lg, right: SPACING.lg })
    .backgroundColor(COLORS.surfaceVariant)
    .shadow({ radius: 12, color: '#000000', offsetY: -6 })
    .opacity(0.74)
  }
}