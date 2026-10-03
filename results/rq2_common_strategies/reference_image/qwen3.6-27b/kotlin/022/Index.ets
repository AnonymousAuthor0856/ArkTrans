import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---

const NAME = "022GanttCharten";
const UI_TYPE = "Productivity";
const STYLE_THEME = "Glassmorphic";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

interface ShadowSpec {
  elevation: number; // vp
  radius: number;    // vp
  dy: number;        // vp
  opacity: number;   // 0-1
}

class AppTokens {
  static Colors = {
    primary: '#38BDF8',
    secondary: '#6366F1',
    tertiary: '#A5B4FC',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#D1D5DB',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static TypographyTokens = {
    display: { fontSize: 26, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpec,
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.16 } as ShadowSpec
  };
}

// --- Data Models ---

interface Task {
  name: string;
  progress: number;
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  private tasks: Task[] = [
    { name: "Design Phase", progress: 0.8 },
    { name: "Development", progress: 0.5 },
    { name: "Testing", progress: 0.3 },
    { name: "Documentation", progress: 0.6 },
    { name: "Deployment", progress: 0.2 }
  ];

  build() {
    Column() {
      // Top Bar Area (Simulated)
      Row() {
        Text("Project Timeline")
          .font-size(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        
        // Notifications Row
        Row() {
          Text("Notifications")
            .font-size(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .selectedColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Task List
        List({ space: AppTokens.Spacing.md }) {
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              Column({ space: AppTokens.Spacing.sm }) {
                Text(task.name)
                  .font-size(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.primary)
                  .width('100%')

                // Progress Bar Container
                Stack({ alignContent: Alignment.Start }) {
                  // Track
                  Rect()
                    .fill(AppTokens.Colors.surfaceVariant)
                    .borderRadius(4) // Half of height 8
                    .height(8)
                  
                  // Fill
                  Rect()
                    .fill(AppTokens.Colors.secondary)
                    .borderRadius(4)
                    .height(8)
                    .width(`${task.progress * 100}%`)
                }
                .width('100%')
                .height(8)

              }
              .padding(AppTokens.Spacing.md)
              .width('100%')
              .borderRadius(AppTokens.Shapes.large)
              .backgroundColor(Color.White)
              .opacity(0.7) // Simulating alpha 0.7
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              })
            }
          }, (item: Task) => item.name)
        }
        .layoutWeight(1)
        .width('100%')
        .listDirection(Axis.Vertical)
        .edgeEffect(EdgeEffect.Spring)

        // Add Task Button
        Button("Add Task")
          .type(ButtonType.Capsule)
          .width('100%')
          .height(52)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(255, 255, 255, 0.8)', 0],
          [AppTokens.Colors.background, 0.5],
          ['rgba(255, 255, 255, 0.8)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}