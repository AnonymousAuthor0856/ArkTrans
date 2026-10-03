// entry/src/main/ets/components/MetroPlanner.ets

/**
 * Metro Planner UI Component
 * Converted from SwiftUI to ArkTS (HarmonyOS)
 */

interface ColorConfig {
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
  onBackground: string;
  onSurface: string;
}

interface TypographyItem {
  size: number;
  weight: FontWeight;
}

interface TypographyConfig {
  display: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
}

interface ShapesConfig {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingConfig {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationConfig {
  level2: ElevationLevel;
}

@Entry
@Component
struct MetroPlanner {
  // MARK: - AppTokens (Design System Constants)
  
  private static readonly COLORS: ColorConfig = {
    primary: '#00FFFF',       // Cyan
    secondary: '#00B4FF',     // Light Blue
    tertiary: '#8A2BE2',      // Blue Violet
    background: '#0A0A1A',    // Dark Navy
    surface: '#141436',       // Darker Purple-Blue
    surfaceVariant: '#1E1E4A',// Even Darker Purple-Blue
    outline: '#2E2E5C',       // Dark Purple-Blue
    success: '#00FFAA',       // Greenish Cyan
    warning: '#FFCC00',       // Yellow
    error: '#FF4444',         // Red
    onPrimary: '#0A0A1A',     // Dark Navy (on primary)
    onSecondary: '#FFFFFF',   // White
    onBackground: '#FFFFFF',  // White
    onSurface: '#FFFFFF'      // White
  }

  private static readonly TYPOGRAPHY: TypographyConfig = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  private static readonly SHAPES: ShapesConfig = {
    smallCornerRadius: 8,
    mediumCornerRadius: 14,
    largeCornerRadius: 22
  }

  private static readonly SPACING: SpacingConfig = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  private static readonly ELEVATION: ElevationConfig = {
    level2: { radius: 8, dy: 4, opacity: 0.15 }
  }

  // MARK: - State & Data
  
  @State stations: string[] = ["A", "B", "C", "D", "E", "F"]
  @State departures: string[] = ["08:45 • Line 1", "09:10 • Line 2", "09:30 • Line 3"]
  
  // Layout constants
  private readonly bottomBarHeight: number = 56
  private readonly fabSize: number = 56

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      
      // MARK: - Main Content Area
      
      Column() {
        // Title
        Text("Metro Planner")
          .font({ size: MetroPlanner.TYPOGRAPHY.display.size, weight: MetroPlanner.TYPOGRAPHY.display.weight })
          .foregroundColor(Color(MetroPlanner.COLORS.primary))
          .width('100%')
          .textAlign(TextAlign.Start)
        
        // Canvas for drawing the metro line and stations
        this.MetroCanvas()
        
        // Next Departures Card
        this.DepartureCard()
        
        Flex({ justifyContent: FlexAlign.End }) {
          Blank()
        }
      }
      .padding({ top: MetroPlanner.SPACING.lg, bottom: this.bottomBarHeight })
      .width('100%')
      .height('100%')
      .backgroundColor(Color(MetroPlanner.COLORS.background))
      // Vertical gradient background simulation using linearGradient
      .linearGradient({
        angle: 180,
        colors: [
          [MetroPlanner.COLORS.background, 0],
          [MetroPlanner.COLORS.surfaceVariant, 0.5],
          [MetroPlanner.COLORS.background, 1]
        ]
      })

      // MARK: - Floating Action Button (FAB)
      
      Row() {
        Button() {
          Text("+")
            .font({ size: MetroPlanner.TYPOGRAPHY.title.size, weight: MetroPlanner.TYPOGRAPHY.title.weight })
            .fontSize(32) // Make plus sign larger visually
            .fontColor(Color(MetroPlanner.COLORS.onPrimary))
        }
        .type(ButtonType.Circle)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(Color(MetroPlanner.COLORS.primary))
        .shadow({
          radius: MetroPlanner.ELEVATION.level2.radius,
          color: Color(MetroPlanner.COLORS.outline).withOpacity(MetroPlanner.ELEVATION.level2.opacity),
          offsetX: 0,
          offsetY: MetroPlanner.ELEVATION.level2.dy
        })
      }
      .alignSelf(ItemAlign.End)
      .margin({ right: MetroPlanner.SPACING.lg, bottom: this.bottomBarHeight + MetroPlanner.SPACING.lg })

      // MARK: - Bottom App Bar
      
      Row() {
        this.BottomNavItem("Routes", true)
        this.BottomNavItem("Planner", false)
        this.BottomNavItem("Tickets", false)
        this.BottomNavItem("Profile", false)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor(Color(MetroPlanner.COLORS.surface))
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color(MetroPlanner.COLORS.background))
  }

  // MARK: - Sub-Components

  @Builder
  MetroCanvas() {
    Canvas(new DrawingRenderingContext())
      .onReady((context: CanvasRenderingContext2D, canvasInfo: CanvasRenderingContext2D) => {
        const width = canvasInfo.width
        const height = canvasInfo.height
        const stationCount = this.stations.length
        const step = width / (stationCount - 1)
        
        // Draw Path
        context.beginPath()
        for (let i = 0; i < stationCount; i++) {
          const x = i * step
          const y = i % 2 === 0 ? height / 4 : height * 3 / 4
          
          if (i === 0) {
            context.moveTo(x, y)
          } else {
            context.lineTo(x, y)
          }
        }
        
        // Stroke with Gradient
        const gradient = context.createLinearGradient(0, 0, width, 0)
        gradient.addColorStop(0, MetroPlanner.COLORS.secondary)
        gradient.addColorStop(1, MetroPlanner.COLORS.primary)
        
        context.lineWidth = 6
        context.strokeStyle = gradient
        context.stroke()
        
        // Draw Stations
        for (let i = 0; i < stationCount; i++) {
          const x = i * step
          const y = i % 2 === 0 ? height / 4 : height * 3 / 4
          
          // Outer Circle
          context.beginPath()
          context.arc(x, y, 16, 0, Math.PI * 2)
          context.fillStyle = MetroPlanner.COLORS.primary
          context.fill()
          
          // Inner Circle
          context.beginPath()
          context.arc(x, y, 6, 0, Math.PI * 2)
          context.fillStyle = MetroPlanner.COLORS.background
          context.fill()
        }
      })
      .width('100%')
      .height(260)
      .padding({ left: MetroPlanner.SPACING.md, right: MetroPlanner.SPACING.md })
      .backgroundColor(Color(MetroPlanner.COLORS.surfaceVariant))
      .borderRadius(MetroPlanner.SHAPES.largeCornerRadius)
      .margin({ left: MetroPlanner.SPACING.lg, right: MetroPlanner.SPACING.lg })
  }

  @Builder
  DepartureCard() {
    Column({ space: MetroPlanner.SPACING.sm }) {
      Text("Next Departures")
        .font({ size: MetroPlanner.TYPOGRAPHY.title.size, weight: MetroPlanner.TYPOGRAPHY.title.weight })
        .fontColor(Color(MetroPlanner.COLORS.secondary))
      
      ForEach(this.departures, (departure: string) => {
        Row() {
          Text(departure)
            .font({ size: MetroPlanner.TYPOGRAPHY.body.size, weight: MetroPlanner.TYPOGRAPHY.body.weight })
            .fontColor(Color(MetroPlanner.COLORS.onSurface))
          
          Flex({ justifyContent: FlexAlign.End }) {
            Blank()
          }
          
          Text("On Time")
            .font({ size: MetroPlanner.TYPOGRAPHY.label.size, weight: MetroPlanner.TYPOGRAPHY.label.weight })
            .fontColor(Color(MetroPlanner.COLORS.success))
        }
      })
    }
    .padding(MetroPlanner.SPACING.lg)
    .width('100%')
    .backgroundColor(Color(MetroPlanner.COLORS.surface))
    .borderRadius(MetroPlanner.SHAPES.largeCornerRadius)
    .shadow({
      radius: MetroPlanner.ELEVATION.level2.radius,
      color: Color(MetroPlanner.COLORS.outline).withOpacity(MetroPlanner.ELEVATION.level2.opacity),
      offsetX: 0,
      offsetY: MetroPlanner.ELEVATION.level2.dy
    })
    .margin({ left: MetroPlanner.SPACING.lg, right: MetroPlanner.SPACING.lg })
  }

  @Builder
  BottomNavItem(label: string, isActive: boolean) {
    Text(label)
      .font({ size: MetroPlanner.TYPOGRAPHY.body.size, weight: MetroPlanner.TYPOGRAPHY.body.weight })
      .fontColor(isActive ? Color(MetroPlanner.COLORS.secondary) : Color(MetroPlanner.COLORS.onSurface))
  }
}