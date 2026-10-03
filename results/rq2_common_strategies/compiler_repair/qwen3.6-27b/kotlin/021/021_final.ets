import { window } from '@kit.ArkUI'

// --- App Tokens & Constants ---
const NAME = "021KanbanBoarden"
const UI_TYPE = "Productivity"
const STYLE_THEME = "Modern Blue"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

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

interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
}

class AppTokens {
  static Colors: ColorTokens = {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#3B82F6',
    background: '#F3F4F6',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#FFFFFF',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  static TypographyTokens: TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static Shapes: ShapeTokens = {
    small: 6, // dp
    medium: 10, // dp
    large: 14 // dp
  }

  static Spacing: SpacingTokens = {
    xs: 4, // vp
    sm: 8, // vp
    md: 12, // vp
    lg: 16, // vp
    xl: 24 // vp
  }
}

interface KanbanColumn {
  title: string;
  tasks: string[];
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  private columns: KanbanColumn[] = [
    { title: "To Do", tasks: ["Write report", "Design mockup"] },
    { title: "In Progress", tasks: ["Implement feature X", "Fix layout bug"] },
    { title: "Done", tasks: ["Team sync", "Client feedback"] }
  ];

  build() {
    Column() {
      // Top Bar Area (Simulating CenterAlignedTopAppBar)
      Row() {
        Text("Kanban Board")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56) // Standard top bar height approx
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column({ space: AppTokens.Spacing.lg }) {
        
        // Notifications Row
        Row() {
          Text("Notifications")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank() // Spacer

          Toggle({
            type: ToggleType.Switch,
            isOn: this.notificationsEnabled
          })
          .selectedColor(AppTokens.Colors.primary)
          .onChange((isSelected: boolean) => {
            this.notificationsEnabled = isSelected;
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // LazyRow for Columns
        Scroll() {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              // Card Container
              Column() {
                // Column Title
                Text(col.title)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.primary)
                  .margin({ bottom: AppTokens.Spacing.sm })

                // Tasks List
                Column({ space: AppTokens.Spacing.sm }) {
                  ForEach(col.tasks, (task: string) => {
                    // Assist Chip Simulation
                    Text(task)
                      .fontSize(AppTokens.TypographyTokens.body.fontSize)
                      .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .textAlign(TextAlign.Center)
                      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                      .backgroundColor(AppTokens.Colors.surfaceVariant)
                      .borderRadius(AppTokens.Shapes.medium)
                  })
                }
              }
              .width(220)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.16)', offsetY: 4 })
            })
          }
        }
        .width('100%')
        .layoutWeight(1) // Take available space
        .scrollable(ScrollDirection.Horizontal)
        .edgeEffect(EdgeEffect.Spring)

        // Task Completion Section
        Column() {
          Text("Task Completion")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: 8 })

          // LinearProgressIndicator Simulation
          Row() {
            // Background Track
            Row()
              .width('100%')
              .height(8)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(4)
            
            // Progress Fill
            Row()
              .width('65%')
              .height(8)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(4)
              .position({ x: 0, y: 0 })
          }
          .width('100%')
          .height(8)
          .clip(true)
        }
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}