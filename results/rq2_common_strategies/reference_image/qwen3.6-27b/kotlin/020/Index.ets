import { window } from '@kit.ArkUI';

// Token definitions matching the Kotlin source
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
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }
};

@Entry
@Component
struct RootScreen {
  @State knobPosition: Point = { x: 0, y: 0 };
  @State powerOn: boolean = false;
  private containerController: GridContainerController = new GridContainerController();

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
      Column() {
        GridContainer(this.containerController) {
          // Background Circle (Visual only)
          Circle()
            .width(200)
            .height(200)
            .fill(Color.Transparent)
            .borderWidth(0)
            .backgroundColor('#FFEBC8') // Using surfaceVariant for the large circle visual
            .opacity(0.5)
            .position({ x: '50%', y: '50%' })
            .mark('bg-circle')

          // Draggable Knob
          Circle()
            .width(48)
            .height(48)
            .fill(AppTokens.Colors.primary)
            .position({ x: this.knobPosition.x, y: this.knobPosition.y })
            .onAreaChange((oldValue: Area, newValue: Area) => {
              // Update position based on center of the new area relative to parent
              // Note: In a real app, you'd calculate delta. Here we just set absolute for simplicity 
              // or use gesture events below.
            })
            .gesture(
              PanGesture()
                .onActionUpdate((event?: GestureEvent) => {
                  if (event) {
                    let newX = this.knobPosition.x + event.offsetX;
                    let newY = this.knobPosition.y + event.offsetY;
                    
                    // Simple boundary check (approximate square bounds)
                    const limit = 120; // Half of 280 minus padding/knob size approx
                    if (newX > -limit && newX < limit) {
                      this.knobPosition.x = newX;
                    }
                    if (newY > -limit && newY < limit) {
                      this.knobPosition.y = newY;
                    }
                  }
                })
            )
            .mark('knob')
        }
        .width(280)
        .height(280)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(24)
        .shadow({ radius: 10, color: '#0000001A', offsetY: 4 })
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        
        // Power Status Text
        Text(this.powerOn ? "Power: ON" : "Power: OFF")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.powerOn ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ top: AppTokens.Spacing.xl })

        // Buttons Row
        Row() {
          // On/Off Button
          Button(this.powerOn ? "Off" : "On")
            .type(ButtonType.Circle)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width(80)
            .height(80)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

          // Reset Button
          Button("Reset")
            .type(ButtonType.Circle)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width(80)
            .height(80)
            .margin({ left: AppTokens.Spacing.xl })
            .onClick(() => {
              this.knobPosition = { x: 0, y: 0 };
            })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: AppTokens.Spacing.xl })

        // Progress Indicator
        ProgressBar({ value: this.calculateProgress(), total: 100 })
          .width('100%')
          .height(6)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .color(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.xl })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private calculateProgress(): number {
    // Mimicking the Kotlin logic: (knobPosition.x + knobPosition.y) % 400 / 400f
    // Adjusted for ArkTS coordinate system where 0,0 is top-left
    // We add an offset to make it positive and meaningful in this context
    const val = (this.knobPosition.x + this.knobPosition.y + 400) % 400;
    return (val / 400) * 100;
  }
}