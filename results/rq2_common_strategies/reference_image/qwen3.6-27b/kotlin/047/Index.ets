// entry/src/main/ets/pages/Index.ets

import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// Define color tokens matching the original design
const AppColors = {
  primary: '#FF8C00',
  secondary: '#FFC107',
  tertiary: '#FFE082',
  background: '#FFF8E1',
  surface: '#FFFFFF',
  surfaceVariant: '#FFECB3',
  outline: '#D7CCC8',
  success: '#4CAF50',
  warning: '#FFB300',
  error: '#E53935',
  onPrimary: '#3E2723',
  onSecondary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723'
};

// Define spacing tokens
const Spacing = {
  sm: 6,
  md: 10,
  lg: 16,
  xl: 24
};

// Define shape radii
const Shapes = {
  small: 6,
  medium: 10,
  large: 16
};

// Data model for pins
interface Pin {
  x: number;
  y: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ];

  build() {
    Column() {
      // Title
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .margin({ top: Spacing.lg, bottom: Spacing.lg })

      // Live Deals Map Card
      Column() {
        Text('Live Deals Map')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg })

        // Map Area
        Row() {
          ForEach(this.pins, (pin: Pin) => {
            Circle({ width: 28, height: 28 })
              .fill(AppColors.primary)
              .position({ x: pin.x, y: pin.y })
          })
        }
        .width('100%')
        .height(220)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(Shapes.medium)
        .margin({ left: Spacing.md, right: Spacing.md, bottom: Spacing.lg })
        .clip(true)
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .borderRadius(Shapes.large)
      .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
      .margin({ bottom: Spacing.sm })

      // Action Buttons
      Row() {
        Button('Add Group')
          .type(ButtonType.Capsule)
          .backgroundColor(AppColors.secondary)
          .fontColor(AppColors.onSecondary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .height(48)
          .onClick(() => {
            const newX = Math.random() * 500 + 50;
            const newY = Math.random() * 300 + 100;
            this.pins.push({ x: newX, y: newY, label: `New Group ${this.pins.length + 1}` });
          })

        Button('Clear')
          .type(ButtonType.Capsule)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .height(48)
          .onClick(() => {
            this.pins = [];
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: Spacing.lg })

      // Active Groups Card
      Column() {
        Text('Active Groups')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg, bottom: Spacing.sm })

        List({ space: Spacing.sm }) {
          ForEach(this.pins, (pin: Pin) => {
            ListItem() {
              Row() {
                Text(pin.label)
                  .fontSize(14)
                  .fontColor(AppColors.onSurface)
                  .layoutWeight(1)
                  .textAlign(TextAlign.Start)

                Circle({ width: 14, height: 14 })
                  .fill(AppColors.primary)
              }
              .width('100%')
              .padding({ left: Spacing.lg, right: Spacing.lg })
            }
          })
        }
        .width('100%')
        .padding({ bottom: Spacing.lg })
      }
      .width('100%')
      .backgroundColor(AppColors.surface)
      .borderRadius(Shapes.large)
      .shadow({ radius: 4, color: '#22000000', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .padding(Spacing.lg)
  }
}