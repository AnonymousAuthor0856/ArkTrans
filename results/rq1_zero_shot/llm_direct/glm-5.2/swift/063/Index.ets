// struct AppTokens
export struct AppTokens {
  static Colors = {
    primary: '#3B82F6',
    secondary: '#22C55E',
    background: '#F5F5F4',
    surface: '#FFFFFF',
    outline: '#D4D4D8',
    onPrimary: '#FFFFFF',
    onBackground: '#111827',
    onSurface: '#1F2937',
    accent: '#F59E0B'
  }
  
  static Typography = {
    display: (size: number = 24) => { return { size: size, weight: FontWeight.Bold } },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal }
  }
  
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 40
  }
}

// struct CustomTopBar
@Component
export struct CustomTopBar {
  build() {
    Row() {
      // Navigation Icon (Electric Car)
      Text('⚡')
        .fontSize(24)
        .fontColor(AppTokens.Colors.primary)
        .margin({ left: 8 })
      
      Blank()
      
      // Title
      Text('Charging Progress')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
      
      Blank()
      
      // Action Icon (Settings)
      Button('⚙') {
        // Action
      }
      .backgroundColor(Color.Transparent)
      .fontSize(24)
      .fontColor(AppTokens.Colors.accent)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// struct BatteryIcon
@Component
export struct BatteryIcon {
  private progress: number = 0.0;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // 电池主体 - 全蓝色
      Column() {
        // 电池顶部凸起
        Stack() {
          Column()
            .width(20)
            .height(10)
            .borderRadius(3)
            .backgroundColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .height(10)
        .justifyContent(FlexAlign.Center)

        // 电池主体
        Column()
          .width(50)
          .height(80)
          .borderRadius(8)
          .backgroundColor(AppTokens.Colors.primary)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
      }
      
      // 自定义闪电图标 - 更接近原图
      LightningBolt({ width: 25, height: 40 })
        .fillColor(AppTokens.Colors.onPrimary)
    }
    .width(60)
    .height(100)
  }
}

// 自定义闪电形状
@Extend(Text)
function lightningText() {
  .fontColor(Color.White)
}

// struct LightningBolt
@Component
export struct LightningBolt {
  private width: number = 25;
  private height: number = 40;
  private fillColor: string = '#FFFFFF';

  build() {
    Text('⚡')
      .fontSize(this.height * 0.8)
      .fontColor(this.fillColor)
      .width(this.width)
      .height(this.height)
      .textAlign(TextAlign.Center)
      .lineHeight(this.height)
  }
}

// struct CustomProgressBar
@Component
export struct CustomProgressBar {
  private progress: number = 0.0;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Column()
        .width('100%')
        .height('100%')
        .borderRadius(6)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 1, color: AppTokens.Colors.outline })
      
      // Indicator
      Column()
        .width(`${Math.min(Math.max(this.progress, 0), 1) * 100}%`)
        .height('100%')
        .borderRadius(6)
        .backgroundColor(AppTokens.Colors.primary)
        .margin(1)
    }
    .width('100%')
    .height('100%')
    .borderRadius(6)
    .clip(true)
  }
}

// struct RootScreen
@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.45;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
      
      Column() {
        // Top Bar
        CustomTopBar()
        
        // Content - 使用更紧凑的布局
        Column() {
          // 电池和百分比组合，紧贴顶部栏
          Column() {
            // Custom Vertical Battery Icon
            BatteryIcon({ progress: this.progress })
              .width(60)
              .height(100)
            
            // Percentage Text
            Text(`${Math.floor(this.progress * 100)}%`)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onBackground)
          }
          .margin({ top: AppTokens.Spacing.md })
          
          // Progress Bar
          CustomProgressBar({ progress: this.progress })
            .height(12)
            .width('70%')
            .margin({ top: AppTokens.Spacing.lg })
          
          // Simulate Button
          Button('Simulate Charge') {
            this.progress += 0.1;
            if (this.progress > 1.0) {
              this.progress = 0.0;
            }
          }
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(24)
          .margin({ top: AppTokens.Spacing.lg })
          
          // Status Text
          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.progress < 1.0 ? AppTokens.Colors.primary : AppTokens.Colors.secondary)
            .margin({ top: AppTokens.Spacing.md })
          
          Blank()
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .statusBarHidden(true)
  }
}