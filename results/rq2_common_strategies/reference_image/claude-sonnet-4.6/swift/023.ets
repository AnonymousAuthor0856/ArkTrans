// RootScreen.ets
import { Colors, TypographyTokens, Spacing, ElevationMapping, shadowColor } from './AppTokens';

// Geometry constants (SwiftUI used a 280pt stack with a 180pt inner track).
const CIRCLE_SIZE: number = 280;
const INNER_CIRCLE_SIZE: number = 180;
const KNOB_SIZE: number = 60;
const TRACK_RADIUS: number = INNER_CIRCLE_SIZE / 2; // 90
const CIRCLE_CENTER: number = CIRCLE_SIZE / 2;      // 140
const BUTTON_SIZE: number = 90;

@Entry
@Component
struct RootScreen {
  @State isRunning: boolean = false;
  // Knob offset from the centre of the 280x280 stack (SwiftUI: position - centre).
  @State knobDX: number = 0;
  @State knobDY: number = 0;

  private panStartDX: number = 0;
  private panStartDY: number = 0;

  /** Project the candidate offset onto the inner track of radius 90. */
  private moveKnobToTrack(dx: number, dy: number): void {
    const distance: number = Math.sqrt(dx * dx + dy * dy);
    if (distance < 0.001) {
      return;
    }
    this.knobDX = dx / distance * TRACK_RADIUS;
    this.knobDY = dy / distance * TRACK_RADIUS;
  }

  build() {
    Column() {
      // Spacer(16) above the title, matching the original top bar.
      Row()
        .height(Spacing.lg)
        .width('100%')

      // MARK: - Top bar (64 high, centred title)
      Row() {
        Text('Pomodoro Timer')
          .fontSize(TypographyTokens.displaySize)
          .fontWeight(TypographyTokens.displayWeight)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      // MARK: - Main content
      Column({ space: Spacing.xl }) {

        // Timer circle: outer background + inner track + draggable knob
        Stack() {
          // Outer circle (surfaceVariant) with elevation level 2
          Circle()
            .fill(Colors.surfaceVariant)
            .width(CIRCLE_SIZE)
            .height(CIRCLE_SIZE)
            .shadow({
              radius: ElevationMapping.level2.radius,
              color: shadowColor(ElevationMapping.level2.opacity),
              offsetX: 0,
              offsetY: ElevationMapping.level2.offsetY
            })

          // Middle circle (secondary at 40% opacity)
          Circle()
            .fill('#66B4E3D0')
            .width(INNER_CIRCLE_SIZE)
            .height(INNER_CIRCLE_SIZE)

          // Knob, constrained to the 90-radius track
          Circle()
            .fill(Colors.primary)
            .width(KNOB_SIZE)
            .height(KNOB_SIZE)
            .position({
              x: CIRCLE_CENTER + this.knobDX,
              y: CIRCLE_CENTER + this.knobDY
            })
            .gesture(
              PanGesture({ fingers: 1, distance: 1 })
                .onActionStart(() => {
                  this.panStartDX = this.knobDX;
                  this.panStartDY = this.knobDY;
                })
                .onActionUpdate((event: GestureEvent) => {
                  const nextDX: number = this.panStartDX + event.offsetX;
                  const nextDY: number = this.panStartDY + event.offsetY;
                  this.moveKnobToTrack(nextDX, nextDY);
                })
            )
        }
        .width(CIRCLE_SIZE)
        .height(CIRCLE_SIZE)

        // Focus mode label
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(TypographyTokens.titleSize)
          .fontWeight(TypographyTokens.titleWeight)
          .fontColor(this.isRunning ? Colors.success : Colors.error)

        // Start / Stop buttons
        Row({ space: Spacing.lg }) {
          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Start')
              .fontSize(TypographyTokens.bodySize)
              .fontWeight(TypographyTokens.bodyWeight)
              .fontColor(Colors.onPrimary)
          }
          .width(BUTTON_SIZE)
          .height(BUTTON_SIZE)
          .borderRadius(BUTTON_SIZE / 2)
          .backgroundColor(Colors.primary)
          .onClick(() => {
            this.isRunning = true;
          })

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Stop')
              .fontSize(TypographyTokens.bodySize)
              .fontWeight(TypographyTokens.bodyWeight)
              .fontColor(Colors.onSecondary)
          }
          .width(BUTTON_SIZE)
          .height(BUTTON_SIZE)
          .borderRadius(BUTTON_SIZE / 2)
          .backgroundColor(Colors.tertiary)
          .onClick(() => {
            this.isRunning = false;
          })
        }

        // Progress bar, fixed at ~40% like the reference screenshot
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(Colors.surfaceVariant)

          Row()
            .width('40%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(Colors.primary)
        }
        .width('100%')
        .height(8)
        .padding({ left: Spacing.lg, right: Spacing.lg })
      }
      .width('100%')
      .padding({ top: Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}