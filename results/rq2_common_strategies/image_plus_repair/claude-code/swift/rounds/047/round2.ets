import promptAction from '@ohos.promptAction';

// Shadow spec interface
interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

// Design tokens
class AppColors {
  static primary: string = '#FF8C00';
  static secondary: string = '#FFC107';
  static tertiary: string = '#FFE082';
  static background: string = '#FFF8E1';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFECB3';
  static outline: string = '#D7CCC8';
  static success: string = '#4CAF50';
  static warning: string = '#FFB300';
  static error: string = '#E53935';
  static onPrimary: string = '#3E2723';
  static onSecondary: string = '#3E2723';
  static onBackground: string = '#3E2723';
  static onSurface: string = '#3E2723';

  static shadowOnSurface(opacity: number): string {
    const alpha: number = Math.floor(opacity * 255);
    const hex: string = alpha.toString(16).padStart(2, '0');
    return '#' + hex + '3E2723';
  }
}

class AppSpacing {
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 16;
  static xl: number = 24;
}

class AppShapes {
  static small: number = 6;
  static medium: number = 10;
  static large: number = 16;
}

class AppTypography {
  static displaySize: number = 28;
  static titleSize: number = 18;
  static bodySize: number = 14;
  static labelSize: number = 12;
}

class AppElevation {
  static level1: ShadowSpec = { radius: 4, y: 2, opacity: 0.1 };
  static level2: ShadowSpec = { radius: 8, y: 4, opacity: 0.15 };
  static level3: ShadowSpec = { radius: 12, y: 6, opacity: 0.18 };
}

// Pin data model
interface Pin {
  id: string;
  x: number;
  y: number;
  label: string;
}

// Helper to generate unique IDs
function generateId(): string {
  const t: number = Date.now();
  const r: number = Math.floor(Math.random() * 1000000);
  return t.toString() + r.toString();
}

@Component
struct PinDot {
  @ObjectLink pin: Pin;

  build() {
    Row() {
    }
    .width(28)
    .height(28)
    .borderRadius(14)
    .backgroundColor(AppColors.primary)
    .position({ x: this.pin.x - 14, y: this.pin.y - 14 });
  }
}

@Component
export struct RootScreen {
  @State pins: Pin[] = [
    { id: 'pin1', x: 150, y: 250, label: 'Group A' },
    { id: 'pin2', x: 350, y: 420, label: 'Group B' },
    { id: 'pin3', x: 520, y: 310, label: 'Group C' }
  ];

  private addGroup(): void {
    const randomX: number = 100 + Math.random() * 450;
    const randomY: number = 150 + Math.random() * 300;
    const newPin: Pin = { id: generateId(), x: randomX, y: randomY, label: 'New' };
    this.pins.push(newPin);
  }

  private clearGroups(): void {
    this.pins = [];
  }

  build() {
    Column() {
      Stack() {
        Column() {
        }
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background);

        Column({ space: AppSpacing.lg }) {
          Text('Retro Group Buy')
            .fontSize(AppTypography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%');

          // Live Deals Map Card
          Column({ space: AppSpacing.md }) {
            Text('Live Deals Map')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .width('100%');

            Stack({ alignContent: Alignment.TopStart }) {
              ForEach(this.pins, (pin: Pin) => {
                PinDot({ pin: pin })
              }, (pin: Pin) => pin.id)
            }
            .width('100%')
            .height(220)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium);
          }
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level2.radius,
            color: AppColors.shadowOnSurface(AppElevation.level2.opacity),
            offsetY: AppElevation.level2.y
          });

          Row()
            .height(AppSpacing.sm);

          // Buttons Row
          Row({ space: AppSpacing.md }) {
            Button('Add Group')
              .fontSize(AppTypography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(AppShapes.medium)
              .height(48)
              .layoutWeight(1)
              .onClick(() => {
                this.addGroup();
              });

            Button('Clear')
              .fontSize(AppTypography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
              .height(48)
              .layoutWeight(1)
              .onClick(() => {
                this.clearGroups();
              });
          }
          .width('100%');

          // Active Groups Card
          Column({ space: AppSpacing.sm }) {
            Text('Active Groups')
              .fontSize(AppTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)
              .width('100%');

            ForEach(this.pins, (pin: Pin) => {
              Row() {
                Text(pin.label)
                  .fontSize(AppTypography.bodySize)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppColors.onSurface)
                  .layoutWeight(1);

                Row() {
                }
                .width(14)
                .height(14)
                .borderRadius(7)
                .backgroundColor(AppColors.primary);
              }
              .width('100%');
            }, (pin: Pin) => pin.id);
          }
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({
            radius: AppElevation.level1.radius,
            color: AppColors.shadowOnSurface(AppElevation.level1.opacity),
            offsetY: AppElevation.level1.y
          });

          Blank();
        }
        .width('100%')
        .height('100%')
        .padding(AppSpacing.lg);
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%');
  }
}
