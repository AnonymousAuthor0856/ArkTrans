import { window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

// Token Definitions
interface AppTokenColors {
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

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppTokenShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensConfig {
  Colors: AppTokenColors;
  Spacing: AppTokenSpacing;
  Shapes: AppTokenShapes;
}

const AppTokens: AppTokensConfig = {
  Colors: {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFF8E1', // Adjusted slightly for ArkTS contrast if needed, keeping original hex
    surface: '#FFF8E1',
    surfaceVariant: '#FCE7E7',
    outline: '#BDBDBD',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1F1F1F',
    onTertiary: '#1F1F1F',
    onBackground: '#1F1F1F',
    onSurface: '#1F1F1F'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  Shapes: {
    small: 6,
    medium: 12,
    large: 16
  }
};

interface Point {
  x: number;
  y: number;
}

interface IDrawTask {
  draw(context: CanvasRenderingContext2D): void;
}

class KnobDrawTask implements IDrawTask {
  private pos: Point;

  constructor(pos: Point) {
    this.pos = pos;
  }

  draw(context: CanvasRenderingContext2D): void {
    const centerX = 140;
    const centerY = 140;
    
    // Clear previous frame if necessary, though usually handled by system
    // Draw Outer Ring
    context.beginPath();
    context.arc(centerX, centerY, 120, 0, 2 * Math.PI);
    context.lineWidth = 12;
    context.strokeStyle = AppTokens.Colors.secondary;
    context.stroke();

    // Draw Knob
    context.beginPath();
    context.arc(this.pos.x, this.pos.y, 20, 0, 2 * Math.PI);
    context.fillStyle = AppTokens.Colors.primary;
    context.fill();
  }
}

@Entry
@Component
struct RootScreen {
  @State knobPosition: Point = { x: 140, y: 140 };

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Retro Music Player")
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Knob Container
        Stack({ alignContent: Alignment.Center }) {
          // Background Circle/Box
          Rect()
            .width(280)
            .height(280)
            .borderRadius(AppTokens.Shapes.large)
            .fill(AppTokens.Colors.surface)
            .border({ width: 3, color: AppTokens.Colors.outline })

          // Canvas for drawing the track and knob
          Canvas()
            .width(280)
            .height(280)
            .onReady((context: CanvasRenderingContext2D) => {
              const task = new KnobDrawTask(this.knobPosition);
              task.draw(context);
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Down || event.type === TouchType.Move) {
                const touchPoint = event.touches[0].windowX;
                const touchY = event.touches[0].windowY;
                
                // Calculate relative position within the canvas
                // Note: In a real app, we'd use getLocalPoint or similar to be precise relative to the component bounds
                // For this simplified conversion, we assume the canvas is centered and handle basic dragging logic
                // A more robust implementation would calculate offsets based on component global position
                
                // Simplified drag update for demonstration purposes
                // We clamp values roughly to the box size (280x280) centered at 140,140
                let newX = touchPoint - 140; 
                let newY = touchY - 140;
                
                // Basic clamping to keep knob inside circle radius approx 120
                const maxRadius = 120;
                const dist = Math.sqrt(newX * newX + newY * newY);
                if (dist > maxRadius) {
                  const scale = maxRadius / dist;
                  newX *= scale;
                  newY *= scale;
                }

                this.knobPosition = { x: newX + 140, y: newY + 140 };
              }
            })
        }
        .width(280)
        .height(280)
        .margin({ bottom: 20 })

        // Track Info
        Text("Track: Summer Nights")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: 20 })

        // Controls
        Row() {
          Button("Play")
            .width(120)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.medium)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              // Play action
            })

          Button("Pause")
            .width(120)
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.medium)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 20 })
            .onClick(() => {
              // Pause action
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 20 })

        // Debug Info
        Text(`Knob X:${Math.round(this.knobPosition.x)} Y:${Math.round(this.knobPosition.y)}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)

        Blank().height(AppTokens.Spacing.xxl)
      }
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Ability Entry Point
export default class EntryAbility extends UIAbility {
  onCreate(want: Want | null, launchParam: common.UIAbilityContext['LaunchParam'] | null): void {
    // Initialization
  }

  onDestroy(): void {
    // Cleanup
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for ability.
    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        console.error('Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading content. Data:' + JSON.stringify(data));
    });
    
    // Set full screen mode similar to Android code
    const windowClass = windowStage.getMainWindowSync();
    windowClass.setWindowLayoutFullScreen(true);
  }
}