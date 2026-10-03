// src/main/ets/components/AppTokens.ets
/**
 * App design tokens translated from Kotlin/SwiftUI to ArkTS constants.
 */

interface ColorToken {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  displayLarge: TypographyToken;
  headlineMedium: TypographyToken;
  titleMedium: TypographyToken;
  bodyMedium: TypographyToken;
  labelMedium: TypographyToken;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationLevel {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level2: ElevationLevel;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111827',
    onBackground: '#111827',
    onSurface: '#1F2937'
  }

  static readonly TypographyTokens: TypographyTokens = {
    displayLarge: { size: 28, weight: FontWeight.Bold },
    headlineMedium: { size: 20, weight: FontWeight.Medium }, // SemiBold not available in standard ArkTS, using Medium
    titleMedium: { size: 16, weight: FontWeight.Medium },
    bodyMedium: { size: 14, weight: FontWeight.Normal },
    labelMedium: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: ShapeToken = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing: SpacingToken = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static readonly ElevationMapping: ElevationMapping = {
    level2: { radius: 8, dy: 4, opacity: 0.14 }
  }
}

// src/main/ets/model/Medicine.ets
export interface Medicine {
  id: number;
  name: string;
  time: string;
}

// src/main/ets/components/MedicineItem.ets
import { AppTokens } from './AppTokens';
import { Medicine } from '../model/Medicine';

@Component
export struct MedicineItem {
  medicine: Medicine;

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.medicine.time)
          .margin({ top: AppTokens.Spacing.xs })
          .fontSize(AppTokens.TypographyTokens.bodyMedium.size)
          .fontWeight(AppTokens.TypographyTokens.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle()
        .width(16)
        .height(16)
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
  }
}

// src/main/ets/components/MedicineList.ets
import { AppTokens } from './AppTokens';
import { MedicineItem } from './MedicineItem';
import { Medicine } from '../model/Medicine';

@Component
export struct MedicineList {
  items: Medicine[] = [
    { id: 1, name: "Vitamin C", time: "08:00 AM" },
    { id: 2, name: "Aspirin", time: "12:30 PM" },
    { id: 3, name: "Insulin", time: "06:00 PM" },
    { id: 4, name: "Melatonin", time: "10:00 PM" }
  ];

  build() {
    Scroll() {
      Column() {
        ForEach(this.items, (item: Medicine) => {
          MedicineItem({ medicine: item })
            .margin({ bottom: AppTokens.Spacing.md })
        }, (item: Medicine) => item.id.toString())
      }
      .padding({ bottom: AppTokens.Spacing.xxl })
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }
}

// src/main/ets/pages/Index.ets
import { AppTokens } from '../components/AppTokens';
import { MedicineList } from '../components/MedicineList';

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main Content Area
      Column() {
        Column() {
          Text("Medicine Reminder")
            .fontSize(AppTokens.TypographyTokens.displayLarge.size)
            .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .textAlign(TextAlign.Center)
            .margin({ bottom: AppTokens.Spacing.md })

          MedicineList()

          Button("Mark All Taken")
            .type(ButtonType.Capsule)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.titleMedium.size)
            .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
            .height(48)
            .width('80%')
            .margin({ top: 'auto', bottom: AppTokens.Spacing.md })
        }
        .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .linearGradient({
          angle: 90,
          colors: [[AppTokens.Colors.surfaceVariant, 0], [AppTokens.Colors.surface, 1]]
        })
        .width('100%')
        .layoutWeight(1)
        .padding({ bottom: 56 }) // Space for BottomAppBar
      }
      .backgroundColor(AppTokens.Colors.background)
      .width('100%')
      .height('100%')

      // BottomAppBar
      Row() {
        Text("Today")
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.primary)
        
        Text("History")
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text("Profile")
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      // FloatingActionButton
      Button("+")
        .type(ButtonType.Circle)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.displayLarge.size)
        .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
        .width(56)
        .height(56)
        .margin({ right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg + 28 }) // Offset by half FAB height + padding
    }
    .width('100%')
    .height('100%')
  }
}