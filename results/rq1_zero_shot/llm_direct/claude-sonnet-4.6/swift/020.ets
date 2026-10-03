import { display } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: ResourceColor = '#FF7A00';
  static readonly secondary: ResourceColor = '#FFC300';
  static readonly tertiary: ResourceColor = '#FFF3C0';
  static readonly background: ResourceColor = '#FFF8E7';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#FFEBC8';
  static readonly outline: ResourceColor = '#BCA789';
  static readonly success: ResourceColor = '#28A745';
  static readonly warning: ResourceColor = '#FFC107';
  static readonly error: ResourceColor = '#DC3545';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#1E1E1E';
  static readonly onTertiary: ResourceColor = '#1E1E1E';
  static readonly onBackground: ResourceColor = '#1E1E1E';
  static readonly onSurface: ResourceColor = '#1E1E1E';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State knobX: number = 90;
  @State knobY: number = 140;
  @State powerOn: boolean = false;

  build() {
    Column({ space: 0 }) {
      // Top spacer
      Blank()
        .height(40)
        .backgroundColor(AppColors.background)

      // Top Bar
      Stack() {
        Text('Retro Remote Control')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.background)

      // Scroll Content
      Scroll() {
        Column({ space: AppSpacing.xl }) {

          // Knob Surface
          Stack() {
            // Background fill
            Column()
              .width(280)
              .height(280)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(24)

            // Background circle (decorative)
            Column()
              .width(200)
              .height(200)
              .borderRadius(100)
              .backgroundColor('#33FFC300')

            // Knob circle
            Column()
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor(AppColors.primary)
              .position({ x: this.knobX - 16, y: this.knobY - 16 })
          }
          .width(280)
          .height(280)
          .borderRadius(24)
          .clip(true)
          .shadow({
            radius: 4,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 2
          })
          .onTouch((event: TouchEvent) => {
            if (
              event.type === TouchType.Down ||
              event.type === TouchType.Move
            ) {
              const touch = event.touches[0];
              const rawX = touch.x;
              const rawY = touch.y;
              const boundedX = Math.max(16, Math.min(264, rawX));
              const boundedY = Math.max(16, Math.min(264, rawY));
              this.knobX = boundedX;
              this.knobY = boundedY;
            }
          })

          // Power Status
          Text(this.powerOn ? 'Power: ON' : 'Power: OFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.powerOn ? AppColors.success : AppColors.error)

          // Buttons Row
          Row({ space: 60 }) {
            // On Button
            Button({ type: ButtonType.Circle }) {
              Text('On')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
            }
            .width(80)
            .height(80)
            .backgroundColor(AppColors.primary)
            .onClick(() => {
              this.powerOn = !this.powerOn;
            })

            // Reset Button
            Button({ type: ButtonType.Circle }) {
              Column({ space: 0 }) {
                Text('Res')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
                Text('et')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSecondary)
              }
            }
            .width(80)
            .height(80)
            .backgroundColor(AppColors.secondary)
            .onClick(() => {
              this.knobX = 90;
              this.knobY = 140;
            })
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

          // Progress Bar (full red)
          Column()
            .width('100%')
            .height(6)
            .backgroundColor(AppColors.primary)
            .borderRadius(3)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

        }
        .padding(AppSpacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .scrollable(ScrollDirection.Vertical)
      .backgroundColor(AppColors.background)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}