// Retro Group Buy - ArkTS conversion
// ECommerce - Retro Flat style

import prompt from '@ohos.prompt';

// Color tokens
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
}

// Pin data class
interface Pin {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RetroGroupBuy {
  @State pins: Pin[] = [
    { x: 150, y: 150, label: 'Group A' },
    { x: 320, y: 280, label: 'Group B' },
    { x: 280, y: 360, label: 'Group C' }
  ];

  build() {
    Column() {
      // Title
      Text('Retro Group Buy')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .margin({ bottom: 24 });

      // Live Deals Map Card
      Column() {
        Text('Live Deals Map')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .margin({ bottom: 20 });

        // Map canvas area
        Stack({ alignContent: Alignment.TopStart }) {
          Canvas(this.paintMap.bind(this))
            .width('100%')
            .height(320)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(20);
        }
        .width('100%')
        .height(320)
        .borderRadius(20);
      }
      .width('100%')
      .padding(24)
      .backgroundColor(AppColors.surface)
      .borderRadius(32)
      .shadow({
        radius: 16,
        color: 'rgba(0, 0, 0, 0.15)',
        offsetX: 0,
        offsetY: 6
      });

      // Buttons Row
      Row() {
        Button('Add Group')
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.secondary)
          .fontColor(AppColors.onSecondary)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .height(80)
          .borderRadius(20)
          .flexGrow(1)
          .onClick(() => {
            const newPin: Pin = {
              x: 50 + Math.random() * 280,
              y: 50 + Math.random() * 220,
              label: 'New'
            };
            this.pins.push(newPin);
          });

        Blank()
          .width(16);

        Button('Clear')
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .height(80)
          .borderRadius(20)
          .flexGrow(1)
          .onClick(() => {
            this.pins = [];
          });
      }
      .width('100%')
      .margin({ top: 24, bottom: 24 });

      // Active Groups Card
      Column() {
        Text('Active Groups')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')
          .margin({ bottom: 12 });

        ForEach(this.pins, (pin: Pin) => {
          Row() {
            Text(pin.label)
              .fontSize(24)
              .fontColor(AppColors.onSurface)
              .flexGrow(1);

            Circle({ width: 24, height: 24 })
              .fill(AppColors.primary);
          }
          .width('100%')
          .padding({ top: 8, bottom: 8 });
        }, (pin: Pin, index: number) => index.toString() + pin.label);
      }
      .width('100%')
      .padding(24)
      .backgroundColor(AppColors.surface)
      .borderRadius(32)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.1)',
        offsetX: 0,
        offsetY: 2
      });
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(AppColors.background);
  }

  // Draw map pins on canvas
  private paintMap(ctr: CanvasRenderingContext2D): void {
    // Draw pins
    for (let i = 0; i < this.pins.length; i++) {
      const pin = this.pins[i];
      ctr.beginPath();
      ctr.arc(pin.x, pin.y, 22, 0, Math.PI * 2);
      ctr.fillStyle = AppColors.primary;
      ctr.fill();
    }
  }
}
