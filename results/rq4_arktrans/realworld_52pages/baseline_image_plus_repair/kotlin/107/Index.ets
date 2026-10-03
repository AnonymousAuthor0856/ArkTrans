// entry/src/main/ets/viewmodel/AppTokens.ts
export interface ColorConfig {
  primary: string;
  onPrimary: string;
  primaryContainer: string;
  onPrimaryContainer: string;
  secondary: string;
  onSecondary: string;
  secondaryContainer: string;
  onSecondaryContainer: string;
  tertiary: string;
  onTertiary: string;
  error: string;
  onError: string;
  errorContainer: string;
  onErrorContainer: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  onSurfaceVariant: string;
  outline: string;
  outlineVariant: string;
  surfaceContainer: string;
  surfaceDim: string;
}

export interface SpacingConfig {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

export class AppTokens {
  static readonly Colors: ColorConfig = {
    primary: '#1E6D3B',
    onPrimary: '#FFFFFF',
    primaryContainer: '#D7F5D9',
    onPrimaryContainer: '#00210A',
    secondary: '#516351',
    onSecondary: '#FFFFFF',
    secondaryContainer: '#D4E8D3',
    onSecondaryContainer: '#0F1F12',
    tertiary: '#3A656F',
    onTertiary: '#FFFFFF',
    error: '#BA1A1A',
    onError: '#FFFFFF',
    errorContainer: '#FFDAD6',
    onErrorContainer: '#410002',
    background: '#F8FBF1',
    onBackground: '#191D19',
    surface: '#F8FBF1',
    onSurface: '#191D19',
    surfaceVariant: '#DDE5DA',
    onSurfaceVariant: '#424940',
    outline: '#727970',
    outlineVariant: '#C1C9BE',
    surfaceContainer: '#ECF0E6',
    surfaceDim: '#D8DCD3'
  }

  static readonly Spacing: SpacingConfig = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }
}

// entry/src/main/ets/components/CustomSwitch.ets
import { AppTokens } from '../viewmodel/AppTokens';

@Component
export struct CustomSwitch {
  @Prop isChecked: boolean;
  onChange?: (value: boolean) => void;

  build() {
    Row() {
      // Track
      Capsule()
        .width(52)
        .height(32)
        .backgroundColor(this.isChecked ? AppTokens.Colors.primaryContainer : AppTokens.Colors.surfaceVariant)
        .border({ width: this.isChecked ? 0 : 2, color: AppTokens.Colors.outline })
      
      // Thumb
      Circle()
        .width(24)
        .height(24)
        .backgroundColor(this.isChecked ? AppTokens.Colors.primary : AppTokens.Colors.onSurfaceVariant)
        .margin({ left: this.isChecked ? 28 : 4 })
        .animation({ duration: 200 })
    }
    .onClick(() => {
      if (this.onChange) {
        this.onChange(!this.isChecked);
      }
    })
  }
}

// entry/src/main/ets/components/CustomSlider.ets
import { AppTokens } from '../viewmodel/AppTokens';

@Component
export struct CustomSlider {
  @Prop value: number;
  @Prop min: number;
  @Prop max: number;
  onChange?: (value: number) => void;

  private getProgress(): number {
    return (this.value - this.min) / (this.max - this.min);
  }

  build() {
    Column() {
      // Track Background
      Row() {
        // Active Track
        Rect()
          .width(`${this.getProgress() * 100}%`)
          .height(6)
          .borderRadius(3)
          .fill(AppTokens.Colors.primary)
        
        // Inactive Track
        Rect()
          .width(`${(1 - this.getProgress()) * 100}%`)
          .height(6)
          .borderRadius(3)
          .fill(AppTokens.Colors.primaryContainer)
      }
      .width('100%')
      .clip(true)

      // Thumb (Visual only, simplified interaction logic for demo)
      Circle()
        .width(16)
        .height(16)
        .fill(AppTokens.Colors.primary)
        .position({ x: `${this.getProgress() * 100}%`, y: '50%' })
        .translate({ x: -8 }) // Center thumb
    }
    .width('100%')
    .height(40)
    .onClick(() => {
      // Simple toggle for demo purposes between min, mid, max
      let nextVal = this.value + 1;
      if (nextVal > this.max) nextVal = this.min;
      if (this.onChange) {
        this.onChange(nextVal);
      }
    })
  }
}

// entry/src/main/ets/pages/Index.ets
import { AppTokens } from '../viewmodel/AppTokens';
import { CustomSwitch } from '../components/CustomSwitch';
import { CustomSlider } from '../components/CustomSlider';

interface SettingsItem {
  type: 'switch' | 'slider' | 'dropdown' | 'action';
  title: string;
  subtitle: string;
  value?: number | boolean | string;
  options?: string[];
}

interface SettingsGroup {
  title: string;
  items: SettingsItem[];
}

@Entry
@Component
struct SettingsPage {
  // State for Appearance
  @State dynamicColors: boolean = false;
  @State strikethroughChecked: boolean = true;
  @State textSize: number = 15;
  @State previewLabels: number = 2;

  // Data Model
  private groups: SettingsGroup[] = [
    {
      title: 'Appearance',
      items: [
        { type: 'dropdown', title: 'Theme', subtitle: 'Light, dark, or system default', value: 'System', options: ['System', 'Light', 'Dark'] },
        { type: 'switch', title: 'Dynamic colors', subtitle: 'Use Material You colors', value: this.dynamicColors },
        { type: 'switch', title: 'Strikethrough checked', subtitle: 'Strikethrough text on checked items', value: this.strikethroughChecked },
        { type: 'slider', title: 'Text size', subtitle: `Note content text size: ${this.textSize}sp`, value: this.textSize },
        { type: 'slider', title: 'Preview labels', subtitle: `Max labels shown in note card: ${this.previewLabels}`, value: this.previewLabels },
        { type: 'dropdown', title: 'Shown date', subtitle: 'Which date to show on note cards', value: 'Modified', options: ['None', 'Created', 'Modified'] },
      ]
    }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.ic_arrow_back')) // Placeholder for back icon
          .width(24)
          .height(24)
          .fillColor(AppTokens.Colors.onSurface)
        
        Text('Settings')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      List({ space: AppTokens.Spacing.md }) {
        ForEach(this.groups, (group: SettingsGroup) => {
          ListItem() {
            Column() {
              // Group Header
              Row() {
                // Icon placeholder
                Circle().width(20).height(20).fill(AppTokens.Colors.primary)
                Text(group.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.primary)
                  .margin({ left: AppTokens.Spacing.sm })
              }
              .width('100%')
              .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

              // Card Container
              Column() {
                ForEach(group.items, (item: SettingsItem, index: number) => {
                  Column() {
                    this.renderItem(item)
                    
                    // Divider
                    if (index < group.items.length - 1) {
                      Divider()
                        .color(AppTokens.Colors.outlineVariant)
                        .strokeWidth(1)
                        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
                    }
                  }
                })
              }
              .width('100%')
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(12)
              .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  renderItem(item: SettingsItem) {
    Column() {
      Row() {
        Column({ alignItems: ItemAlign.Start }) {
          Text(item.title)
            .fontSize(16)
            .fontColor(AppTokens.Colors.onSurface)
          
          if (item.subtitle) {
            Text(item.subtitle)
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurfaceVariant)
              .margin({ top: 2 })
          }
        }
        .layoutWeight(1)

        if (item.type === 'switch') {
          CustomSwitch({
            isChecked: item.value as boolean,
            onChange: (val: boolean) => {
              if (item.title === 'Dynamic colors') this.dynamicColors = val;
              if (item.title === 'Strikethrough checked') this.strikethroughChecked = val;
            }
          })
        } else if (item.type === 'dropdown') {
          Row() {
            Text(item.value as string)
              .fontSize(14)
              .fontColor(AppTokens.Colors.primary)
            
            Image($r('app.media.ic_chevron_right')) // Placeholder
              .width(18)
              .height(18)
              .fillColor(AppTokens.Colors.onSurfaceVariant)
              .margin({ left: 8 })
          }
        }
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(VerticalAlign.Center)

      if (item.type === 'slider') {
        Column() {
          CustomSlider({
            value: item.value as number,
            min: 0,
            max: 20,
            onChange: (val: number) => {
              if (item.title === 'Text size') this.textSize = val;
              if (item.title === 'Preview labels') this.previewLabels = val;
            }
          })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      }
    }
  }
}