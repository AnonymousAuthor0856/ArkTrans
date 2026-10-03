import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---

const NAME = "022GanttCharten";
const UI_TYPE = "Productivity";
const STYLE_THEME = "Glassmorphic";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

interface ShadowSpec {
  elevation: number; // in vp
  radius: number;    // in vp
  dy: number;        // in vp
  opacity: number;   // 0-1
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#38BDF8';
    export const secondary: string = '#6366F1';
    export const tertiary: string = '#A5B4FC';
    export const background: string = '#F1F5F9';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E2E8F0';
    export const outline: string = '#D1D5DB';
    export const success: string = '#22C55E';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#1E1E1E';
    export const onTertiary: string = '#1E1E1E';
    export const onBackground: string = '#1E1E1E';
    export const onSurface: string = '#1E1E1E';
  }

  export interface TypographyToken {
    fontSize: number;
    fontWeight: FontWeight;
  }

  export namespace TypographyTokens {
    export const display: TypographyToken = { fontSize: 26, fontWeight: FontWeight.Bold };
    export const title: TypographyToken = { fontSize: 18, fontWeight: FontWeight.Medium };
    export const body: TypographyToken = { fontSize: 14, fontWeight: FontWeight.Normal };
    export const label: TypographyToken = { fontSize: 12, fontWeight: FontWeight.Medium };
  }

  export namespace Shapes {
    export const small = 6; // vp
    export const medium = 10; // vp
    export const large = 16; // vp
  }

  export namespace Spacing {
    export const xs = 4; // vp
    export const sm = 8; // vp
    export const md = 12; // vp
    export const lg = 16; // vp
    export const xl = 24; // vp
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
    export const level2: ShadowSpec = { elevation: 4, radius: 8, dy: 4, opacity: 0.16 };
  }
}

// --- Data Models ---

interface Task {
  name: string;
  progress: number; // 0.0 to 1.0
}

// --- Components ---

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
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60) // Approximate height for top bar
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
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
              Column() {
                Text(task.name)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.primary)
                  .width('100%')
                  .margin({ bottom: AppTokens.Spacing.sm })

                // Progress Bar
                Stack({ alignContent: Alignment.Start }) {
                  // Track
                  Rect()
                    .fill(AppTokens.Colors.surfaceVariant)
                    .borderRadius(4) // Half of height 8
                    .height(8)
                  
                  // Indicator
                  Rect()
                    .fill(AppTokens.Colors.secondary)
                    .borderRadius(4)
                    .height(8)
                    .width(`${Math.round(task.progress * 100)}%`)
                }
                .width('100%')
                .clip(true)
              }
              .padding(AppTokens.Spacing.md)
              .width('100%')
              .backgroundColor(Color.White)
              .opacity(0.7) // Simulating alpha 0.7
              .borderRadius(AppTokens.Shapes.large)
              .shadow({
                radius: AppTokens.ElevationMapping.level1.radius,
                color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level1.dy
              })
            }
          }, (task: Task) => task.name)
        }
        .layoutWeight(1)
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

        // Add Task Button
        Button("Add Task")
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .height(52)
          .width('100%')
          .onClick(() => {
            // Handle add task
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.surface, 0.8],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 0.8]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}