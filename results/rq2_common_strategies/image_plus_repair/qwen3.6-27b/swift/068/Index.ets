// App.ets

// MARK: - Data Models
interface MacroSet {
  title: string
  reps: string
  phase: string
}

interface PerformanceMetric {
  label: string
  value: string
  change: string
}

// MARK: - Design Tokens
class DesignTokens {
  static Colors = {
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
  }
  
  static Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 40,
    xxxl: 56
  }
}

@Entry
@Component
struct MacroTrainerApp {
  @State timerValue: string = "02:34"
  @State targetPhase: string = "Macro tempo"
  
  private sets: MacroSet[] = [
    { title: "Warm circuit", reps: "3 sets", phase: "Energy" },
    { title: "Core push", reps: "4 rounds", phase: "Explosive" },
    { title: "Cooldown flow", reps: "6 min", phase: "Calm" }
  ]
  
  private metrics: PerformanceMetric[] = [
    { label: "Load", value: "72%", change: "+4%" },
    { label: "VO2", value: "41", change: "+1" },
    { label: "Focus", value: "88%", change: "stable" }
  ]
  
  private tags: string[] = ["Macro", "Tempo", "Breath"]
  
  build() {
    Column() {
      TopAppBar()
      
      MainContent({
        sets: this.sets,
        metrics: this.metrics,
        tags: this.tags,
        timerValue: this.timerValue
      })
      
      BottomBar({ targetPhase: this.targetPhase })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}

// MARK: - Top App Bar
@Component
struct TopAppBar {
  build() {
    Row() {
      Circle()
        .fill(DesignTokens.Colors.surfaceVariant)
        .width(24)
        .height(24)
      
      Flex().alignItems(FlexAlign.Center).justifyContent(FlexAlign.Center)
      
      Column() {
        Text("MacroTrainer")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        
        Text("Neon workout stack")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(new Color(DesignTokens.Colors.onSurface).withOpacity(0.7))
      }
      
      Flex().alignItems(FlexAlign.Center).justifyContent(FlexAlign.Center)
      
      Circle()
        .fill(DesignTokens.Colors.surfaceVariant)
        .width(24)
        .height(24)
    }
    .width('100%')
    .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
    .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    .height(60)
    .backgroundColor(new Color(DesignTokens.Colors.surface).withOpacity(0.95))
  }
}

// MARK: - Main Content
@Component
struct MainContent {
  sets: MacroSet[] = []
  metrics: PerformanceMetric[] = []
  tags: string[] = []
  timerValue: string = ""
  
  build() {
    Scroll() {
      Column() {
        TimerSection({
          timerValue: this.timerValue,
          tags: this.tags,
          metrics: this.metrics
        })
        
        SetsListSection({ sets: this.sets })
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
      .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .layoutWeight(1)
  }
}

// MARK: - Timer Section
@Component
struct TimerSection {
  timerValue: string = ""
  tags: string[] = []
  metrics: PerformanceMetric[] = []
  
  build() {
    Row() {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
      
      MetricsColumn({ metrics: this.metrics })
    }
    .margin({ bottom: DesignTokens.Spacing.lg })
  }
}

@Component
struct TimerRing {
  timerValue: string = ""
  tags: string[] = []
  
  build() {
    Column() {
      Stack() {
        // Gradient ring
        Canvas()
          .width(160)
          .height(160)
          .onReady((context: CanvasRenderingContext2D) => {
            const gradient = context.createLinearGradient(0, 0, 160, 160);
            gradient.addColorStop(0, DesignTokens.Colors.primary);
            gradient.addColorStop(0.33, DesignTokens.Colors.secondary);
            gradient.addColorStop(0.66, DesignTokens.Colors.tertiary);
            gradient.addColorStop(1, DesignTokens.Colors.primary);
            
            context.beginPath();
            context.arc(80, 80, 70, 0, Math.PI * 2);
            context.strokeStyle = gradient;
            context.lineWidth = 10;
            context.stroke();
          })
        
        Column() {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignTokens.Colors.onSurface)
          
          Text("Timer")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(new Color(DesignTokens.Colors.onSurface).withOpacity(0.7))
        }
      }
      
      Row() {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs })
            .padding({ top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .fontColor(DesignTokens.Colors.onSurface)
            .borderRadius(8)
            .margin({ right: DesignTokens.Spacing.xxs })
        })
      }
    }
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(28)
    .shadow({ radius: 6, color: new Color('#000000').withOpacity(0.26), offsetY: 4 })
  }
}

@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = []
  
  build() {
    Column() {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      })
    }
    .width(120)
    .margin({ left: DesignTokens.Spacing.sm })
  }
}

@Component
struct MetricCard {
  metric: PerformanceMetric = { label: "", value: "", change: "" }
  
  build() {
    Column() {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
        .textAlign(TextAlign.Start)
      
      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(DesignTokens.Colors.secondary)
        .textAlign(TextAlign.Start)
      
      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(new Color(DesignTokens.Colors.onSurface).withOpacity(0.7))
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18)
    .margin({ bottom: DesignTokens.Spacing.sm })
  }
}

// MARK: - Sets List Section
@Component
struct SetsListSection {
  sets: MacroSet[] = []
  
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
  set: MacroSet = { title: "", reps: "", phase: "" }
  
  build() {
    Row() {
      Column() {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)
        
        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(new Color(DesignTokens.Colors.onSurface).withOpacity(0.7))
          .textAlign(TextAlign.Start)
      }
      
      Flex().alignItems(FlexAlign.Center).justifyContent(FlexAlign.End)
      
      Column() {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignTokens.Colors.primary)
          .textAlign(TextAlign.End)
        
        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Text("Start")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSecondary)
        }
        .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs })
        .padding({ top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
        .backgroundColor(DesignTokens.Colors.secondary)
        .borderRadius(8)
      }
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(new Color(DesignTokens.Colors.surfaceVariant).withOpacity(0.9))
    .borderRadius(18)
    .margin({ bottom: DesignTokens.Spacing.md })
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  targetPhase: string = ""
  
  build() {
    Row() {
      Column() {
        Text("Next macro")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)
        
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)
      }
      
      Flex().alignItems(FlexAlign.Center).justifyContent(FlexAlign.End)
      
      Button({ type: ButtonType.Capsule, stateEffect: true }) {
        Text("Prime")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
      }
      .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl })
      .padding({ top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
      .backgroundColor(DesignTokens.Colors.secondary)
      .borderRadius(18)
    }
    .width('100%')
    .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
    .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    .height(80)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .shadow({ radius: 12, color: new Color('#000000').withOpacity(0.26), offsetY: -6 })
  }
}