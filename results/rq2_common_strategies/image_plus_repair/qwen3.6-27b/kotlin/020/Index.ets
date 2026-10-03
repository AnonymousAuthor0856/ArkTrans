import { window } from '@kit.ArkUI';

// Token definitions matching the Kotlin source
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

const AppTokens = {
  Colors: {
    primary: '#FF7A00',
    secondary: '#FFC300',
    tertiary: '#FFF3C0',
    background: '#FFF8E7',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEBC8',
    outline: '#BCA789',
    success: '#28A745',
    warning: '#FFC107',
    error: '#DC3545',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  } as AppTokenColors,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  } as AppTokenSpacing
};

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State knobPosition: Point = { x: 0, y: 0 };
  @State powerOn: boolean = false;
  private containerWidth: number = 0;
  private containerHeight: number = 0;

  build() {
    Column() {
      // Top Bar / Title
      Text("Retro Remote Control")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: AppTokens.Spacing.xl })

      // Main Knob Area
      Stack({ alignContent: Alignment.TopStart }) {
        // Background Card
        Column() {
          // The large faint circle in the center of the card
          Circle({ width: '100%', height: '100%' })
            .fill(Color.Transparent)
            .borderWidth(0)
            .position({ x: '50%', y: '50%' })
            .translate({ x: '-50%', y: '-50%' })
            .width('70%')
            .height('70%')
            .backgroundColor('#FFEBC8') // Using surfaceVariant for the inner circle look
            .opacity(0.5)
        }
        .width(280)
        .height(280)
        .borderRadius(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({ radius: 10, color: '#0000001A', offsetY: 4 })

        // Draggable Knob
        Circle({ width: 48, height: 48 })
          .backgroundColor(AppTokens.Colors.primary)
          .position({ x: this.knobPosition.x, y: this.knobPosition.y })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Move) {
              let newX = event.touches[0].x - 24; // Center offset
              let newY = event.touches[0].y - 24;
              
              // Clamp within bounds (approximate based on visual)
              if (newX < 0) newX = 0;
              if (newY < 0) newY = 0;
              if (newX > 232) newX = 232; // 280 - 48
              if (newY > 232) newY = 232;

              this.knobPosition = { x: newX, y: newY };
            }
          })
      }
      .width(280)
      .height(280)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .margin({ top: AppTokens.Spacing.lg })

      // Power Status Text
      Text(this.powerOn ? "Power: ON" : "Power: OFF")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)
        .margin({ top: AppTokens.Spacing.xl })

      // Buttons Row
      Row() {
        // On/Off Button
        Column() {
          Text(this.powerOn ? "Off" : "On")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width(80)
        .height(80)
        .borderRadius(40)
        .backgroundColor(AppTokens.Colors.primary)
        .onClick(() => {
          this.powerOn = !this.powerOn;
        })

        // Reset Button
        Column() {
          Text("Reset")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .width(80)
        .height(80)
        .borderRadius(40)
        .backgroundColor(AppTokens.Colors.secondary)
        .onClick(() => {
          this.knobPosition = { x: 0, y: 0 };
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: AppTokens.Spacing.xxl })

      // Progress Indicator
      Row() {
        // Track
        Row()
          .width('100%')
          .height(6)
          .borderRadius(3)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
        
        // Fill
        Row()
          .width(`${Math.min(((this.knobPosition.x + this.knobPosition.y) % 400) / 400 * 100, 100)}%`)
          .height(6)
          .borderRadius(3)
          .backgroundColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.xl })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}